import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skismi_tarot_card/main_screen.dart';
import 'package:skismi_tarot_card/webpage.dart';

class Experts extends StatefulWidget {
  const Experts({super.key});

  @override
  State<Experts> createState() => _ExpertsState();
}

class _ExpertsState extends State<Experts> {
  int count = 3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => MainScreen()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text("Skismi Tarot Card App",
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 60,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => MyWidget(
                                  url:
                                      "https://skismi.com/tarot-card-results-trial/",
                                  title: "One Card Tarot Card Reading",
                                )));
                  },
                  child: Text("One Card Tarot Card Reading"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: 60,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => MyWidget(
                                  url:
                                      "https://skismi.com/tarot-card-results2/ ",
                                  title: "Three Card Tarot Card Reading",
                                )));
                  },
                  child: Text("Three Card Tarot Card Reading"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: 60,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => MyWidget(
                                  url: "https://skismi.com/tarot-card-career/ ",
                                  title: "Career Spread Tarot Card Reading",
                                )));
                  },
                  child: Text("Career Spread Tarot Card Reading"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: 60,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => MyWidget(
                                  url:
                                      "https://skismi.com/tarot-card-relationship/",
                                  title:
                                      "Relationship Spread Tarot Card Reading",
                                )));
                  },
                  child: Text("Relationship Spread Tarot Card Reading"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: 60,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => MyWidget(
                                  url: "https://skismi.com/tarot-card-celtic/",
                                  title:
                                      "Celtic Cross Spread Tarot Card Reading",
                                )));
                  },
                  child: Text("Celtic Cross Spread Tarot Card Reading"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: 60,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => MyWidget(
                                  url:
                                      "https://skismi.com/tarot-card-horseshoe ",
                                  title: "Horseshoe Spread Tarot Card Reading",
                                )));
                  },
                  child: Text("Horseshoe Spread Tarot Card Reading"),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: 60,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => MyWidget(
                                  url:
                                      "https://skismi.com/tarot-card-pentagram",
                                  title: "Pentagram Spread Tarot Card Reading",
                                )));
                  },
                  child: Text("Pentagram Spread Tarot Card Reading"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
