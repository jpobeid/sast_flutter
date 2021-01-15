import 'package:flutter/material.dart';

AppBar makeSastAppBar(String strPage) {
  const TextStyle styleTitle =
      TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold);
  return AppBar(
    elevation: 0,
    title: Text(
      'SAST - $strPage',
      style: styleTitle,
    ),
    actions: [
      FlatButton(
        onPressed: () {},
        child: Icon(Icons.login),
      ),
      FlatButton(
        onPressed: () {},
        child: Icon(Icons.logout),
      ),
      FlatButton(
        onPressed: () {},
        child: Icon(Icons.people),
      ),
    ],
  );
}
