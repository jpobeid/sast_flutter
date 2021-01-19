import 'package:flutter/material.dart';
import 'package:sast_project/pages/login_page.dart';
import 'package:sast_project/pages/register_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (_) => LoginPage());
        break;
      case RegisterPage.routeName:
        return MaterialPageRoute(builder: (_) => RegisterPage());
        break;
      default:
        return null;
        break;
    }
  }
}
