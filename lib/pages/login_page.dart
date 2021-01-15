import 'package:flutter/material.dart';
import 'package:sast_project/widgets/sast_app_bar.dart';

class LoginPage extends StatelessWidget {
  static const colorGradient0 = Color.fromARGB(255, 150, 30, 240);
  static const colorGradient1 = Color.fromARGB(255, 40, 0, 140);
  static const TextStyle styleHead =
      TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold);
  static const TextStyle styleLabel = TextStyle(
      color: Color.fromARGB(255, 80, 80, 80),
      fontSize: 18,
      fontWeight: FontWeight.normal);
  static const double sizeContainerRadius = 10;
  static const double sizeContainerPadding = 20;

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: makeSastAppBar('Login'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorGradient0,
                colorGradient1,
              ]),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(sizeContainerRadius),
            ),
            width: sizeWidth * 0.5,
            height: sizeHeight * 0.5,
            padding: EdgeInsets.all(sizeContainerPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Login',
                  style: styleHead,
                ),
                Text(
                  'Username',
                  style: styleLabel,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LimitedBox(
                      child: TextField(),
                      maxWidth: sizeWidth * 0.5 * 0.5,
                    ),
                    Icon(Icons.email),
                  ],
                ),
                Text(
                  'Password',
                  style: styleLabel,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LimitedBox(
                      child: TextField(
                        maxLength: 20,
                        obscureText: true,
                      ),
                      maxWidth: sizeWidth * 0.5 * 0.5,
                    ),
                    Icon(Icons.visibility_off),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
