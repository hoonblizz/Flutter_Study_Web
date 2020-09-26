/*
  https://pub.dev/packages/fluro
  https://github.com/theyakka/fluro
*/

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart' as fluro;
import 'package:flutter_study_web/routes/fluro/routes.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Init
  _AppState() {
    final router = fluro.Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluro routing test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Application.router.generator,
    );
  }
}
