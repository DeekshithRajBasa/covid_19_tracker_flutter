import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

import 'package:webview_flutter/webview_flutter.dart';

class map extends StatefulWidget {
  @override
  _mapState createState() => _mapState();
}

class _mapState extends State<map> {
  var isLoading;

  initState() {
    isLoading = true;
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.map, color: Colors.white,),
            SizedBox(width: 5,),
            Text("Covid-19 Map",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                )),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
           WebView(
                  initialUrl: 'https://bing.com/covid',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                  onPageFinished: (_) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
          isLoading
              ? Container(
                  child: Center(
                    child: Loading(
                        indicator: BallPulseIndicator(),
                        size: 50.0,
                        color: Colors.deepPurple),
                  ),
                ) : Container(
            height: 50,
            color: Colors.transparent,
          )
        ],
      ),
    );
  }
}
