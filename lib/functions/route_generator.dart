import 'package:flutter/material.dart';
import 'package:sast_project/pages/dashboard_page.dart';
import 'package:sast_project/pages/login_page.dart';
import 'package:sast_project/pages/register_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final List<dynamic> args = settings.arguments;
    switch (settings.name) {
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (_) => LoginPage());
        break;
      case RegisterPage.routeName:
        return MaterialPageRoute(builder: (_) => RegisterPage());
        break;
      case DashboardPage.routeName:
        if (args == null) {
          return MaterialPageRoute(builder: (_) => DashboardPage());
        } else {
          return MaterialPageRoute(
              builder: (_) => DashboardPage(
                    strUserEmail: args[0],
                    strUserJwt: args[1],
                  ));
        }
        break;
      default:
        return null;
        break;
    }
  }
}
