import 'package:flutter/material.dart';
import 'package:flutter_study_web/responsive.dart';
import 'package:flutter_study_web/widgets/default_page_frame.dart';

class FirebaseFunctionsTutorialPage extends StatefulWidget {
  @override
  _FirebaseFunctionsTutorialPageState createState() =>
      _FirebaseFunctionsTutorialPageState();
}

class _FirebaseFunctionsTutorialPageState
    extends State<FirebaseFunctionsTutorialPage> {
  String _responseOnRequest = "testtesteeeerrrrrrrrrrrerererererererererererer";
  void _onPressTestOnRequest() async {}

  @override
  Widget build(BuildContext context) {
    return DefaultPageFrame(
      body: Column(
        children: [
          ResponsiveWidget.isSmallScreen(context)
              ? Column(
                  children: _onRequestWidget(),
                )
              : Row(
                  children: _onRequestWidget(),
                ),
        ],
      ),
    );
  }

  List<Widget> _onRequestWidget() {
    return [
      FlatButton(
        onPressed: _onPressTestOnRequest,
        child: Text(
          'Click to test on request',
          style: TextStyle(color: Colors.white),
        ),
        color: Theme.of(context).buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Theme.of(context).buttonColor),
        ),
      ),
      Container(
        child: Column(
          children: [Text('Response:'), Text(_responseOnRequest)],
        ),
      ),
    ];
  }
}
