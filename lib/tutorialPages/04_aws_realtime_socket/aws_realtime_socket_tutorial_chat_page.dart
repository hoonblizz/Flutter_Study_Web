import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_study_web/routes.dart';
import 'package:flutter_study_web/widgets/default_page_frame.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AWSRealtimeSocketTutorialChatPage extends StatefulWidget {
  AWSRealtimeSocketTutorialChatPage({
    @required this.socketChannel,
    @required this.userName,
  });
  final String userName;
  final WebSocketChannel socketChannel;

  @override
  _AWSRealtimeSocketTutorialChatPageState createState() =>
      _AWSRealtimeSocketTutorialChatPageState();
}

class _AWSRealtimeSocketTutorialChatPageState
    extends State<AWSRealtimeSocketTutorialChatPage> {
  TextEditingController msgController = TextEditingController(text: '');

  String socketData;
  Map connectionData;

  @override
  void initState() {
    widget.socketChannel.stream.listen(
      (message) {
        print('Message from stream listen: $message');
        Map tempMessageParser = jsonDecode(message);

        // Result from ping
        bool fromPing = false;
        if (tempMessageParser.containsKey('fromLogin') &&
            tempMessageParser['fromLogin']) {
          fromPing = true;
        }
        setState(() {
          socketData = message;
          if (fromPing) connectionData = tempMessageParser;
        }); // display WHATEVER data received
      },
    );
    // Start listening socket stream
    // widget.socketChannel.stream.listen(
    //   (message) {
    //     print('Message from stream listen: $message');
    //     Map tempMessageParser = jsonDecode(message);

    //     // Result from ping
    //     bool fromPing = false;
    //     if (tempMessageParser.containsKey('fromLogin') &&
    //         tempMessageParser['fromLogin']) {
    //       fromPing = true;
    //     }
    //     setState(() {
    //       socketData = message;
    //       if (fromPing) connectionData = tempMessageParser;
    //     }); // display WHATEVER data received
    //   },
    //   onError: (e) {
    //     print('Error listening: ${e.toString()}');
    //     // Maybe disconnected or server not working. Go back.
    //     showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           title: Text("Disconnected"),
    //           content: Text(
    //               "You are disconnected from the chat room. Going back..."),
    //           actions: [
    //             FlatButton(
    //               child: Text("OK"),
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //                 locator<NavigationService>().goBack();
    //               },
    //             ),
    //           ],
    //         );
    //       },
    //     );
    //   },
    //   cancelOnError: true,
    // );

    //_login(); // Ping to get connection info

    super.initState();
  }

  @override
  void dispose() {
    // Make sure to close the stream when its not in use
    widget.socketChannel.sink.close();
    super.dispose();
  }

  void _login() async {
    widget.socketChannel.sink.add(jsonEncode({
      "action": "databaseWebSocket",
      "userName": widget.userName,
    }));
    print('login requested.....${widget.userName}');
  }

  void _onWriteThroughSocket() async {
    // Write through lambda function & API Gateway
    widget.socketChannel.sink.add(jsonEncode({
      "action": "databaseWebSocket",
      "msg": "tester message",
    }));
  }

  void sendMessage() {
    // Grab text and send out
    print('Sending text: ${msgController.text}');
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return DefaultPageFrame(
      body: Column(
        children: [
          Container(
            height: 500,
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // List of messages here
                    _chatMessage(),
                    SizedBox(
                      height: 25,
                    ),
                    _charInput(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatMessage() {
    // If message from me, align right, otherwiase align left
    return Container(
      alignment: Alignment.centerLeft,
      child: Text('Hiiiiiiiisssssss111111100000999'),
    );
  }

  Widget _charInput() {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: msgController,
              decoration: InputDecoration(
                hintText: "Type messages here...",
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
            icon: Icon(Icons.send),
            onPressed: sendMessage,
          ),
        ],
      ),
    );
  }
}
