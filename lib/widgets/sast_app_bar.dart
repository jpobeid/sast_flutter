import 'package:flutter/material.dart';
import 'package:sast_project/data/layout_data.dart' as layouts;

AppBar makeSastAppBar(BuildContext context, String strPage, bool canLogout) {
  const TextStyle styleTitle =
      TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold);
  return AppBar(
    elevation: 0,
    title: Text(
      'SAST - $strPage',
      style: styleTitle,
    ),
    actions: canLogout
        ? [
            FlatButton.icon(
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/login-page');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Successful logout'),
                    backgroundColor: Colors.green,
                    duration: Duration(milliseconds: layouts.nLoginRegisterDurationSnackBarLong),
                  ),
                );
              },
            ),
          ]
        : [],
  );
}
