import 'package:flutter/material.dart';
import 'package:flutter_study_web/widgets/app_bar.dart';
import 'package:flutter_study_web/widgets/side_drawer.dart';

class DefaultPageFrame extends StatefulWidget {
  DefaultPageFrame({this.body});
  final Widget body;

  @override
  _DefaultPageFrameState createState() => _DefaultPageFrameState();
}

class _DefaultPageFrameState extends State<DefaultPageFrame> {
  ScrollController _scrollController;
  double _scrollPosition = 0;
  double _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: appBarWidget(context, screenSize, _opacity),
      drawer: SideDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                // Container(
                //   child: SizedBox(
                //     height: screenSize.height * 0.45,
                //     width: screenSize.width,
                //     child: Image.asset(
                //       'assets/images/cover.jpg',
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                Container(
                  height: screenSize.height * 0.20,
                  width: screenSize.width,
                  alignment: Alignment.center,
                  color: Colors.grey.shade600,
                  child: Text(
                    '',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    // Empty space to place below the image.
                    Container(
                      height: screenSize.height * 0.20 + 20,
                      width: screenSize.width,
                      child: Container(),
                    ),
                    widget.body,
                  ],
                ),
              ],
            ),
            SizedBox(height: screenSize.height / 10),
            //BottomBar(),
          ],
        ),
      ),
    );
  }
}
