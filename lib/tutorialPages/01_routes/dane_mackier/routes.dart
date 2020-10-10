import 'package:flutter/material.dart';
import 'package:flutter_study_web/tutorialPages/01_routes/pages/home.dart';
import 'package:flutter_study_web/tutorialPages/01_routes/pages/second_page.dart';
import 'package:get_it/get_it.dart';

const String HomeRoute = '/';
const String SecondPageRoute = '/second';

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name.getRoutingData;
  // print('Routing name: ${settings.name}');
  switch (routingData.route) {
    case HomeRoute:
      return _getPageRoute(HomePage(
        onPressRouteButton: () {
          routeTutorialLocator<NavigationServiceTutorial>().navigateTo(
              SecondPageRoute,
              queryParams: {'message': 'Message from home'});
        },
      ), settings);

    case SecondPageRoute:
      String message = routingData['message'];
      return _getPageRoute(
          SecondPage(
            message: message,
            onPressBack: () {
              routeTutorialLocator<NavigationServiceTutorial>().goBack();
            },
          ),
          settings);

    default:
      return _getPageRoute(HomePage(
        onPressRouteButton: () {
          routeTutorialLocator<NavigationServiceTutorial>().navigateTo(
              SecondPageRoute,
              queryParams: {'message': 'Message from home'});
        },
      ), settings);
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

GetIt routeTutorialLocator = GetIt.instance;

void setupLocatorRouteTutorial() {
  routeTutorialLocator.registerLazySingleton(() => NavigationServiceTutorial());
}

class NavigationServiceTutorial {
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
