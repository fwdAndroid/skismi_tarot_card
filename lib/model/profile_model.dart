import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileModel {
  String uid;
  String promoCode;
  bool? subscriptionTaken;
  String? firstname;
  String? lastname;
  String? phonenumber;
  bool paid;
  bool blocked;
  int count;
  String? subscriptionType;
  String? email;
  String? price;

  ProfileModel(
      {this.phonenumber,
      required this.uid,
      required this.promoCode,
      this.lastname,
      this.subscriptionTaken,
      this.firstname,
      required this.blocked,
      required this.paid,
      required this.count,
      this.email,
      this.price,
      this.subscriptionType});

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'phonenumber': phonenumber,
        'uid': uid,
        'lastname': lastname,
        'subscriptionTaken': subscriptionTaken,
        'firstname': firstname,
        'paid': paid,
        'promoCode': promoCode,
        'count': count,
        'email': email,
        'price': price,
        'blocked': blocked,
        'subscriptionType': subscriptionType
      };

  ///
  static ProfileModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return ProfileModel(
        phonenumber: snapshot['phonenumber'],
        uid: snapshot['uid'],
        lastname: snapshot['lastname'],
        subscriptionTaken: snapshot['subscriptionTaken'],
        firstname: snapshot['firstname'],
        paid: snapshot['paid'],
        blocked: snapshot['blocked'],
        count: snapshot['count'],
        email: snapshot['email'],
        promoCode: snapshot['promoCode'],
        price: snapshot['price'],
        subscriptionType: snapshot['subscriptionType']);
  }
}
