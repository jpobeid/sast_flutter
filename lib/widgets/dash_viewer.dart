import 'dart:convert';

import 'package:flutter/material.dart';

class DashViewer extends StatefulWidget {
  final double heightPanel;
  final double widthPanel;
  final BoxDecoration decorPanel;
  final String strImageCode;

  const DashViewer({
    Key key,
    this.heightPanel,
    this.widthPanel,
    this.decorPanel,
    this.strImageCode,
  }) : super(key: key);

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
      child: widget.strImageCode != null
          ? Image.memory(base64Decode(widget.strImageCode))
          : Container(),
    );
  }
}
