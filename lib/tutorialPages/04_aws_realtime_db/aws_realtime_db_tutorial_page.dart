// https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/ApiGatewayManagementApi.html

/*
sls invoke -f databaseStreamHandler -d '{"randNum": 12345, "msg": "msg from invoke", "connectionId": "U9JwfeC1IAMCFIQ=", "domainName": "us2q8s4g99.execute-api.us-east-1.amazonaws.com", "stage": "dev"}'
*/
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_study_web/widgets/default_page_frame.dart';
// import 'package:web_socket_channel/html.dart';
// import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';
//import 'package:web_socket_channel/web_socket_channel.dart';
//if (dart.library.io) 'package:web_socket_channel/io.dart';

class AWSRealtimeDBTutorialPage extends StatefulWidget {
  AWSRealtimeDBTutorialPage({@required this.socketChannel});
  final WebSocketChannel socketChannel;

  @override
  _AWSRealtimeDBTutorialPageState createState() =>
      _AWSRealtimeDBTutorialPageState();
}

class _AWSRealtimeDBTutorialPageState extends State<AWSRealtimeDBTutorialPage> {
  String socketData;

  @override
  void initState() {
    // Check socket status
    //print('Socket Status: ${widget.socketChannel.}');

    widget.socketChannel.stream.listen(
      (message) {
        print('Message from stream listen: ${message}');
        Map data = jsonDecode(message);
        setState(() => socketData = message);
      },
      onDone: () {
        print('Socket disconnected...');
      },
      onError: (err) {
        print('Socket on error: ${err}');
      },
      cancelOnError: true,
    );

    super.initState();
  }

  @override
  void dispose() {
    widget.socketChannel.sink.close();
    super.dispose();
  }

  void _onWriteToDynamoDB() async {
    // Generate a random number
    var rng = new Random();
    int generatedInt = rng.nextInt(10000);
    // Write through lambda function & API Gateway
    widget.socketChannel.sink.add(jsonEncode({
      "action": "databaseStream",
      "data": {
        "body": {"randNum": generatedInt, "msg": "tester from ${generatedInt}"}
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);

    return DefaultPageFrame(
      body: Column(
        children: [
          Container(
            child: FlatButton(
              onPressed: _onWriteToDynamoDB,
              child: Text(
                'Write to DynamoDB',
                style: themeData.primaryTextTheme.button,
              ),
              color: themeData.buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Theme.of(context).buttonColor),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Text(socketData != null ? '${socketData}' : 'Empty'),
            ),
          )
          // StreamBuilder(
          //   stream: widget.socketChannel.stream,
          //   builder: (context, snapshot) {
          //     return Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 24.0),
          //       child: Text(snapshot.hasData ? '${snapshot.data}' : 'Empty'),
          //     );
          //   },
          // )
        ],
      ),
    );
  }
}
