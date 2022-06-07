import 'dart:math' as math;
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sast_project/data/layout_data.dart' as layouts;
import 'package:sast_project/widgets/sast_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:sast_project/data/http_data.dart' as httpData;
import 'package:crypto/crypto.dart' as crypto;

class LoginPage extends StatefulWidget {
  static const String routeName = '/login-page';
  static const String strUrlAppendix = '/login';
  static const List<int> listFlexVertical = [3, 1, 3, 3, 1, 2, 2];

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerUsername =
      TextEditingController(text: '');
  final TextEditingController _controllerPassword =
      TextEditingController(text: '');

  bool _isLoginButtonEnabled = true;

  @override
  void dispose() {
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  Future<void> onLoginButtonPressed() async {
    setState(() {
      _isLoginButtonEnabled = false;
    });
    http.Response response;
    try {
      response = await http.post(
          httpData.urlBase +
              httpData.urlExtensionUser +
              LoginPage.strUrlAppendix +
              '/0',
          headers: httpData.mapHttpHeader,
          body: json.encode({
            'email': _controllerUsername.text,
            'hashedPass': crypto.sha256
                .convert(utf8.encode(_controllerPassword.text))
                .toString()
          }));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network error: $e'),
          backgroundColor: Colors.red,
          duration: Duration(
              milliseconds: layouts.nLoginRegisterDurationSnackBarLong),
        ),
      );
    } finally {
      setState(() {
        _controllerPassword.clear();
        _isLoginButtonEnabled = true;
      });
    }
    if (response != null) {
      if (response.statusCode == 200) {
        Map<String, dynamic> mapResponse = json.decode(response.body);
        String userEmail = _controllerUsername.text;
        String userToken = mapResponse['token'];
        String userPin = mapResponse['pin'];
        Navigator.of(context).pushReplacementNamed('/dashboard-page',
            arguments: [userEmail, userToken, userPin]);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successful login'),
            backgroundColor: Colors.green,
            duration: Duration(
                milliseconds: layouts.nLoginRegisterDurationSnackBarShort),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Incorrect login credentials or account not registered'),
            backgroundColor: Colors.red,
            duration: Duration(
                milliseconds: layouts.nLoginRegisterDurationSnackBarLong),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: makeSastAppBar(context, 'Login', false),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
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
              borderRadius: BorderRadius.circular(
                  layouts.sizeLoginRegisterContainerRadius),
            ),
            height: math.min(
                layouts.fractionLoginRegisterSizeContainer * sizeHeight,
                layouts.listLoginRegisterMaxSizeContainer[0]),
            width: math.min(
                layouts.fractionLoginRegisterSizeContainer * sizeWidth,
                layouts.listLoginRegisterMaxSizeContainer[1]),
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
                          style: layouts.styleHead,
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
                                labelText: 'Email',
                                labelStyle: layouts.styleLabel,
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              style: layouts.styleLabel,
                              maxLength: 35,
                            ),
                            maxWidth: constraints.maxWidth *
                                layouts.fractionLoginRegisterSizeLabel,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.email,
                            size: layouts.sizeLoginRegisterIcon,
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
                                labelStyle: layouts.styleLabel,
                                border: OutlineInputBorder(),
                                isDense: true,
                              ),
                              style: layouts.styleLabel,
                              maxLength: 20,
                              obscureText: true,
                            ),
                            maxWidth: constraints.maxWidth *
                                layouts.fractionLoginRegisterSizeLabel,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.visibility_off,
                            size: layouts.sizeLoginRegisterIcon,
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
                            flex: layouts.listLoginRegisterFlexRow[0],
                          ),
                          Expanded(
                            flex: layouts.listLoginRegisterFlexRow[1],
                            child: FractionallySizedBox(
                              widthFactor: 0.8,
                              heightFactor: 0.8,
                              child: TextButton(
                                style: layouts.formatButton,
                                child: Text(
                                  _isLoginButtonEnabled ? 'Login' : 'Wait...',
                                  style: layouts.styleButton,
                                ),
                                // color: Colors.lightBlue,
                                onPressed: _isLoginButtonEnabled
                                    ? onLoginButtonPressed
                                    : () => {},
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
                                        Navigator.pushReplacementNamed(
                                            context, '/register-page');
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
