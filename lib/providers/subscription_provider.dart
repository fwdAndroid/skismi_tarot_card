

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SubscriptionProvider with ChangeNotifier {

  String userEmail = '';
  List<dynamic> data = [];
  bool activeSubscription = false;

  //final firebaseUserID = FirebaseAuth.instance.currentUser;


  // Get data from firestore
  Future getData() async {
    List<dynamic> userData = [];

    final firebaseUserID = FirebaseAuth.instance.currentUser;
    debugPrint("Firebase uid = $firebaseUserID");

    if (firebaseUserID != null) {
      try {
        var value = await FirebaseFirestore.instance.
        collection('users').
        doc(firebaseUserID.uid).
        get();
        userData = value
            .data()!.entries
            .map((e) => e.value)
            .toList();
        data = userData;
        userEmail = data[10];
          print("user email => $userEmail");

      } catch (e) {
        print(e.toString());
      }
    }
  }

  // check if user have an active subscription
  Future checkUserSubscription() async {
   await getData();
    final firebaseUserID = FirebaseAuth.instance.currentUser;
    var subscribedCollection = FirebaseFirestore.instance.collection("subscribed_users");

    if (firebaseUserID != null) {
      try {
        print("collection => $subscribedCollection");
        var emailPresent = await subscribedCollection.where("email", isEqualTo: userEmail).get();
        var num = emailPresent.size;
        if(num >= 1) {
          activeSubscription = true;
          notifyListeners();
        } else {
          activeSubscription = false;
          notifyListeners();
        }
        print("Num of occurrence => $num");
        print("activeSubscription ======>>>>> $activeSubscription");
      } catch (e) {
        print(e.toString());
      }
    }
  }
}