import 'package:flutter/material.dart';
import 'package:flutter_study_web/home.dart';
import 'package:flutter_study_web/tutorialPages/02_firebase_functions/firebase_functions_tutorial_page.dart';
import 'package:flutter_study_web/tutorialPages/04_aws_realtime_socket/aws_realtime_socket_tutorial_page.dart';
import 'package:get_it/get_it.dart';
import 'package:web_socket_channel/html.dart';

const String HomePageRoute = '/';
const String FBFunctionsPageRoute = '/firebase-functions';
const String AWSRealtimePageRoute = '/aws-realtime-socket';

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name.getRoutingData;
  switch (routingData.route) {
    case HomePageRoute:
      return _getPageRoute(HomePage(), settings);

    // case FBFunctionsPageRoute:
    //   String message = routingData['message'];
    //   return _getPageRoute(
    //       SecondPage(
    //         message: message,
    //         onPressBack: () {
    //           locator<NavigationService>().goBack();
    //         },
    //       ),
    //       settings);

    case FBFunctionsPageRoute:
      return _getPageRoute(FirebaseFunctionsTutorialPage(), settings);

    case AWSRealtimePageRoute:
      return _getPageRoute(
          AWSRealtimeSocketTutorialPage(
            socketChannel: HtmlWebSocketChannel.connect(
                "wss://us2q8s4g99.execute-api.us-east-1.amazonaws.com/dev"),
          ),
          settings);

    default:
      return _getPageRoute(HomePage(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return FadeRoute(child: child, routeName: settings.name);
}

class FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}

class NavigationService {
  List<String> pathHistory = [];
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName,
      {Map<String, String> queryParams}) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    pathHistory.add(routeName);
    return navigatorKey.currentState.pushNamed(routeName);
  }

  void goBack() {
    if (pathHistory.length > 0) pathHistory.removeAt(pathHistory.length - 1);
    return navigatorKey.currentState.pop();
  }

  void goBackToStart() {
    pathHistory = [];
    return navigatorKey.currentState.popUntil((route) => route.isFirst);
  }
}

class RoutingData {
  final String route;
  final Map<String, String> _queryParameters;

  RoutingData({
    this.route,
    Map<String, String> queryParameters,
  }) : _queryParameters = queryParameters;

  operator [](String key) => _queryParameters[key];
}

extension StringExtension on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    print('queryParameters: ${uriData.queryParameters} path: ${uriData.path}');
    return RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path,
    );
  }
}
