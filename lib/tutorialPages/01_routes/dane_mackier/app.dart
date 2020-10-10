/*
  https://www.filledstacks.com/post/flutter-web-advanced-navigation/
  https://github.com/FilledStacks/flutter-tutorials/tree/master/037-advanced-web-navigation/00-starting
*/
import 'package:flutter/material.dart';
import 'package:flutter_study_web/tutorialPages/01_routes/dane_mackier/routes.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  _AppState() {
    setupLocatorRouteTutorial();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dane Mackier routing test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey:
          routeTutorialLocator<NavigationServiceTutorial>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: HomeRoute,
    );
  }
}
