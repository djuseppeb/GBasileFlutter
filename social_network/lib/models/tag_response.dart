import 'package:json_annotation/json_annotation.dart';

part 'tag_response.g.dart';

@JsonSerializable()
class TagResponse {
  final List<String> data;
  final int total;
  final int page;
  final int number;

  const TagResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.number,
  });

  factory TagResponse.fromJson(Map<String, dynamic> json) =>
      _$TagResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TagResponseToJson(this);
}
