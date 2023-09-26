import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'race_detail.g.dart';

@JsonSerializable()
class RaceDetails extends Equatable {
  final String venue;
  final List<double> racetimes;
  final String racedateYMD;
  final String racecount;
  @JsonKey(name: 'ranrace')
  final String ranRace;
  @JsonKey(name: 'isLastRaceRan')
  final bool isLastRaceRan;
  @JsonKey(name: 'isOverseaMeeting')
  final bool isOverseaMeeting;

  RaceDetails({
    required this.venue,
    required this.racetimes,
    required this.racedateYMD,
    required this.racecount,
    required this.ranRace,
    required this.isLastRaceRan,
    required this.isOverseaMeeting,
  });

  @override
  List<Object?> get props => [
        venue,
        racetimes,
        racedateYMD,
        racecount,
        ranRace,
        isLastRaceRan,
        isOverseaMeeting
      ];

  factory RaceDetails.fromJson(Map<String, dynamic> json) =>
      _$RaceDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$RaceDetailsToJson(this);
}