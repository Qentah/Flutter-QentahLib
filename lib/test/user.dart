import 'package:qentah_app/models/permission.dart';
import 'package:qentah_app/models/role.dart';
import 'package:qentah_app/models/user.dart';

final jUserAdmin = const User(
  username: "Quentin",
  email: "henryq.public@outlook.fr",
  age: 21,
  roles: [
    Role("admin", [
      Permission(1, "admin-access"),
    ]),
    Role("modo", [
      Permission(2, "modo-access"),
    ]),
  ],
  permissions: [
    Permission(0, "basic-permission"),
  ],
).toJson();

final jUser = const User(
  username: "Quentin",
  email: "henryq.public@outlook.fr",
  age: 21,
  roles: [
    Role("user", [
      Permission(0, "basic-permission"),
    ]),
  ],
  permissions: [
    Permission(1, "admin-access"),
  ],
).toJson();
