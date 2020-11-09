import 'package:flutter/material.dart';
import 'package:flutter_study_web/routes.dart';
import 'package:flutter_study_web/widgets/default_page_frame.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AWSRealtimeSocketTutorialPage extends StatefulWidget {
  @override
  _AWSRealtimeSocketTutorialPageState createState() =>
      _AWSRealtimeSocketTutorialPageState();
}

class _AWSRealtimeSocketTutorialPageState
    extends State<AWSRealtimeSocketTutorialPage> {
  TextEditingController userNameController = TextEditingController();

  void startChat() {
    if (userNameController.text.isNotEmpty) {
      locator<NavigationService>().navigateTo(
        AWSRealtimeChatPageRoute,
        queryParams: {
          'userName': userNameController.text,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);

    return DefaultPageFrame(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            width: screenSize.width * 0.6,
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Colors.grey.shade600,
            //   ),
            // ),
            //color: Colors.grey.shade300,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      hintText: "Type user name here...",
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                IconButton(
                  icon: Icon(Icons.group_add),
                  onPressed: startChat,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
