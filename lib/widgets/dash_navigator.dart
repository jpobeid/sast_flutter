import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sast_project/data/http_data.dart' as httpData;
import 'package:sast_project/data/layout_data.dart' as layouts;

class DashNavigator extends StatefulWidget {
  final double heightPanel;
  final double widthPanel;
  final BoxDecoration decorPanel;
  final String strUserEmail;
  final String strUserPin;

  const DashNavigator(
      {Key key,
      this.heightPanel,
      this.widthPanel,
      this.decorPanel,
      this.strUserEmail,
      this.strUserPin})
      : super(key: key);

  static const List<int> listFlexRow = [1, 2];

  @override
  _DashNavigatorState createState() => _DashNavigatorState();
}

class _DashNavigatorState extends State<DashNavigator> {
  FilePickerResult _resultFiles;
  List<String> _listFileName;
  bool _canUpload = false;
  double _nProgress = 0;

  Future<http.StreamedResponse> postStreamedRequest(
      String strUrl, Uint8List listBytes) async {
    if (widget.strUserEmail != null && widget.strUserPin != null) {
      try {
        http.MultipartRequest request =
            http.MultipartRequest('POST', Uri.parse(strUrl));
        request.fields['email'] = widget.strUserEmail;
        request.fields['pin'] = widget.strUserPin;
        request.files.add(http.MultipartFile.fromBytes('fileDicom', listBytes,
            filename: 'slice.dcm'));
        request.headers.addAll({'Content-type': 'multipart/form-data'});
        http.StreamedResponse response = await request.send();
        return response;
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Network error: $e'),
            backgroundColor: Colors.redAccent,
            duration: Duration(
                milliseconds: layouts.nLoginRegisterDurationSnackBarLong),
          ),
        );
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.heightPanel,
      width: widget.widthPanel,
      decoration: widget.decorPanel,
      child: Row(
        children: [
          Expanded(
            flex: DashNavigator.listFlexRow[0],
            child: IgnorePointer(
              ignoring: (_nProgress > 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                    color: Colors.lightBlue,
                    child: Text(
                      'Select Files',
                      style: layouts.styleButton,
                    ),
                    onPressed: () async {
                      _resultFiles = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['dcm'],
                        allowMultiple: true,
                      );
                      if (_resultFiles != null) {
                        setState(() {
                          _listFileName =
                              _resultFiles.files.map((e) => e.name).toList();
                          if (_listFileName.every(
                              (element) => element.split('.').last == 'dcm')) {
                            _canUpload = true;
                          } else {
                            _canUpload = false;
                          }
                        });
                      }
                    },
                  ),
                  FlatButton(
                    color: Colors.lightBlue,
                    child: Text(
                      'Reset Files',
                      style: layouts.styleButton,
                    ),
                    onPressed: () {
                      setState(() {
                        _resultFiles = null;
                        _listFileName = null;
                        _canUpload = false;
                        _nProgress = 0;
                      });
                    },
                  ),
                  FlatButton(
                    color: _canUpload ? Colors.green : Colors.redAccent,
                    child: Text(
                      'Upload Data',
                      style: layouts.styleButton,
                    ),
                    onPressed: () async {
                      if (_canUpload) {
                        int i = -1;
                        _resultFiles.files.forEach((element) async {
                          i++;
                          http.StreamedResponse response =
                              await postStreamedRequest(
                                  httpData.strUrlBase + '/upload/$i',
                                  element.bytes);
                          if (response != null) {
                            setState(() {
                              _nProgress += (1 / _resultFiles.count);
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Error: Was unable to upload files'),
                                backgroundColor: Colors.redAccent,
                                duration: Duration(
                                    milliseconds: layouts
                                        .nLoginRegisterDurationSnackBarLong),
                              ),
                            );
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '1 or more, only DICOM, files need to be selected'),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(
                                milliseconds:
                                    layouts.nLoginRegisterDurationSnackBarLong),
                          ),
                        );
                      }
                    },
                  ),
                  LinearProgressIndicator(
                    minHeight: 20,
                    value: _nProgress,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: DashNavigator.listFlexRow[1],
            child: Column(
              children: [
                Text(
                  'Selected DICOM List:',
                  style: layouts.styleLabel,
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount:
                          _listFileName != null ? _listFileName.length : 0,
                      itemBuilder: (context, index) {
                        return Text(_listFileName[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
