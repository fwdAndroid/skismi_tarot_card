import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skismi_tarot_card/database/databasemethods.dart';

import 'package:skismi_tarot_card/user_info.dart';

class EmailAuthSignUp extends StatefulWidget {
  const EmailAuthSignUp({super.key});

  @override
  State<EmailAuthSignUp> createState() => _EmailAuthSignUpState();
}

class _EmailAuthSignUpState extends State<EmailAuthSignUp> {
  bool _isLoading = false;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sign Up"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Image.asset(
            "assets/logo.png",
            height: 170,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            decoration: BoxDecoration(
              color: Color(0xffC4C4C4), // set the background color
              borderRadius:
                  BorderRadius.circular(10), // optional: set border radius
            ),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.email_outlined),
                hintText: 'Enter Email',
                border: InputBorder.none, // remove border
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 15), // optional: set padding
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            decoration: BoxDecoration(
              color: Color(0xffC4C4C4), // set the background color
              borderRadius:
                  BorderRadius.circular(10), // optional: set border radius
            ),
            child: TextFormField(
              controller: pass,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.password),

                hintText: 'Enter Password',
                border: InputBorder.none, // remove border
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: 15), // optional: set padding
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(fixedSize: Size(320, 40)),
                    child: Text("Sign Up"),
                    onPressed: signUp,
                  ),
          ),
        ],
      ),
    );
  }

  void signUp() async {
    if (email.text.isEmpty || pass.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All Fields are Required")));
    } else {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: pass.text)
          .then((value) {
        DatabaseMethods().numberAdd().then((value) => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => ProfileInfo()))
            });
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Sign Up Complete")));
    }
  }
}
