import 'package:flutter/material.dart';
import 'package:flutter_study_web/widgets/app_bar.dart';
import 'package:flutter_study_web/widgets/default_page_frame.dart';
import 'package:flutter_study_web/widgets/side_drawer.dart';
import 'package:flutter_study_web/routes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return DefaultPageFrame(
      body: Column(
        children: [
          FlatButton(
            onPressed: () {
              locator<NavigationService>().navigateTo(FBFunctionsPageRoute);
            },
            child: Text('Firebase function tutorial'),
          ),
          FlatButton(
            onPressed: () {
              locator<NavigationService>().navigateTo(AWSRealtimePageRoute);
            },
            child: Text('AWS Realtime database tutorial'),
          ),
          Text('Num 1'),
          Text('Num 2'),
          Container(
            height: screenSize.height + 100,
            width: screenSize.width,
            child: Text('Take space'),
          ),
        ],
      ),
    );
  }
}
