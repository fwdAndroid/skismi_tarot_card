import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skismi_tarot_card/auth/login_screen.dart';
import 'package:mailto/mailto.dart';
import 'package:skismi_tarot_card/main_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key});

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Image.asset(
            "assets/logo.png",
            height: 250,
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            onTap: _launchURL,
            title: Text(
              "Privacy Policy",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            onTap: _launchTerms,
            title: Text(
              "Terms of Service",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          ListTile(
            onTap: _urlEmail,
            title: Text(
              "Member Support",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          // ListTile(
          //   onTap: () async {
          //     await FirebaseFirestore.instance
          //         .collection("users")
          //         .doc(FirebaseAuth.instance.currentUser!.uid)
          //         .update({"count": 3}).then((value) {
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (builder) => MainScreen()));
          //     });
          //   },
          //   title: Text(
          //     "Reset Counter",
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   trailing: Icon(
          //     Icons.arrow_forward_ios,
          //     color: Colors.white,
          //   ),
          // ),
          // Divider(
          //   color: Colors.white,
          // ),
          ListTile(
            onTap: () {
              Share.share(
                  'Check out the Skismi app https://skismi.com/download',
                  subject: 'Look what I made!');
            },
            title: Text(
              "Share",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where("subscriptionTaken", isEqualTo: true)
                .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              final documents = snapshot.data!.docs;
              final valueExists = documents.isNotEmpty;

              if (valueExists) {
                return Column(
                  children: [
                    ListTile(
                      onTap: offsub,
                      title: Text(
                        "Cancel Subscription",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                  ],
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
          ListTile(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    color: Colors.black,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            'Are you sure you want to exit?',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () async {
                                  await FirebaseAuth.instance
                                      .signOut()
                                      .then((value) => {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (builder) =>
                                                        LoginScreen()))
                                          });
                                },
                              ),
                              TextButton(
                                child: const Text('No'),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            title: Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
          Divider(
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    final Uri _url = Uri.parse('https://skismi.com/app-privacy/');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void _launchTerms() async {
    final Uri _url = Uri.parse('https://skismi.com/app-terms/');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'support@skismi.com',
    queryParameters: {
      'subject': 'Hello Skismi',
      'body': 'I have an query',
    },
  );

  void _urlEmail() async {
    final mailtoLink = Mailto(
      to: ['support@skismi.com'],
      subject: 'Hello Skismi',
      body: 'I have an query',
    );
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.
    await launch('$mailtoLink');
  }

  void offsub() {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alert'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Do you want To Turn off Your Subscription'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Yes'),
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update(
                    {"subscriptionTaken": false, "paid": false},
                  ).then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => MainScreen()));
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Subscription Off")));
                  });
                },
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
