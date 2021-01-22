import 'package:flutter/material.dart';
import 'package:sast_project/data/layout_data.dart' as layouts;
import 'package:sast_project/widgets/dash_controller.dart';
import 'package:sast_project/widgets/dash_navigator.dart';
import 'package:sast_project/widgets/dash_viewer.dart';
import 'package:sast_project/widgets/sast_app_bar.dart';

class DashboardPage extends StatefulWidget {
  static const String routeName = '/dashboard-page';

  static const double fractionFrameHeight = 0.85;
  static const double fractionFrameWidth = 0.9;
  static const Color colorFrame = Color.fromARGB(180, 255, 255, 255);
  static const double sizeFrameRadius = 20;
  static const double fractionCanvasGap = 0.02;

  final String strUserEmail;
  final String strUserJwt;

  const DashboardPage({Key key, this.strUserEmail, this.strUserJwt}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  bool _isNavigatorComplete = false;
  String _strImageCode;

  void returnNavigatorStatus(bool isComplete) {
    setState(() {
      _isNavigatorComplete = isComplete;
    });
  }

  void returnImageCode(String strImageCode) {
    setState(() {
      _strImageCode = strImageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeSastAppBar(context, 'Dashboard (${widget.strUserEmail})', true),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'space.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * DashboardPage.fractionFrameHeight,
              width: MediaQuery.of(context).size.width * DashboardPage.fractionFrameWidth,
              decoration: BoxDecoration(
                color: DashboardPage.colorFrame,
                borderRadius: BorderRadius.circular(DashboardPage.sizeFrameRadius),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double canvasHeight = constraints.maxHeight - 2 * DashboardPage.sizeFrameRadius;
                  double canvasWidth = constraints.maxWidth - 2 * DashboardPage.sizeFrameRadius;
                  double x0 = DashboardPage.sizeFrameRadius;
                  double y0 = DashboardPage.sizeFrameRadius;
                  return Stack(
                    children: [
                      Positioned(
                        top: y0,
                        left: x0,
                        child: DashNavigator(
                          heightPanel: canvasHeight * 0.5,
                          widthPanel: canvasWidth,
                          decorPanel: _isNavigatorComplete ? layouts.decorDashPanelDisabled : layouts.decorDashPanelEnabled,
                          strUserEmail: '###email',
                          strUserPin: '###pin',
                          callbackComplete: returnNavigatorStatus,
                        ),
                      ),
                      Positioned(
                        top: y0 + canvasHeight * (0.5 + DashboardPage.fractionCanvasGap),
                        left: x0,
                        child: DashController(
                          heightPanel: canvasHeight * (1 - (0.5 + DashboardPage.fractionCanvasGap)),
                          widthPanel: canvasWidth * 0.3,
                          decorPanel: _isNavigatorComplete ? layouts.decorDashPanelEnabled : layouts.decorDashPanelDisabled,
                          isReady: _isNavigatorComplete,
                          callbackStringCode: returnImageCode,
                        ),
                      ),
                      Positioned(
                        top: y0 + canvasHeight * (0.5 + DashboardPage.fractionCanvasGap),
                        left: x0 + canvasWidth * (0.3 + DashboardPage.fractionCanvasGap),
                        child: DashViewer(
                          heightPanel: canvasHeight * (1 - (0.5 + DashboardPage.fractionCanvasGap)),
                          widthPanel: canvasWidth * (1 - (0.3 + DashboardPage.fractionCanvasGap)),
                          decorPanel: _isNavigatorComplete ? layouts.decorDashPanelEnabled : layouts.decorDashPanelDisabled,
                          strImageCode: _strImageCode,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
