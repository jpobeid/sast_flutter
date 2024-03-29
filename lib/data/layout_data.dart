import 'package:flutter/material.dart';

//region GeneralLayout
const TextStyle styleHead =
    TextStyle(color: Colors.black, fontSize: 34, fontWeight: FontWeight.bold);
const TextStyle styleLabel = TextStyle(
    color: Color.fromARGB(255, 80, 80, 80),
    fontSize: 18,
    fontWeight: FontWeight.normal);
const TextStyle styleButton = TextStyle(
    color: Color.fromARGB(255, 25, 25, 25),
    fontSize: 18,
    fontWeight: FontWeight.bold);
final ButtonStyle formatButton = TextButton.styleFrom(
  backgroundColor: Colors.lightBlue,
  primary: Colors.black,
);

//endregion GeneralLayout

//region LoginRegisterLayout
const Color colorLoginRegisterGradient0 = Color.fromARGB(255, 150, 30, 240);
const Color colorLoginRegisterGradient1 = Color.fromARGB(255, 40, 0, 140);
const double fractionLoginRegisterSizeContainer = 0.5;
const List<double> listLoginRegisterMaxSizeContainer = [400, 600];
const double sizeLoginRegisterContainerRadius = 15;
const List<int> listLoginRegisterFlexRow = [1, 2, 4];
const double fractionLoginRegisterSizeLabel = 0.6;
const double sizeLoginRegisterIcon = 38;
const int nLoginRegisterDurationSnackBarShort = 1000;
const int nLoginRegisterDurationSnackBarLong = 1500;

//endregion LoginRegisterLayout

//region DashLayout
final BoxDecoration decorDashPanelEnabled = BoxDecoration(
    color: Colors.grey[200], border: Border.all(color: Colors.green, width: 5));
final BoxDecoration decorDashPanelDisabled = BoxDecoration(
    color: Colors.grey[400],
    border: Border.all(color: Colors.redAccent, width: 5));

Divider makeDivider(double sizeThick, Color colorDivider) {
  return Divider(
    color: colorDivider,
    thickness: sizeThick,
  );
}
//endregion Dashlayout
