import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_web/constants.dart';
import 'package:flutter_study_web/responsive.dart';
import 'package:flutter_study_web/widgets/default_page_frame.dart';
import 'package:http/http.dart' as http;

class FirebaseFunctionsTutorialPage extends StatefulWidget {
  @override
  _FirebaseFunctionsTutorialPageState createState() =>
      _FirebaseFunctionsTutorialPageState();
}

class _FirebaseFunctionsTutorialPageState
    extends State<FirebaseFunctionsTutorialPage> {
  String _responseOnRequestGET = "";
  String _responseOnRequestPOST = "";
  String _responseOnCall = "";
  void _onPressTestOnRequestGET() async {
    setState(() {
      _responseOnRequestGET = "";
    });
    try {
      final res = await http.get(
          "https://us-central1-flutterstudyweb.cloudfunctions.net/testOnRequest?message=hello&num1=2&num2=4");
      print('[onRequest] Res: ${res.body.toString()}');
      setState(() {
        _responseOnRequestGET = res.body.toString();
      });
    } catch (e) {
      setState(() {
        _responseOnRequestGET = '[onRequest] General exception:' + e.toString();
      });
    }
  }

  void _onPressTestOnRequestPOST() async {
    setState(() {
      _responseOnRequestPOST = "";
    });
    try {
      final res = await http.post(
          "https://us-central1-flutterstudyweb.cloudfunctions.net/testOnRequest",
          body: jsonEncode({
            'message': 'hello there',
            'num1': 3,
            'num2': 4,
          }));
      print('[onRequest] Res: ${res.body.toString()}');
      setState(() {
        _responseOnRequestPOST = res.body.toString();
      });
    } catch (e) {
      setState(() {
        _responseOnRequestPOST =
            '[onRequest] General exception:' + e.toString();
      });
    }
  }

  void _onPressTestOnCall() async {
    setState(() {
      _responseOnCall = "";
    });
    try {
      final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
        functionName: 'testOnCall',
      );

      dynamic resp = await callable.call(<String, dynamic>{
        'message': 'Hello there',
        'num1': 2,
        'num2': 4,
      });

      print('[onCall] Res: ${resp.data.toString()}');
      setState(() {
        _responseOnCall = resp.data.toString();
      });
    } on CloudFunctionsException catch (e) {
      setState(() {
        _responseOnCall = e.code + ': ' + e.message + ' => ' + e.details;
      });
    } catch (e) {
      setState(() {
        _responseOnCall = '[onCall] General exception:' + e.toString();
      });
    }
  }

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
                        'Click to test GET request',
                        _onPressTestOnRequestGET,
                        _responseOnRequestGET,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _contentWidget(
                        themeData,
                        screenSize,
                        'Click to test GET request',
                        _onPressTestOnRequestGET,
                        _responseOnRequestGET,
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
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
                        'Click to test POST request',
                        _onPressTestOnRequestPOST,
                        _responseOnRequestPOST,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _contentWidget(
                        themeData,
                        screenSize,
                        'Click to test POST request',
                        _onPressTestOnRequestPOST,
                        _responseOnRequestPOST,
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: 20,
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
