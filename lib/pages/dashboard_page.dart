import 'package:flutter/material.dart';
import 'package:sast_project/widgets/sast_app_bar.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName = '/dashboard-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeSastAppBar('Dashboard', true),
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
