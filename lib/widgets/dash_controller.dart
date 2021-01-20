import 'package:flutter/material.dart';
import 'package:sast_project/data/dicom_data.dart' as dicoms;
import 'package:sast_project/data/layout_data.dart' as layouts;

class DashController extends StatefulWidget {
  final double heightPanel;
  final double widthPanel;
  final BoxDecoration decorPanel;

  const DashController({Key key, this.heightPanel, this.widthPanel, this.decorPanel})
      : super(key: key);

  @override
  _DashControllerState createState() => _DashControllerState();
}

class _DashControllerState extends State<DashController> {
  int _indexSite = 0;
  int _indexAlgo = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.heightPanel,
      width: widget.widthPanel,
      decoration: widget.decorPanel,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
          RaisedButton(
            child: Text('Run', style: layouts.styleButton,),
            color: Colors.lightBlue,
            onPressed: () {
              print('Processing!!');
            },
          ),
        ],
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
