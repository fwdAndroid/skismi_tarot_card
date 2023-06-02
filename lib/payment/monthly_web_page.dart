import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:skismi_tarot_card/main_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class MonthlyWebPage extends StatefulWidget {
  String url;
  String title;

  MonthlyWebPage({required this.title, required this.url});
  @override
  _MonthlyWebPageState createState() => new _MonthlyWebPageState();
}

class _MonthlyWebPageState extends State<MonthlyWebPage> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  PullToRefreshController? pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();
  List<String> loadedResources = [];
  bool _showButton = false;

  @override
  void initState() {
    super.initState();

    // land();
    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(widget.title),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
            child: Column(children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                InAppWebView(
                  key: webViewKey,
                  initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions()),
                  pullToRefreshController: pullToRefreshController,
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onLoadStart: (controller, url) {
                    setState(() {
                      this.url = url.toString();
                      urlController.text = this.url;
                    });
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    var uri = navigationAction.request.url!;

                    if (![
                      "http",
                      "https",
                      "file",
                      "chrome",
                      "data",
                      "javascript",
                      "about"
                    ].contains(uri.scheme)) {
                      if (await canLaunchUrl(uri)) {
                        // Launch the App
                        await launchUrl(
                          uri,
                        );
                        // and cancel the request
                        return NavigationActionPolicy.CANCEL;
                      }
                      if (url.toString().contains("/success")) {
                        setState(() {
                          _showButton = true;
                        });
                      }
                    }

                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadStop: (controller, url) async {
                    // pullToRefreshController?.endRefreshing();
                    if (url.toString().contains("/success")) {
                      setState(() {
                        _showButton = true;
                      });
                    }
                  },
                  onProgressChanged: (controller, progress) {
                    if (progress == 100) {
                      pullToRefreshController?.endRefreshing();
                    }
                    setState(() {
                      this.progress = progress / 100;
                      urlController.text = this.url;
                    });
                  },
                  onUpdateVisitedHistory: (controller, url, androidIsReload) {
                    setState(() {
                      this.url = url.toString();
                      urlController.text = this.url;
                    });
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    print(consoleMessage);
                  },
                ),
                progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container(),
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_showButton)
                ElevatedButton(
                  child: Text("Confirm Payment"),
                  onPressed: () async {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Center(
                            child: const Text(
                              'Payment is confirm You can Delete the Subscription from Setting',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[],
                            ),
                          ),
                          actions: [
                            TextButton(
                              child: Text("Confirm"),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  "paid": true,
                                  "price": "14.99",
                                  "subscriptionType": "Monthly",
                                  "subscriptionTaken": true
                                }).then((value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => MainScreen()));
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ElevatedButton(
                child: Text("Back"),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ])));
  }

  // void land() {
  //   Timer(Duration(seconds: 5), () async {
  //     final documentReference = FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid);
  //     final snapshot = await documentReference.get();
  //     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  //     final currentValue = data['count'];
  //     var lastValue = currentValue - 1;
  //     documentReference.update({"count": lastValue});
  //   });
  // }
}
