import 'package:flutter/material.dart';
import 'package:flutter_study_web/widgets/default_page_frame.dart';

class ImageUploadToFirebaseTutorialPage extends StatefulWidget {
  @override
  _ImageUploadToFirebaseTutorialPageState createState() =>
      _ImageUploadToFirebaseTutorialPageState();
}

class _ImageUploadToFirebaseTutorialPageState
    extends State<ImageUploadToFirebaseTutorialPage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);

    return DefaultPageFrame(
      body: Column(
        children: [
          Container(
            child: Text('Tutorial Page'),
          )
        ],
      ),
    );
  }
}
