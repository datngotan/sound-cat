// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RaceDetails _$RaceDetailsFromJson(Map<String, dynamic> json) => RaceDetails(
      venue: json['venue'] as String,
      racetimes: (json['racetimes'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      racedateYMD: json['racedateYMD'] as String,
      racecount: json['racecount'] as String,
      ranRace: json['ranrace'] as String,
      isLastRaceRan: json['isLastRaceRan'] as bool,
      isOverseaMeeting: json['isOverseaMeeting'] as bool,
    );

Map<String, dynamic> _$RaceDetailsToJson(RaceDetails instance) =>
    <String, dynamic>{
      'venue': instance.venue,
      'racetimes': instance.racetimes,
      'racedateYMD': instance.racedateYMD,
      'racecount': instance.racecount,
      'ranrace': instance.ranRace,
      'isLastRaceRan': instance.isLastRaceRan,
      'isOverseaMeeting': instance.isOverseaMeeting,
    };
