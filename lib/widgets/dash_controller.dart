import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sast_project/data/dicom_data.dart' as dicoms;
import 'package:sast_project/data/layout_data.dart' as layouts;
import 'package:http/http.dart' as http;
import 'package:sast_project/data/http_data.dart' as httpData;

class DashController extends StatefulWidget {
  final double heightPanel;
  final double widthPanel;
  final BoxDecoration decorPanel;
  final bool isReady;
  final Function callbackStringCode;

  const DashController({
    Key key,
    this.heightPanel,
    this.widthPanel,
    this.decorPanel,
    this.isReady,
    this.callbackStringCode,
  }) : super(key: key);

  @override
  _DashControllerState createState() => _DashControllerState();
}

class _DashControllerState extends State<DashController> {
  int _indexSite = 0;
  int _indexAlgo = 0;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isReady,
      child: Container(
        height: widget.heightPanel,
        width: widget.widthPanel,
        decoration: widget.decorPanel,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlatButton(
              color: Colors.lightBlue,
              child: Text(
                'View',
                style: layouts.styleButton,
              ),
              onPressed: () async {
                http.Response response = await http.get(httpData.strUrlBase + httpData.strUrlExtensionDash + '/image/0');
                String strImageCode = jsonDecode(response.body)[httpData.strBase64Key];
                widget.callbackStringCode(strImageCode);
              },
            ),
            makeDivider(2, Colors.red),
            Text(
              'Select site:',
              style: layouts.styleLabel,
            ),
            DropdownButton(
              value: _indexSite,
              items: dicoms.listSite
                  .map((e) => DropdownMenuItem(value: dicoms.listSite.indexOf(e), child: Text(e)))
                  .toList(),
              onChanged: (index) {
                setState(() {
                  _indexSite = index;
                });
              },
            ),
            makeDivider(2, Colors.red),
            Text(
              'Select algorithm:',
              style: layouts.styleLabel,
            ),
            DropdownButton(
              value: _indexAlgo,
              items: dicoms.listAlgo
                  .map((e) => DropdownMenuItem(value: dicoms.listAlgo.indexOf(e), child: Text(e)))
                  .toList(),
              onChanged: (index) {
                setState(() {
                  _indexAlgo = index;
                });
              },
            ),
            makeDivider(2, Colors.red),
            FlatButton(
              child: Text(
                'Run',
                style: layouts.styleButton,
              ),
              color: Colors.lightBlue,
              onPressed: () {
                print('Processing!!');
              },
            ),
          ],
        ),
      ),
    );
  }
}

Divider makeDivider(double sizeThick, Color colorDivider) {
  return Divider(
    color: colorDivider,
    thickness: sizeThick,
  );
}
