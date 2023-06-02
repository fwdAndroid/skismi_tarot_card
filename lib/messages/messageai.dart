import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skismi_tarot_card/messages/chat_screen.dart';

class MessageAI extends StatefulWidget {
  MessageAI({
    super.key,
  });

  @override
  State<MessageAI> createState() => _MessageAIState();
}

class _MessageAIState extends State<MessageAI> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('cardsreading')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("messageslist")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Text(
                  "Loading",
                  style: TextStyle(color: Colors.white),
                ));
              }
              // if (snapshot.hasData != ConnectionState.done) {
              //   return Center(
              //       child: Text(
              //     "No Chat Available",
              //     style: TextStyle(color: Colors.white),
              //   ));
              // }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => ChatScreen(
                                      name: data['name'], uuid: data["uuid"])));
                        },
                        leading: CircleAvatar(
                          backgroundImage: AssetImage("assets/logo.png"),
                        ),
                        title: Text(
                          data['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('cardsreading')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection("messageslist")
                                .doc(document.id)
                                .delete();
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                      )
                    ],
                  );
                }).toList(),
              );
            }));
  }
}
