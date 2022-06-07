import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sast_project/data/http_data.dart' as httpData;
import 'package:sast_project/data/layout_data.dart' as layouts;
import 'package:sast_project/functions/dicom_functions.dart' as funcDicom;

class DashNavigator extends StatefulWidget {
  final double heightPanel;
  final double widthPanel;
  final BoxDecoration decorPanel;
  final String strUserEmail;
  final String strUserToken;
  final String strUserPin;
  final Function callbackComplete;

  const DashNavigator({
    Key key,
    this.heightPanel,
    this.widthPanel,
    this.decorPanel,
    this.strUserEmail,
    this.strUserToken,
    this.strUserPin,
    this.callbackComplete,
  }) : super(key: key);

  static const List<int> listFlexRow = [100, 1, 200];
  static const double sizeButtonPadding = 15;
  static const int nMinListLength = 20;

  @override
  _DashNavigatorState createState() => _DashNavigatorState();
}

class _DashNavigatorState extends State<DashNavigator> {
  FilePickerResult _resultFiles;
  List<String> _listFileName;
  List<String> _listStudyInfo = [];
  bool _canUpload = false;
  double _nProgress = 0;

  Future<http.StreamedResponse> postStreamedRequest(
      String strUrl, Uint8List listBytes) async {
    if (widget.strUserEmail != null && widget.strUserPin != null) {
      try {
        http.MultipartRequest request =
            http.MultipartRequest('POST', Uri.parse(strUrl));
        request.fields['email'] = widget.strUserEmail;
        request.fields['token'] = widget.strUserToken;
        request.fields['pin'] = widget.strUserPin;
        request.files.add(http.MultipartFile.fromBytes('fileDicom', listBytes,
            filename: 'slice.dcm'));
        request.headers.addAll({'Content-type': 'multipart/form-data'});
        http.StreamedResponse response = await request.send();
        return response;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  void resetNavigator() {
    setState(() {
      _resultFiles = null;
      _listFileName = null;
      _listStudyInfo.clear();
      _canUpload = false;
      _nProgress = 0;
    });
  }

  bool areFilesProper() {
    // To check if all list members reference same patient ID, accession # and series #
    bool areAllProper = true;
    String strPatientID =
        funcDicom.readDicomTag(_resultFiles.files.first.bytes, 'id');
    String strAccessionNumber =
        funcDicom.readDicomTag(_resultFiles.files.first.bytes, 'accession');
    String strSeriesNumber =
        funcDicom.readDicomTag(_resultFiles.files.first.bytes, 'series');
    _resultFiles.files.forEach((element) {
      if (!(funcDicom.readDicomTag(element.bytes, 'id') == strPatientID &&
          funcDicom.readDicomTag(element.bytes, 'accession') ==
              strAccessionNumber &&
          funcDicom.readDicomTag(element.bytes, 'series') == strSeriesNumber)) {
        areAllProper = false;
      }
    });
    if (areAllProper) {
      _listStudyInfo.clear();
      _listStudyInfo
          .addAll([strPatientID, strAccessionNumber, strSeriesNumber]);
    } else {
      _listStudyInfo.clear();
    }
    return areAllProper;
  }

  void showErrorMessage(String strError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(strError),
        backgroundColor: Colors.red,
        duration:
            Duration(milliseconds: layouts.nLoginRegisterDurationSnackBarLong),
      ),
    );
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
                  TextButton(
                    style: layouts.formatButton,
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
                          bool isListAllDicom = _listFileName.every(
                              (element) => element.split('.').last == 'dcm');
                          bool isListProper = areFilesProper() &&
                              _listFileName.length >=
                                  DashNavigator.nMinListLength &&
                              isListAllDicom;
                          if (isListProper) {
                            _canUpload = true;
                          } else if (_listFileName.length <
                              DashNavigator.nMinListLength) {
                            _canUpload = false;
                            showErrorMessage(
                                'List must have ${DashNavigator.nMinListLength} or more entries...');
                          } else if (!isListAllDicom) {
                            _canUpload = false;
                            showErrorMessage('List is not all DICOM files...');
                          } else {
                            _canUpload = false;
                            showErrorMessage('DICOMs are not matching...');
                          }
                        });
                      }
                    },
                  ),
                  TextButton(
                    style: layouts.formatButton,
                    child: Text(
                      'Reset Files',
                      style: layouts.styleButton,
                    ),
                    onPressed: resetNavigator,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            _canUpload ? Colors.green : Colors.redAccent,
                        primary: Colors.black),
                    child: Text(
                      'Upload Data',
                      style: layouts.styleButton,
                    ),
                    onPressed: () async {
                      if (_canUpload) {
                        setState(() {
                          _canUpload = false;
                        });
                        bool isConnected = true;
                        http.Response responseTest;
                        try {
                          responseTest = await http.get(
                              httpData.urlBase + httpData.urlExtensionTest);
                        } catch (e) {
                          isConnected = false;
                        }
                        if (isConnected && responseTest.statusCode == 200) {
                          int i = -1;
                          _resultFiles.files.forEach((element) async {
                            List<int> listBytes = element.bytes;
                            i++;
                            funcDicom.makeAnonListBytes(listBytes);
                            http.StreamedResponse response =
                                await postStreamedRequest(
                                    httpData.urlBase +
                                        httpData.urlExtensionDash +
                                        httpData.urlSubExtensionUpload +
                                        '/$i',
                                    listBytes);
                            if (response != null &&
                                response.statusCode == 200) {
                              setState(() {
                                _nProgress += (1 / _resultFiles.count);
                              });
                              if ((_nProgress * 1000).round() / 1000 == 1) {
                                // Uploads are complete, need backend to verify correct modality and series
                                http.Response verification = await http.get(
                                    httpData.urlBase +
                                        httpData.urlExtensionDash +
                                        httpData.urlSubExtensionVerify +
                                        '/0',
                                    headers: {'email': widget.strUserEmail});
                                if (verification.statusCode == 200) {
                                  widget.callbackComplete(true);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Upload successful!'),
                                      backgroundColor: Colors.green,
                                      duration: Duration(
                                          milliseconds: layouts
                                              .nLoginRegisterDurationSnackBarLong),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(json.decode(
                                          verification.body)['message']),
                                      backgroundColor: Colors.red,
                                      duration: Duration(
                                          milliseconds: layouts
                                              .nLoginRegisterDurationSnackBarLong),
                                    ),
                                  );
                                  resetNavigator();
                                }
                              }
                            }
                          });
                        } else {
                          showErrorMessage(
                              'Network error: Was unable to upload files');
                        }
                        setState(() {
                          _canUpload = true;
                        });
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
            child: Container(
              color: Colors.redAccent,
            ),
          ),
          Expanded(
            flex: DashNavigator.listFlexRow[2],
            child: Column(
              children: [
                Text(
                  'Selected DICOM List (${_listFileName != null ? _listFileName.length : 0}):',
                  style: layouts.styleLabel,
                ),
                Divider(
                  color: Colors.redAccent,
                  thickness: 3,
                ),
                Expanded(
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount:
                          _listFileName != null ? _listFileName.length : 0,
                      itemBuilder: (context, index) {
                        return Text(
                          _listFileName[index],
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                ),
                Divider(
                  color: Colors.redAccent,
                  thickness: 3,
                ),
                Text(
                  _listStudyInfo.length == 3
                      ? 'PatientID: ${_listStudyInfo[0]}, Accession: ${_listStudyInfo[1]}, Series: ${_listStudyInfo[2]}'
                      : '',
                  style: layouts.styleLabel,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
