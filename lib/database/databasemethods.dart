import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skismi_tarot_card/model/profile_model.dart';

class DatabaseMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//Add Google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

//OTP Number Add
  Future<String> numberAdd() async {
    String res = 'Some error occured';
    try {
      //Add User to the database with modal
      ProfileModel userModel = ProfileModel(
        promoCode: "",
        paid: false,
        blocked: false,
        uid: FirebaseAuth.instance.currentUser!.uid,
        subscriptionTaken: false,
        email: FirebaseAuth.instance.currentUser!.email,
        subscriptionType: '',
        price: '',
        count: 3,
        firstname: '',
        lastname: '',
        phonenumber: '',
      );
      await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
            userModel.toJson(),
          );
      res = 'success';
      debugPrint(res);
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Profile Details
  Future<String> profileDetail(
      {required String uid,
      required String firstName,
      required String lastName,
      required String phoneNumber,
      required int count,
      required String email,
      required bool blocked,
      required String subscriptionType,
      required String promoCode,
      required String price,
      required bool subscriptionTaken,
      required bool paid}) async {
    String res = 'Some error occured';

    try {
      //Add User to the database with modal

      ProfileModel userModel = ProfileModel(
        firstname: firstName,
        lastname: lastName,
        promoCode: promoCode,
        email: email,
        phonenumber: phoneNumber,
        price: price,
        count: count,
        blocked: blocked,
        subscriptionType: subscriptionType,
        subscriptionTaken: false,
        paid: paid,
        uid: FirebaseAuth.instance.currentUser!.uid,
      );
      await firebaseFirestore
          .collection('users')
          .doc(uid)
          .update(userModel.toJson());

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
