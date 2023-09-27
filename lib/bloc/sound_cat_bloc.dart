import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:sound_cat/data/model/race_detail.dart';
import 'package:sound_cat/data/model/water_param.dart';
import 'package:sound_cat/data/repository/repository.dart';
import 'package:intl/intl.dart';
part 'sound_cat_event.dart';
part 'sound_cat_state.dart';

class SoundCatBloc extends Bloc<SoundCatEvent, SoundCatState> {
  SoundCatBloc() : super(SoundCatState()) {
    on<GetWaterParamsEvent>(getWaterParamsEvent, transformer: restartable());
    on<GetRaceDetailEvent>(getRaceDetailEvent, transformer: restartable());
    on<IncreaseRaceNoEvent>(increaseRaceNoEvent, transformer: restartable());
    on<CheckPreConditionEvent>(checkPreConditionEvent,
        transformer: restartable());
    on<NotifyStartSoundCatEvent>(notifyStartSoundCatEvent,
        transformer: restartable());
    on<NotifySignalGoEvent>(notifySignalGoEvent, transformer: restartable());
    on<UpdateIsPreCheck>(updateIsPreCheck, transformer: restartable());
  }
  Timer? timer;

  FutureOr<void> getWaterParamsEvent(
      GetWaterParamsEvent event, Emitter<SoundCatState> emit) async {
    WaterParam? waterParam = await Repository.getWaterParam();
    emit(state.copyWith(
      waterParam: waterParam,
      status: 'get waterParam',
    ));
    final header = waterParam?.header;
    if (header != null) {
      await getRaceDetailEvent(GetRaceDetailEvent(raceDetailUrl: header), emit);
      await increaseRaceNoEvent(const IncreaseRaceNoEvent(), emit);
      await checkPreConditionEvent(const CheckPreConditionEvent(), emit);
    }
  }

  FutureOr<void> getRaceDetailEvent(
      GetRaceDetailEvent event, Emitter<SoundCatState> emit) async {
    RaceDetails? raceDetails =
        await Repository.getRaceDetail(event.raceDetailUrl);
    emit(state.copyWith(
      raceDetails: raceDetails,
      status: 'get race details',
    ));
  }

  FutureOr<void> increaseRaceNoEvent(
      IncreaseRaceNoEvent event, Emitter<SoundCatState> emit) {
    emit(state.increaseRaceNo());
  }

  FutureOr<void> checkPreConditionEvent(
      CheckPreConditionEvent event, Emitter<SoundCatState> emit) async {
    final ranRace = state.raceNo;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyyMMdd').format(now);
    final checkUrl =
        'http://103.68.61.166:8080/jump/${formattedDate}_${ranRace}pre.txt';
    if (ranRace != null) {
      timer?.cancel();
      await Repository.checkSuccessCode(
        checkUrl,
      ).then((isPreCheck) {
        if (isPreCheck) {
          emit(state.copyWith(isPrecheck: true, status: 'check success'));
        } else {
          add(
            UpdateIsPreCheck(
                isPrecheck: false, msg: 'check failed, loop 5s to retry time'),
          );
          int count = 0;
          timer = Timer.periodic(const Duration(seconds: 5), (t) async {
            await Repository.checkSuccessCode(
              checkUrl,
            ).then((isPreCheck2) {
              if (isPreCheck2) {
                t.cancel();
                emit(state.copyWith(
                  isPrecheck: true,
                  status: 'check success',
                ));
              } else {
                count++;
                add(
                  UpdateIsPreCheck(
                      isPrecheck: false,
                      msg: 'check failed, loop 5s to retry time $count'),
                );
              }
            });
          });
        }
      });
    }
  }

  FutureOr<void> notifyStartSoundCatEvent(
      NotifyStartSoundCatEvent event, Emitter<SoundCatState> emit) async {
    final soundCatStart = state.waterParam?.soundCatStart;
    if (soundCatStart != null) {
      await Repository.notify(soundCatStart);
      emit(state.copyWith(
        status: 'notify sound cat start  $soundCatStart',
      ));
    }
  }

  FutureOr<void> notifySignalGoEvent(
      NotifySignalGoEvent event, Emitter<SoundCatState> emit) async {
    final signalGo = state.waterParam?.signalGo;
    if (signalGo != null) {
      await Repository.notify(signalGo);
    }
    emit(state.copyWith(
      isPrecheck: false,
      status: 'notify signalGo $signalGo',
    ));
    await checkPreConditionEvent(const CheckPreConditionEvent(), emit);
  }

  FutureOr<void> updateIsPreCheck(
      UpdateIsPreCheck event, Emitter<SoundCatState> emit) {
    emit(state.copyWith(
      isPrecheck: event.isPrecheck,
      status: event.msg,
    ));
  }
}
