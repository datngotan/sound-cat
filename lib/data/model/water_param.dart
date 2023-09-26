import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'water_param.g.dart';

@JsonSerializable()
class WaterParam extends Equatable {
  final String header;
  @JsonKey(name: 'signal-mark-base')
  final String signalMarkBase;
  @JsonKey(name: 'sound-cat-start')
  final String soundCatStart;
  @JsonKey(name: 'signal-go')
  final String signalGo;
  final int noiceThreshold;

  const WaterParam({
    required this.header,
    required this.signalMarkBase,
    required this.soundCatStart,
    required this.signalGo,
    required this.noiceThreshold,
  });

  @override
  List<Object?> get props =>
      [header, signalMarkBase, soundCatStart, signalGo, noiceThreshold];

  factory WaterParam.fromJson(Map<String, dynamic> json) =>
      _$WaterParamFromJson(json);

  Map<String, dynamic> toJson() => _$WaterParamToJson(this);
}
