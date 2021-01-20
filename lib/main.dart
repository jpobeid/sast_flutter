import 'package:flutter/material.dart';
import 'package:sast_project/pages/dashboard_page.dart';
import 'package:sast_project/pages/login_page.dart';
import 'package:sast_project/functions/route_generator.dart';

import 'pages/dashboard_page.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.indigo,
      scaffoldBackgroundColor: Colors.black,
    ),
    title: 'SAST',
    home: DashboardPage(),
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}