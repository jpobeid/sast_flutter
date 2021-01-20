import 'dart:convert';
import 'dart:core';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sast_project/data/layout_data.dart' as layouts;
import 'package:sast_project/data/http_data.dart' as httpData;
import 'package:sast_project/widgets/sast_app_bar.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register-page';
  static const String strUrlAppendix = '/register';

  static const List<int> listFlexVertical = [3, 1, 3, 3, 1, 2, 2];
  static const Map<int, Map<int, String>> mapMapLabel = {
    0: {0: 'Email', 1: 'Token'},
    1: {0: 'Email', 1: 'Token'},
    2: {0: 'Password', 1: 'Re-enter password'},
  };
  static const Map<int, String> mapRegisterButtonLabel = {
    0: 'Get token',
    1: 'Enter',
    2: 'Register'
  };

  //List will be input properties (maxLength, obscureText, Icon)
  static const Map<String, List<dynamic>> mapInputProperties = {
    'Email': [35, false, Icons.email],
    'Token': [6, true, Icons.code],
    'Password': [20, true, Icons.visibility_off],
    'Re-enter password': [20, true, Icons.visibility_off],
  };

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _controllerField0 = TextEditingController(text: '');
  final TextEditingController _controllerField1 = TextEditingController(text: '');

  int _nPhase = 0;
  bool _isUsernamePermitted = false;
  String _strUsername;
  bool _isRegisterButtonEnabled = true;

  @override
  void dispose() {
    _controllerField0.dispose();
    _controllerField1.dispose();
    super.dispose();
  }

  Future<void> onRegisterButtonPressed() async {
    switch (_nPhase) {
      case 0:
        http.Response response =
            await trySendHttpPost(json.encode({'email': _controllerField0.text}));
        if (response != null) {
          _isUsernamePermitted = response.statusCode == 200;
          if (_isUsernamePermitted) {
            setState(() {
              _nPhase++;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('6-digit verification token sent to ${_controllerField0.text}'),
                backgroundColor: Colors.green,
                duration: Duration(milliseconds: 5000),
              ),
            );
          } else if (response.statusCode == 401) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Email address unauthorized for access'),
                backgroundColor: Colors.redAccent,
                duration: Duration(milliseconds: layouts.nLoginRegisterDurationSnackBarLong),
              ),
            );
          } else if (response.statusCode == 409) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Email address already registered'),
                backgroundColor: Colors.redAccent,
                duration: Duration(milliseconds: layouts.nLoginRegisterDurationSnackBarLong),
              ),
            );
          }
        }
        break;
      case 1:
        http.Response response = await trySendHttpPost(
            json.encode({'email': _controllerField0.text, 'token': _controllerField1.text}));
        bool isTokenCorrect = response.statusCode == 200;
        if (isTokenCorrect) {
          setState(() {
            _nPhase++;
            _strUsername = _controllerField0.text;
            _controllerField0.clear();
            _controllerField1.clear();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Incorrect token'),
              backgroundColor: Colors.redAccent,
              duration: Duration(milliseconds: layouts.nLoginRegisterDurationSnackBarLong),
            ),
          );
        }
        break;
      case 2:
        bool isPasswordsMatching = _controllerField0.text == _controllerField1.text;
        bool isPasswordValid = _controllerField0.text.length > 6;
        if (isPasswordsMatching && isPasswordValid) {
          String hashedPass = crypto.sha256.convert(utf8.encode(_controllerField0.text)).toString();
          http.Response response =
              await trySendHttpPost(json.encode({'email': _strUsername, 'hashedPass': hashedPass}));
          if (response.statusCode == 200) {
            Navigator.of(context).pushReplacementNamed('/login-page');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Account successfully created!'),
                backgroundColor: Colors.green,
                duration: Duration(milliseconds: layouts.nLoginRegisterDurationSnackBarLong),
              ),
            );
          }
        } else if (!isPasswordsMatching) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Passwords not matching'),
              backgroundColor: Colors.redAccent,
              duration: Duration(milliseconds: layouts.nLoginRegisterDurationSnackBarLong),
            ),
          );
        } else if (!isPasswordValid) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please choose stronger password'),
              backgroundColor: Colors.redAccent,
              duration: Duration(milliseconds: layouts.nLoginRegisterDurationSnackBarLong),
            ),
          );
        }
        break;
    }
  }

  Future<http.Response> trySendHttpPost(dynamic httpBody) async {
    http.Response response;
    setState(() {
      _isRegisterButtonEnabled = false;
    });
    try {
      response = await http.post(
        httpData.strUrlBase + RegisterPage.strUrlAppendix + '/$_nPhase',
        headers: httpData.mapHttpHeader,
        body: httpBody,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network error: $e'),
          backgroundColor: Colors.red,
          duration: Duration(milliseconds: layouts.nLoginRegisterDurationSnackBarLong),
        ),
      );
    } finally {
      setState(() {
        _isRegisterButtonEnabled = true;
      });
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: makeSastAppBar(context, 'Register', false),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
            layouts.colorLoginRegisterGradient0,
            layouts.colorLoginRegisterGradient1,
          ]),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(layouts.sizeLoginRegisterContainerRadius),
            ),
            height: math.min(layouts.fractionLoginRegisterSizeContainer * sizeHeight,
                layouts.listLoginRegisterMaxSizeContainer[0]),
            width: math.min(layouts.fractionLoginRegisterSizeContainer * sizeWidth,
                layouts.listLoginRegisterMaxSizeContainer[1]),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: RegisterPage.listFlexVertical[0],
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: layouts.styleHead,
                        ),
                      ),
                    ),
                    Spacer(
                      flex: RegisterPage.listFlexVertical[1],
                    ),
                    Expanded(
                      flex: RegisterPage.listFlexVertical[2],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LimitedBox(
                            child: TextField(
                              controller: _controllerField0,
                              decoration: InputDecoration(
                                labelText: RegisterPage.mapMapLabel[_nPhase][0],
                                labelStyle: layouts.styleLabel,
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              enabled: _nPhase != 1,
                              style: layouts.styleLabel,
                              maxLength: RegisterPage
                                  .mapInputProperties[RegisterPage.mapMapLabel[_nPhase][0]][0],
                              obscureText: RegisterPage
                                  .mapInputProperties[RegisterPage.mapMapLabel[_nPhase][0]][1],
                            ),
                            maxWidth: constraints.maxWidth * layouts.fractionLoginRegisterSizeLabel,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            RegisterPage.mapInputProperties[RegisterPage.mapMapLabel[_nPhase][0]]
                                [2],
                            size: layouts.sizeLoginRegisterIcon,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: RegisterPage.listFlexVertical[3],
                      child: _isUsernamePermitted
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LimitedBox(
                                  child: TextField(
                                    controller: _controllerField1,
                                    decoration: InputDecoration(
                                      labelText: RegisterPage.mapMapLabel[_nPhase][1],
                                      labelStyle: layouts.styleLabel,
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                    ),
                                    style: layouts.styleLabel,
                                    maxLength: RegisterPage.mapInputProperties[
                                        RegisterPage.mapMapLabel[_nPhase][1]][0],
                                    obscureText: RegisterPage.mapInputProperties[
                                        RegisterPage.mapMapLabel[_nPhase][1]][1],
                                  ),
                                  maxWidth:
                                      constraints.maxWidth * layouts.fractionLoginRegisterSizeLabel,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  RegisterPage
                                      .mapInputProperties[RegisterPage.mapMapLabel[_nPhase][1]][2],
                                  size: layouts.sizeLoginRegisterIcon,
                                ),
                              ],
                            )
                          : Container(),
                    ),
                    Spacer(
                      flex: RegisterPage.listFlexVertical[4],
                    ),
                    Expanded(
                      flex: RegisterPage.listFlexVertical[5],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Spacer(
                            flex: layouts.listLoginRegisterFlexRow[0],
                          ),
                          Expanded(
                            flex: layouts.listLoginRegisterFlexRow[1],
                            child: FractionallySizedBox(
                              widthFactor: 0.8,
                              heightFactor: 0.8,
                              child: RaisedButton(
                                child: Text(
                                  _isRegisterButtonEnabled
                                      ? RegisterPage.mapRegisterButtonLabel[_nPhase]
                                      : 'Wait...',
                                  style: layouts.styleButton,
                                ),
                                color: Colors.lightBlue,
                                onPressed:
                                    _isRegisterButtonEnabled ? onRegisterButtonPressed : () => {},
                              ),
                            ),
                          ),
                          Expanded(
                            flex: layouts.listLoginRegisterFlexRow[2],
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Already have an account? ',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Login',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacementNamed(context, '/login-page');
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
                      flex: RegisterPage.listFlexVertical[6],
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
