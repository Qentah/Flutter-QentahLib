import 'package:flutter/material.dart';
import 'package:qentah_app/main.dart';
import 'package:qentah_app/models/user.dart';
import 'package:qentah_app/test/user.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final url = Uri.parse(settings.name!).path;

  final Map<String, Widget> routes = {
    '/': MainPage(settings: settings),
    '/main': MainPage(settings: settings),
  };

  return MaterialPageRoute(
      builder: (_) => routes.containsKey(url)
          ? haveUrlAccess(url)
              ? routes[url]!
              : const ErrorPermission()
          : Error404(
              settings: settings,
            ));
}

bool haveUrlAccess(String url) {
  final user = User.fromJson(jUser); //TODO fetch from db

  final Map<String, List<int>> permissions = {
    '/': [0],
    '/main': [0],
  };

  final setRolesPerms = user.roles
      .map((e) => e.permissions.map((e) => e.id))
      .expand((i) => i)
      .toSet();
  final setUserPerms = user.permissions.map((e) => e.id).toSet();
  final setUrlPerms = permissions[url]?.toSet() ?? {};

  return setUserPerms.union(setRolesPerms).intersection(setUrlPerms).isNotEmpty;
}

class Error404 extends StatelessWidget {
  const Error404({
    Key? key,
    required this.settings,
  }) : super(key: key);

  final RouteSettings settings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text('Error 404 ! No route defined for ${settings.name}')),
    );
  }
}

class ErrorPermission extends StatelessWidget {
  const ErrorPermission({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Error Permissions ! Not enought permissions')),
    );
  }
}
