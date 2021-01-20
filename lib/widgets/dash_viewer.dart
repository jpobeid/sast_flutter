import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:sast_project/data/dicom_data.dart' as dicoms;

class DashViewer extends StatefulWidget {
  final double heightPanel;
  final double widthPanel;
  final BoxDecoration decorPanel;

  const DashViewer({Key key, this.heightPanel, this.widthPanel, this.decorPanel}) : super(key: key);

  @override
  _DashViewerState createState() => _DashViewerState();
}

class _DashViewerState extends State<DashViewer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.heightPanel,
      width: widget.widthPanel,
      decoration: widget.decorPanel,
      // child: Image.asset(
      //   'ct_image.png',
      //   fit: BoxFit.cover,
      // ),
      child: Image.memory(base64Decode(dicoms.strImage)),
    );
  }
}
