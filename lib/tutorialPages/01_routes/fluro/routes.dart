import 'dart:convert';

import 'package:fluro/fluro.dart' as fluro;
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_web/tutorialPages/01_routes/pages/home.dart';
import 'package:flutter_study_web/tutorialPages/01_routes/pages/second_page.dart';

class Application {
  static fluro.Router router;
}

const String HomeRoute = "/";
const String SecondPageRoute = "/second";

class Routes {
  static void configureRoutes(fluro.Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return Container(
        child: Text('Page does not exist!'),
      );
    });
    router.define(HomeRoute, handler: homeRouteHandler);
    router.define(SecondPageRoute, handler: secondRouteHandler);
  }
}

var homeRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage(
    onPressRouteButton: () {
      // Setup testing values
      String message = "Fluro routing test message";
      Map testingMap = {
        "key1": false,
        "key2": "string tester is here",
        "key3": 99
      };

      // Create url out of it
      String route1 =
          "$SecondPageRoute?message=$message&map=${jsonEncode(testingMap)}";

      // route!
      Application.router.navigateTo(context, route1,
          transition: fluro.TransitionType.fadeIn,
          transitionDuration: Duration(milliseconds: 150));
    },
  );
});

var secondRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  if (params.length == 0)
    return Container(
      child: Text('Loading...'),
    );

  String message = params['message'].first ?? 'No message';
  Map testingMap = jsonDecode(params['map'].first) ?? {};

  return SecondPage(
      message: message,
      testingMap: testingMap,
      onPressBack: () {
        Application.router.navigateTo(context, HomeRoute,
            clearStack: true,
            transition: fluro.TransitionType.fadeIn,
            transitionDuration: Duration(milliseconds: 150));
      });
});
