import 'package:json_annotation/json_annotation.dart';

part 'hair.g.dart';

@JsonSerializable()
class Hair{
  final String color;
  final String hair;

  const Hair({required this.color, required this.hair});

  factory Hair.fromJson(Map<String, dynamic> json) => _$HairFromJson(json);

  Map<String, dynamic> toJson() => _$HairToJson(this);
}
