import 'package:flutter/material.dart';
import 'package:sast_project/data/layout_data.dart' as layouts;
import 'package:http/http.dart' as https;
import 'package:sast_project/data/http_data.dart' as httpData;

AppBar makeSastAppBar(BuildContext context, String strPage, String strUserEmail, bool canLogout) {
  const TextStyle styleTitle =
      TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold);
  return AppBar(
    elevation: 0,
    title: Text(
      strUserEmail == null ? 'SAST - $strPage' : 'SAST - $strPage ($strUserEmail)',
      style: styleTitle,
    ),
    actions: canLogout
        ? [
            TextButton.icon(
              icon: Icon(
                Icons.logout,
                color: layouts.styleButton.color,
              ),
              label: Text(
                'Logout',
                style: layouts.styleButton,
              ),
              style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30)),
              onPressed: () async {
                String urlLogout = httpData.strUrlBase +
                    httpData.strUrlExtensionDash +
                    httpData.strUrlSubExtensionLogout +
                    '/0';
                https.Response response = await https
                    .get(urlLogout, headers: {'email': strUserEmail});
                if (response.statusCode == 200) {
                  Navigator.of(context).pushReplacementNamed('/login-page');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Successful logout'),
                      backgroundColor: Colors.green,
                      duration: Duration(
                          milliseconds:
                              layouts.nLoginRegisterDurationSnackBarLong),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Network error: Failed to logout...'),
                      backgroundColor: Colors.red,
                      duration: Duration(
                          milliseconds:
                              layouts.nLoginRegisterDurationSnackBarLong),
                    ),
                  );
                }
              },
            ),
          ]
        : [],
  );
}
