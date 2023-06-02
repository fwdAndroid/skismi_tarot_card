import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skismi_tarot_card/database/databasemethods.dart';
import 'package:skismi_tarot_card/status/checkstatus.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/logo.png"),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: SocialLoginButton(
              buttonType: SocialLoginButtonType.google,
              onPressed: () async {
                await DatabaseMethods().signInWithGoogle().then((value) async {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) => CheckStatus()));
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
