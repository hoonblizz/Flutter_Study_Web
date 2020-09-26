import 'dart:convert';

import 'package:fluro/fluro.dart' as fluro;
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_web/routes/pages/home.dart';
import 'package:flutter_study_web/routes/pages/second_page.dart';

class Application {
  static fluro.Router router;
}

class Routes {
  static String root = "/";
  static String demoSimple = "/demo";
  static String demoSimpleFixedTrans = "/demo/fixedtrans";
  static String demoFunc = "/demo/func";
  static String deepLink = "/message";

  static void configureRoutes(fluro.Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: rootHandler);
    router.define(demoSimple, handler: demoRouteHandler);
    router.define(demoSimpleFixedTrans,
        handler: demoRouteHandler, transitionType: TransitionType.inFromLeft);
    router.define(demoFunc, handler: demoFunctionHandler);
  }
}

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomePage(
    onPressRouteButton: () {
      String message = "hello there is special case is okay??!!@@";
      Map testingMap = {
        "key1": false,
        "key2": "string tester is here",
        "key3": 99
      };

      String route1 = "/demo?message=$message&map=${jsonEncode(testingMap)}";

      String route2 = "/demo/func";

      Application.router.navigateTo(context, route1,
          transition: fluro.TransitionType.fadeIn,
          transitionDuration: Duration(milliseconds: 150));
    },
  );
});

var demoRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  print('Check param: ${params.toString()}');
  if (params.length == 0)
    return Container(
      child: Text('Loading...'),
    );

  print('Message length? ${params['message'].length}');
  String message = params['message'].first ?? 'No message';

  return SecondPage(
      message: message,
      onPressBack: () {
        Application.router.navigateTo(context, '/',
            clearStack: true,
            transition: fluro.TransitionType.fadeIn,
            transitionDuration: Duration(milliseconds: 150));
      });
});

var demoFunctionHandler = Handler(
    type: HandlerType.function,
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String message = params["message"]?.first;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Demo Function Handler!",
            ),
            content: Text("$message"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    });
