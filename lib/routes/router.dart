import 'package:flutter/material.dart';
import 'package:qentah_app/main.dart';
import 'package:qentah_app/pages/first_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (Uri.parse(settings.name!).path) {
    case '/':
    case MainPage.url:
      return MaterialPageRoute(builder: (_) => MainPage(settings: settings));
    case FirstPage.url:
      return MaterialPageRoute(builder: (_) => FirstPage(settings: settings));
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text(
                        'Error 404 ! No route defined for ${settings.name}')),
              ));
  }
}
