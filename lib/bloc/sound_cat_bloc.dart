import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sound_cat_event.dart';
part 'sound_cat_state.dart';

class SoundCatBloc extends Bloc<SoundCatEvent, SoundCatState> {
  SoundCatBloc() : super(SoundCatInitial()) {
    on<SoundCatEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
