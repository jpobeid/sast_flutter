import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sast_project/data/http_data.dart' as httpData;
import 'package:sast_project/data/layout_data.dart' as layouts;

class DashViewer extends StatefulWidget {
  final double heightPanel;
  final double widthPanel;
  final BoxDecoration decorPanel;
  final bool isReady;
  final String strUserEmail;

  const DashViewer({
    Key key,
    this.heightPanel,
    this.widthPanel,
    this.decorPanel,
    this.isReady,
    this.strUserEmail,
  }) : super(key: key);

  static const List<int> listFlexColumn = [1, 6];

  @override
  _DashViewerState createState() => _DashViewerState();
}

class _DashViewerState extends State<DashViewer> {
  String _strImageCode;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isReady,
      child: Container(
        height: widget.heightPanel,
        width: widget.widthPanel,
        decoration: widget.decorPanel,
        child: Column(
          children: [
            Flexible(
              flex: DashViewer.listFlexColumn[0],
              child: Center(
                child: FlatButton(
                  color: Colors.lightBlue,
                  child: Text(
                    'Sample',
                    style: layouts.styleButton,
                  ),
                  onPressed: () async {
                    try {
                      http.Response response = await http.get(
                          httpData.urlBase +
                              httpData.urlExtensionDash +
                              httpData.urlSubExtensionImage +
                              '/0',
                          headers: {'email': widget.strUserEmail});
                      setState(() {
                        _strImageCode =
                            jsonDecode(response.body)[httpData.strBase64Key];
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Network error: $e'),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(
                              milliseconds: layouts
                                  .nLoginRegisterDurationSnackBarLong),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            layouts.makeDivider(2, Colors.red),
            Expanded(
              flex: DashViewer.listFlexColumn[1],
              child: _strImageCode != null
                  ? Image.memory(base64Decode(_strImageCode))
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
