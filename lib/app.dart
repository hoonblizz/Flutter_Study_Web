import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_web/routes.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  _AppState() {
    setupLocator();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) {
        return brightness == Brightness.light
            ? ThemeData(
                primarySwatch: Colors.blueGrey,
                backgroundColor: Colors.white,
                cardColor: Colors.blueGrey[600],
                primaryTextTheme: TextTheme(
                  button: TextStyle(
                    color: Colors.blueGrey,
                    decorationColor: Colors.blueGrey[300],
                  ),
                  subtitle2: TextStyle(
                    color: Colors.blueGrey[900],
                  ),
                  subtitle1: TextStyle(
                    color: Colors.black,
                  ),
                  headline1: TextStyle(
                    color: Colors.blueGrey[800],
                  ),
                  bodyText1: TextStyle(color: Colors.white),
                  //bodyText2: TextStyle(color: Colors.blueGrey[50]),
                ),
                bottomAppBarColor: Colors.blueGrey[900],
                iconTheme: IconThemeData(color: Colors.blueGrey),
                brightness: brightness,
              )
            : ThemeData(
                primarySwatch: Colors.blueGrey,
                backgroundColor: Colors.blueGrey[900],
                cardColor: Colors.blueGrey[50],
                primaryTextTheme: TextTheme(
                  button: TextStyle(
                    color: Colors.white,
                    decorationColor: Colors.blueGrey[50],
                  ),
                  subtitle2: TextStyle(
                    color: Colors.white,
                  ),
                  subtitle1: TextStyle(
                    color: Colors.blueGrey[300],
                  ),
                  headline1: TextStyle(
                    color: Colors.white70,
                  ),
                  bodyText1: TextStyle(color: Colors.black),
                  //bodyText2: TextStyle(color: Colors.black),
                ),
                bottomAppBarColor: Colors.black,
                iconTheme: IconThemeData(color: Colors.blueGrey[200]),
                brightness: brightness,
              );
      },
      themedWidgetBuilder: (context, data) => MaterialApp(
        title: 'Coding Sloth',
        debugShowCheckedModeBanner: false,
        theme: data.copyWith(
          // originalSize * fontSizeFactor + fontSizeDelta
          textTheme: Theme.of(context).textTheme.apply(
                fontSizeFactor: 1.0,
                fontSizeDelta: 2.0,
              ),
        ),
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: generateRoute,
        initialRoute: HomePageRoute,
      ),
    );
  }
}
