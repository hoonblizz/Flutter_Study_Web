import 'package:flutter/material.dart';
import 'package:flutter_study_web/constants.dart';
import 'package:flutter_study_web/responsive.dart';
import 'package:flutter_study_web/widgets/default_page_frame.dart';

class FirebaseFunctionsTutorialPage extends StatefulWidget {
  @override
  _FirebaseFunctionsTutorialPageState createState() =>
      _FirebaseFunctionsTutorialPageState();
}

class _FirebaseFunctionsTutorialPageState
    extends State<FirebaseFunctionsTutorialPage> {
  String _responseOnRequest = "";
  String _responseOnCall = "";
  void _onPressTestOnRequest() async {}
  void _onPressTestOnCall() async {}
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);
    double cardWidth = 750;

    return DefaultPageFrame(
      body: Column(
        children: [
          // On Request Test button and Response text
          Container(
            width: cardWidth,
            padding: EdgeInsets.all(kBodyHorizontalPadding),
            //padding: EdgeInsets.symmetric(horizontal: kBodyHorizontalPadding),
            child: Card(
              elevation: 5.0,
              child: ResponsiveWidget.isSmallScreen(context)
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _contentWidget(
                        themeData,
                        screenSize,
                        'Click to test onRequest',
                        _onPressTestOnRequest,
                        _responseOnRequest,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _contentWidget(
                        themeData,
                        screenSize,
                        'Click to test onRequest',
                        _onPressTestOnRequest,
                        _responseOnRequest,
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          // On Call Test button and Response text
          Container(
            width: cardWidth,
            padding: EdgeInsets.all(kBodyHorizontalPadding),
            //padding: EdgeInsets.symmetric(horizontal: kBodyHorizontalPadding),
            child: Card(
              elevation: 5.0,
              child: ResponsiveWidget.isSmallScreen(context)
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _contentWidget(
                        themeData,
                        screenSize,
                        'Click to test onCall',
                        _onPressTestOnCall,
                        _responseOnCall,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _contentWidget(
                        themeData,
                        screenSize,
                        'Click to test onCall',
                        _onPressTestOnCall,
                        _responseOnCall,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _contentWidget(ThemeData themeData, Size screenSize,
      String buttonText, Function buttonFunc, String responseVal) {
    return [
      Container(
        width: 250,
        child: FlatButton(
          onPressed: buttonFunc,
          child: Text(
            buttonText,
            style: themeData.primaryTextTheme.button,
          ),
          color: themeData.buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Theme.of(context).buttonColor),
          ),
        ),
      ),
      Container(
        width: 400,
        padding: EdgeInsets.all(kBodyHorizontalPadding),
        child: Column(
          children: [
            Text(
              'Response:',
              style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              responseVal,
              style: Theme.of(context).primaryTextTheme.bodyText1,
            )
          ],
        ),
      ),
    ];
  }
}
