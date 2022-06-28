import 'package:flutter/material.dart';
import 'package:qentah_app/main.dart';
import 'package:qentah_app/models/user.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final url = Uri.parse(settings.name!).path;
  final user = GlobalUser.instance;

  final Map<String, Widget> routes = {
    '/': MainPage(settings: settings),
    '/page': Scaffold(
      body: Center(
        child: Text(
            "Private access : Welcome Sir ${user.data} from GROUP ${user.group} "),
      ),
    ),
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
  final user = GlobalUser.instance;

  final Map<String, List<String>> permissions = {
    '/': ["0"],
    '/page': ["IPRXX"],
  };

  final setUserPerms = user.permissions.map((e) => e.id).toSet();
  final setUrlPerms = permissions[url]?.toSet() ?? {};

  return setUserPerms.intersection(setUrlPerms).isNotEmpty;
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
