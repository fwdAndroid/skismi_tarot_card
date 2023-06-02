import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skismi_tarot_card/main_screen_pages/experts.dart';
import 'package:skismi_tarot_card/status/blockuser.dart';

class UserStatus extends StatefulWidget {
  const UserStatus({super.key});

  @override
  State<UserStatus> createState() => _UserStatusState();
}

class _UserStatusState extends State<UserStatus> {
  final DocumentReference userRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Verifying User's"),
      ),
    );
  }

  void check() async {
    final DocumentSnapshot userSnapshot = await userRef.get();
    Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;

    ;
    final isBlocked = data['blocked'];
    if (isBlocked == true) {
      // User is blocked
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => BlockUser()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => Experts()));
    }
  }
}

// // Reference to the user's document
// final DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc('user_id');

// // Query the user's document
// final DocumentSnapshot userSnapshot = await userRef.get();

// // Check if the user is blocked or unblocked
// final bool isBlocked = userSnapshot.data()['blocked'];

// if (isBlocked) {
//   // User is blocked
// } else {
//   // User is unblocked
// }

// import 'package:cloud_firestore/cloud_firestore.dart';

// // Reference to the user's document
// final DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc('user_id');

// // Query the user's document
// final DocumentSnapshot userSnapshot = await userRef.get();

// // Check if the user is blocked or unblocked
// final bool isBlocked = userSnapshot.data()['blocked'];


