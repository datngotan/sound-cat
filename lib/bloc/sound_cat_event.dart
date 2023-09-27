part of 'sound_cat_bloc.dart';

sealed class SoundCatEvent extends Equatable {
  const SoundCatEvent();

  @override
  List<Object> get props => [];
}

class GetWaterParamsEvent extends SoundCatEvent {
  const GetWaterParamsEvent();
}

class GetRaceDetailEvent extends SoundCatEvent {
  GetRaceDetailEvent({required this.raceDetailUrl});
  String raceDetailUrl;
}

class IncreaseRaceNoEvent extends SoundCatEvent {
  const IncreaseRaceNoEvent();
}

class CheckPreConditionEvent extends SoundCatEvent {
  const CheckPreConditionEvent();
}

class NotifyStartSoundCatEvent extends SoundCatEvent {
  const NotifyStartSoundCatEvent();
}

class NotifySignalGoEvent extends SoundCatEvent {
  const NotifySignalGoEvent();
}

class UpdateIsPreCheck extends SoundCatEvent {
  UpdateIsPreCheck({required this.msg, required this.isPrecheck});
  String msg;
  bool isPrecheck;
}
