import 'package:flutter/material.dart';
import 'package:flutter_study_web/constants.dart';
import 'package:flutter_study_web/responsive.dart';
import 'package:flutter_study_web/routes.dart';
import 'package:flutter_study_web/widgets/change_theme_button.dart';
import 'package:flutter_study_web/widgets/top_bar_content.dart';

Widget appBarWidget(context, screenSize, opacityVal) {
  return ResponsiveWidget.isSmallScreen(context)
      ? AppBar(
          backgroundColor:
              Theme.of(context).bottomAppBarColor.withOpacity(opacityVal),
          elevation: 0,
          centerTitle: true,
          actions: [
            changeThemeButton(context),
          ],
          title: FlatButton(
            hoverColor: Colors.transparent,
            onPressed: () {
              locator<NavigationService>().goBackToStart();
            },
            child: Text(
              'HOME', // kWebsiteTitle.toUpperCase(),
              style: kWebsiteTitleTextStyle,
            ),
          ),
        )
      : PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: TopBarContents(opacityVal),
        );
}
