import 'package:json_annotation/json_annotation.dart';
import 'package:social_network/models/user.dart';

part 'user_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UserResponse {
  final List<User> data;
  final int total;
  final int page;
  final int number;

  const UserResponse({
    required this.data,
    required this.total,
    required this.page,
    required this.number,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
