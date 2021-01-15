import 'package:flutter/material.dart';
import 'package:sast_project/pages/login_page.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.indigo,
      scaffoldBackgroundColor: Colors.black,
    ),
    title: 'SAST',
    home: LoginPage(),
  ));
}