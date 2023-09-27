part of 'sound_cat_bloc.dart';

class SoundCatState extends Equatable {
  SoundCatState({
    this.waterParam,
    this.raceDetails,
    this.raceNo,
    this.status,
    this.isPrecheck = false,
  });

  final WaterParam? waterParam;
  final RaceDetails? raceDetails;
  int? raceNo;
  bool isPrecheck;
  String? status;

  @override
  List<Object?> get props => [
        waterParam,
        raceDetails,
        isPrecheck,
        raceNo,
        status,
      ];

  SoundCatState copyWith({
    WaterParam? waterParam,
    RaceDetails? raceDetails,
    bool? isPrecheck,
    String? status,
  }) {
    return SoundCatState(
      waterParam: waterParam ?? this.waterParam,
      raceDetails: raceDetails ?? this.raceDetails,
      isPrecheck: isPrecheck ?? this.isPrecheck,
      status: status ?? this.status,
      raceNo: raceNo,
    );
  }

  SoundCatState increaseRaceNo() {
    if (raceNo == null && raceDetails != null) {
      raceNo = int.tryParse(raceDetails!.ranRace);
    }
    if (raceNo != null) {
      raceNo = raceNo! + 1;
    }
    return this;
  }
}
