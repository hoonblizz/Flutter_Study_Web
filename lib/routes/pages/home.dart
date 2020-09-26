import 'package:flutter/material.dart';
import 'package:flutter_study_web/routes/fluro/routes.dart';

class HomePage extends StatelessWidget {
  HomePage({this.onPressRouteButton});
  final Function onPressRouteButton;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Text('Home Container'),
            FlatButton(
                color: Colors.lightBlue,
                onPressed: onPressRouteButton,
                child: Text('Go to demo router')),
          ],
        ),
      ),
    );
  }
}
