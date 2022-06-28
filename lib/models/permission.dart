import 'package:json_annotation/json_annotation.dart';

part 'permission.g.dart';

@JsonSerializable()
class Permission {
  const Permission(this.id, {this.name, this.description});
  final String id;
  final String? name;
  final String? description;

  factory Permission.fromJson(Map<String, dynamic> json) =>
      _$PermissionFromJson(json);
  Map<String, dynamic> toJson() => _$PermissionToJson(this);
}
