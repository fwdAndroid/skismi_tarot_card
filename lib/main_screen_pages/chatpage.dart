import 'package:flutter/material.dart';
import 'package:skismi_tarot_card/messages/messageai.dart';

class MyChat extends StatelessWidget {
  const MyChat({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Skismi'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "Messages",
              ),
              Tab(
                text: "Experts",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MessageAI(),
            MessageAI(),
          ],
        ),
      ),
    );
  }
}
