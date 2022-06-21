import 'package:json_annotation/json_annotation.dart';

part 'machine_types.g.dart';

@JsonSerializable()
class MachineTypes {
  const MachineTypes(this.id, this.type);
  @JsonKey(name: 'ID')
  final int id;
  @JsonKey(name: 'TYPE')
  final String type;

  factory MachineTypes.fromJson(Map<String, dynamic> json) =>
      _$MachineTypesFromJson(json);
  Map<String, dynamic> toJson() => _$MachineTypesToJson(this);
}
