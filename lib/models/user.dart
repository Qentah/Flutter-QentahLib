import 'package:json_annotation/json_annotation.dart';
import 'package:qentah_app/models/permission.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  User(
      {required this.id,
      this.data,
      this.group,
      List<Permission> permissions = const []}) {
    this.permissions.addAll(permissions);
  }

  final String id;
  final String? data;
  final int? group;
  List<Permission> permissions = [];

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

class GlobalUser {
  static final GlobalUser _singleton = GlobalUser._internal();

  static var instance = User(
    id: '0',
    permissions: [
      const Permission('0', name: "basic-permission", description: ""),
    ],
  );

  factory GlobalUser() {
    return _singleton;
  }

  GlobalUser._internal();
}
