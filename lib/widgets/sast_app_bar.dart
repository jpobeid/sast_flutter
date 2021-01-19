import 'package:flutter/material.dart';

AppBar makeSastAppBar(String strPage, bool canLogout) {
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
              onPressed: () {},
            ),
          ]
        : [],
  );
}
