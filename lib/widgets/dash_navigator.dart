import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sast_project/data/layout_data.dart' as layouts;
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:sast_project/data/http_data.dart' as httpData;

class DashNavigator extends StatefulWidget {
  final double heightPanel;
  final double widthPanel;
  final BoxDecoration decorPanel;

  const DashNavigator(
      {Key key, this.heightPanel, this.widthPanel, this.decorPanel})
      : super(key: key);

  @override
  _DashNavigatorState createState() => _DashNavigatorState();
}

class _DashNavigatorState extends State<DashNavigator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.heightPanel,
      width: widget.widthPanel,
      decoration: widget.decorPanel,
      child: Column(
        children: [
          Text(
            'Select DICOMs:',
            style: layouts.styleLabel,
          ),
          RaisedButton(
            color: Colors.lightBlue,
            child: Text(
              'Select',
              style: layouts.styleButton,
            ),
            onPressed: () async {
              FilePickerResult result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['dcm', 'txt'],
              );
              if (result != null) {
                List<int> listBytes = result.files.first.bytes;
                print(listBytes);
                http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(httpData.strUrlBase + '/upload/0'));
                request.fields['user'] = 'test_user';
                request.fields['data'] = json.encode(listBytes);
                request.files.add(http.MultipartFile.fromBytes('fileZ', listBytes));
                request.headers.addAll({
                  'Content-type': 'multipart/form-data'
                });
                http.StreamedResponse response = await request.send();
                print(response);
                print(response.statusCode);
              }
            },
          ),
        ],
      ),
    );
  }
}
