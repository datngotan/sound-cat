part of 'sound_cat_bloc.dart';

sealed class SoundCatState extends Equatable {
  const SoundCatState();
  
  @override
  List<Object> get props => [];
}

final class SoundCatInitial extends SoundCatState {}
