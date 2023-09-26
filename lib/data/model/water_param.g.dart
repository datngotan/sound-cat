// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'water_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaterParam _$WaterParamFromJson(Map<String, dynamic> json) => WaterParam(
      header: json['header'] as String,
      signalMarkBase: json['signal-mark-base'] as String,
      soundCatStart: json['sound-cat-start'] as String,
      signalGo: json['signal-go'] as String,
      noiceThreshold: json['noiceThreshold'] as int,
    );

Map<String, dynamic> _$WaterParamToJson(WaterParam instance) =>
    <String, dynamic>{
      'header': instance.header,
      'signal-mark-base': instance.signalMarkBase,
      'sound-cat-start': instance.soundCatStart,
      'signal-go': instance.signalGo,
      'noiceThreshold': instance.noiceThreshold,
    };
