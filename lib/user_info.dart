import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skismi_tarot_card/database/databasemethods.dart';
import 'package:skismi_tarot_card/payment/subcription_ask.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Skismi Horoscope and Astrology",
            style:
                GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            decoration: BoxDecoration(
              color: Color(0xffC4C4C4), // set the background color
              borderRadius:
                  BorderRadius.circular(10), // optional: set border radius
            ),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: phone,
              decoration: InputDecoration(
                hintText: 'Enter Phone Number',
                border: InputBorder.none, // remove border
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 16), // optional: set padding
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
              controller: firstname,
              decoration: InputDecoration(
                hintText: 'Enter First Name',
                border: InputBorder.none, // remove border
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 16), // optional: set padding
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
              controller: lastname,
              decoration: InputDecoration(
                hintText: 'Enter Last Name',
                border: InputBorder.none, // remove border
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 16), // optional: set padding
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: profile,
              child: _isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Text(
                      "Go",
                      style: GoogleFonts.roboto(fontSize: 22),
                    ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(240, 60),
                shape: StadiumBorder(),
                primary: Color(0xff09F9BF).withOpacity(.5),
                onSurface: Color(0xff0ACF83).withOpacity(.5),
                shadowColor: Color(0xff09F9BF).withOpacity(.5),
              )),
        ],
      ),
    );
  }

  profile() async {
    if (phone.text.isEmpty || firstname.text.isEmpty || lastname.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All Fields are required")));
    } else {
      setState(() {
        _isLoading = true;
      });
      String rse = await DatabaseMethods().profileDetail(
        subscriptionTaken: false,
        subscriptionType: "zero",
        promoCode: "",
        price: "0",
        phoneNumber: phone.text,
        firstName: firstname.text,
        lastName: lastname.text,
        count: 3,
        blocked: false,
        email: FirebaseAuth.instance.currentUser!.email!,
        paid: false,
        uid: FirebaseAuth.instance.currentUser!.uid,
      );

      print(rse);
      setState(() {
        _isLoading = false;
      });
      if (rse == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => SubsriptionAsk(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error")));
      }
    }
  }
}
