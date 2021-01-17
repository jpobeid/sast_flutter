import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sast_project/widgets/sast_app_bar.dart';
import 'dart:math' as math;

class LoginPage extends StatefulWidget {
  static const Color colorGradient0 = Color.fromARGB(255, 150, 30, 240);
  static const Color colorGradient1 = Color.fromARGB(255, 40, 0, 140);
  static const double fractionSizeContainer = 0.5;
  static const List<double> listMaxSizeContainer = [400, 600];
  static const double sizeContainerRadius = 15;
  static const List<int> listFlexVertical = [3, 1, 3, 3, 1, 2, 2];
  static const List<int> listFlexRow = [1, 2, 4];
  static const TextStyle styleHead =
      TextStyle(color: Colors.black, fontSize: 34, fontWeight: FontWeight.bold);
  static const TextStyle styleLabel = TextStyle(
      color: Color.fromARGB(255, 80, 80, 80),
      fontSize: 18,
      fontWeight: FontWeight.normal);
  static const TextStyle styleButton = TextStyle(
      color: Color.fromARGB(255, 25, 25, 25),
      fontSize: 18,
      fontWeight: FontWeight.bold);
  static const double fractionSizeLabel = 0.6;
  static const double sizeIcon = 38;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerUsername =
      TextEditingController(text: '');
  final TextEditingController _controllerPassword =
      TextEditingController(text: '');
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  @override
  void dispose() {
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    print(_databaseReference);

    return Scaffold(
      appBar: makeSastAppBar('Login'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                LoginPage.colorGradient0,
                LoginPage.colorGradient1,
              ]),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(LoginPage.sizeContainerRadius),
            ),
            height: math.min(LoginPage.fractionSizeContainer * sizeHeight,
                LoginPage.listMaxSizeContainer[0]),
            width: math.min(LoginPage.fractionSizeContainer * sizeWidth,
                LoginPage.listMaxSizeContainer[1]),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: LoginPage.listFlexVertical[0],
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: LoginPage.styleHead,
                        ),
                      ),
                    ),
                    Spacer(
                      flex: LoginPage.listFlexVertical[1],
                    ),
                    Expanded(
                      flex: LoginPage.listFlexVertical[2],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LimitedBox(
                            child: TextField(
                              controller: _controllerUsername,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: LoginPage.styleLabel,
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              style: LoginPage.styleLabel,
                              maxLength: 35,
                            ),
                            maxWidth: constraints.maxWidth *
                                LoginPage.fractionSizeLabel,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.email,
                            size: LoginPage.sizeIcon,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: LoginPage.listFlexVertical[3],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LimitedBox(
                            child: TextField(
                              controller: _controllerPassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: LoginPage.styleLabel,
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              style: LoginPage.styleLabel,
                              maxLength: 20,
                              obscureText: true,
                            ),
                            maxWidth: constraints.maxWidth *
                                LoginPage.fractionSizeLabel,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.visibility_off,
                            size: LoginPage.sizeIcon,
                          ),
                        ],
                      ),
                    ),
                    Spacer(
                      flex: LoginPage.listFlexVertical[4],
                    ),
                    Expanded(
                      flex: LoginPage.listFlexVertical[5],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Spacer(
                            flex: LoginPage.listFlexRow[0],
                          ),
                          Expanded(
                            flex: LoginPage.listFlexRow[1],
                            child: FractionallySizedBox(
                              widthFactor: 0.8,
                              heightFactor: 0.8,
                              child: RaisedButton(
                                child: Text(
                                  'Login',
                                  style: LoginPage.styleButton,
                                ),
                                color: Colors.lightBlue,
                                onPressed: () async {
                                  DataSnapshot snapshot = await _databaseReference.once();
                                  print('here');
                                  print(snapshot.value);
                                  print(_controllerUsername.text);
                                  print(_controllerPassword.text);
                                  if (true) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Successful login!'),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: LoginPage.listFlexRow[2],
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Need to create an account? ',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Register',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print('Go to register page!');
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(
                      flex: LoginPage.listFlexVertical[6],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
