import 'package:json_annotation/json_annotation.dart';
import 'package:qentah_app/models/permission.dart';
import 'package:qentah_app/models/role.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  const User(
      {required this.username,
      required this.email,
      required this.age,
      required this.roles,
      required this.permissions});

  final String username;
  final String email;
  final int age;
  final List<Role> roles;
  final List<Permission> permissions;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
