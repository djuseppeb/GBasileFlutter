import 'package:json_annotation/json_annotation.dart';
import 'package:social_network/models/comment.dart';

part 'comment_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentResponse {
  final List<Comment> data;
  final int total;
  final int page;
  final int limit;

  const CommentResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommentResponseToJson(this);
}
