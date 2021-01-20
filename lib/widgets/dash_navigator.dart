import 'package:flutter/material.dart';
import 'package:sast_project/data/layout_data.dart' as layouts;

class DashNavigator extends StatefulWidget {
  final double heightPanel;
  final double widthPanel;
  final BoxDecoration decorPanel;

  const DashNavigator({Key key, this.heightPanel, this.widthPanel, this.decorPanel}) : super(key: key);

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
          Text('Input path to DICOMs:', style: layouts.styleLabel,),
          Container(
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
