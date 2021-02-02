import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sast_project/data/dicom_data.dart' as dicoms;
import 'package:sast_project/data/http_data.dart' as httpData;
import 'package:sast_project/data/layout_data.dart' as layouts;

class DashController extends StatefulWidget {
  final double heightPanel;
  final double widthPanel;
  final BoxDecoration decorPanel;
  final bool isReady;
  final String strUserEmail;

  const DashController({
    Key key,
    this.heightPanel,
    this.widthPanel,
    this.decorPanel,
    this.isReady,
    this.strUserEmail,
  }) : super(key: key);

  @override
  _DashControllerState createState() => _DashControllerState();
}

class _DashControllerState extends State<DashController> {
  int _indexSite = 0;
  bool _isRunnable = true;

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
            Text(
              'Select site:',
              style: layouts.styleLabel,
            ),
            DropdownButton(
              value: _indexSite,
              items: dicoms.listSite
                  .map((e) => DropdownMenuItem(
                      value: dicoms.listSite.indexOf(e), child: Text(e)))
                  .toList(),
              onChanged: (index) {
                setState(() {
                  _indexSite = index;
                });
              },
            ),
            layouts.makeDivider(2, Colors.red),
            FlatButton(
              child: Text(
                'Run',
                style: layouts.styleButton,
              ),
              color: _isRunnable ? Colors.green : Colors.redAccent,
              onPressed: () async {
                if (_isRunnable) {
                  setState(() {
                    _isRunnable = false;
                  });
                  try {
                    http.Response response = await http.get(
                        httpData.strUrlBase +
                            httpData.strUrlExtensionDash +
                            httpData.strUrlSubExtensionProcess +
                            '/$_indexSite',
                        headers: {'email': widget.strUserEmail});
                    if (response.statusCode != 200) {
                      setState(() {
                        _isRunnable = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Network error: Invalid segmentation algorithm'),
                          backgroundColor: Colors.redAccent,
                          duration: Duration(
                              milliseconds:
                              layouts.nLoginRegisterDurationSnackBarLong),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Successful submission of DICOMs, will send email with RT-struct'),
                          backgroundColor: Colors.green,
                          duration: Duration(
                              milliseconds:
                              layouts.nLoginRegisterDurationSnackBarLong),
                        ),
                      );
                    }
                  } catch (e) {
                    setState(() {
                      _isRunnable = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Network error: $e'),
                        backgroundColor: Colors.redAccent,
                        duration: Duration(
                            milliseconds:
                                layouts.nLoginRegisterDurationSnackBarLong),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
