import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:skismi_tarot_card/ads/ads_service.dart';
import 'package:skismi_tarot_card/main_screen_pages/experts.dart';
import 'package:skismi_tarot_card/main_screen_pages/settings.dart';
import 'package:skismi_tarot_card/webpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final DocumentReference userRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  final List<String> imgList = [
    'assets/blackball.png',
    'assets/gold.png',
    'assets/ww.png',
    'assets/women.png',
    'assets/hs.png',
    'assets/clouds.png',
    'assets/cjs.png',
  ];
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  void initState() {
    _loadBannerAd();
    _createInterstitialAd();
  }

  InterstitialAd? _interstitialAd;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_isBannerAdReady)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: _bannerAd.size.width.toDouble(),
                  height: _bannerAd.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd),
                ),
              ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 20),
              height: 60,
              child: Text(
                "Welcome to the Skismi Tarot Card Reading app. Discover your destiny with Skismi's AI-generated readings.",
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
                child: GestureDetector(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  autoPlay: true,
                ),
                items: choices
                    .map((Choice) => Container(
                          height: MediaQuery.of(context).size.height,
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (builder) => ChatScreen(
                              //             name: Choice.content,
                              //             uuid: Choice.content)));
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    Choice.title,
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 300,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints.expand(
                                    width: 200,
                                    height: 115,
                                  ),
                                  child: Text(
                                    Choice.content,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            )),
            ElevatedButton(
                onPressed: () async {
                  _createInterstitialAd();
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(
                          child: Text(
                            'Free Daily Readings',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              TextButton(
                                child: Text("One Card Tarot Card Reading"),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => MyWidget(
                                                title:
                                                    "One Card Tarot Card Reading",
                                                url:
                                                    "https://skismi.com/tarot-card-results-trial/",
                                              )));
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                child: Text("Sarcastic Tarot Card Reading"),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => MyWidget(
                                                title:
                                                    "Sarcastic Tarot Card Reading",
                                                url:
                                                    "https://skismi.com/sarcastic-tarot/",
                                              )));
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                child: Text(
                                    'Uplifting "Oprah" Style Tarot Card Reading'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => MyWidget(
                                                title:
                                                    'Uplifting "Oprah" Style Tarot Card Reading',
                                                url:
                                                    "https://skismi.com/oprah-tarot/",
                                              )));
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                child: Text('Wildcard Tarot Card Reading'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => MyWidget(
                                                title:
                                                    'Wildcard Tarot Card Reading',
                                                url:
                                                    "https://skismi.com/tarot-wildcard/",
                                              )));
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                child: Text('Past Life Tarot Card Reading'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => MyWidget(
                                                title:
                                                    'Past Life Tarot Card Reading',
                                                url:
                                                    "https://skismi.com/tarot-past/",
                                              )));
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                child: Text('Spirit Animal Tarot Card Reading'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => MyWidget(
                                                title:
                                                    ' Spirit Animal Tarot Card Reading',
                                                url:
                                                    "https://skismi.com/tarot-spirit/",
                                              )));
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                child: Text('Elemental Tarot Card Reading'),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) => MyWidget(
                                                title:
                                                    'Elemental Tarot Card Reading',
                                                url:
                                                    "https://skismi.com/tarot-elemental/",
                                              )));
                                },
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"))
                        ],
                      );
                    },
                  );
                  Text(
                    "Free Readings",
                    style: TextStyle(color: Colors.white),
                  );
                },
                child: Text("Free Readings"),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(), fixedSize: Size(200, 60))),
            SizedBox(
              height: 20,
            ),
            // Center(
            //   child: Container(
            //     height: 60,
            //     margin: EdgeInsets.only(right: 10),
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: StreamBuilder(
            //           stream: FirebaseFirestore.instance
            //               .collection("users")
            //               .where(
            //                 "uid",
            //                 isEqualTo: FirebaseAuth.instance.currentUser!.uid,
            //               )
            //               .where("paid", isEqualTo: false)
            //               .where("subscriptionTaken", isEqualTo: false)
            //               .snapshots(),
            //           builder: (BuildContext context,
            //               AsyncSnapshot<QuerySnapshot> snapshot) {
            //             if (snapshot.hasError) {
            //               return Text('Something went wrong');
            //             }

            //             if (snapshot.connectionState ==
            //                 ConnectionState.waiting) {
            //               return Text("Loading");
            //             }

            //             return ListView(
            //                 children: snapshot.data!.docs
            //                     .map((DocumentSnapshot document) {
            //               Map<String, dynamic> data =
            //                   document.data()! as Map<String, dynamic>;

            //               return Column(
            //                 children: [
            //                   subscription.activeSubscription
            //                       ? const Text(
            //                           "You have unlimited readings",
            //                           style: TextStyle(color: Colors.white),
            //                         )
            //                       : const Text(
            //                           "Free Readings Left This Week",
            //                           style: TextStyle(color: Colors.white),
            //                         ),
            //                   const SizedBox(
            //                     height: 10,
            //                   ),
            //                   // Center(
            //                   //   child: !subscription.activeSubscription
            //                   //       ? Text(
            //                   //           data['count'].toString(),
            //                   //           style: const TextStyle(
            //                   //               color: Colors.white, fontSize: 12),
            //                   //         )
            //                   //       : null,
            //                   // ),
            //                 ],
            //               );
            //             }).toList());
            //           }),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Rooms
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => Experts()));
                    },
                    child: Image.asset(
                      "assets/black.png",
                      height: 60,
                      width: 60,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  //Trail

                  //Privacy
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => AppSettings()));
                    },
                    child: Image.asset(
                      "assets/setting.png",
                      height: 60,
                      width: 60,
                    ),
                  ),
                  //Chat
                  SizedBox(
                    width: 30,
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => MyWidget(
                                    url: "https://skismi.com/tarotvideos/",
                                    title: "Video Page",
                                  )));
                    },
                    child: Image.asset(
                      "assets/video.png",
                      height: 60,
                      width: 60,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            // _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            // _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            _createInterstitialAd();
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void _loadBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }
}

//?Coursel Class
class Choice {
  const Choice({required this.title, required this.content});

  final String title;

  final String content;
}

const List<Choice> choices = const <Choice>[
  const Choice(
      title: 'assets/One Card Tarot Card Reading.png',
      content:
          'Gain quick insights and guidance with a single card reading. Discover concise messages from the cards'),
  const Choice(
      title: 'assets/Three Card Tarot Card Reading.png',
      content:
          'Dive deeper into your situation with a three-card reading. Explore past, present, and future influences for valuable perspectives.'),
  const Choice(
      title: 'assets/Career Tarot Card Reading.png',
      content:
          'Seek guidance and clarity for your professional life. Uncover hidden opportunities, obstacles, and insights to empower your career decisions'),
  const Choice(
      title: 'assets/Relationship Tarot Card Reading.png',
      content:
          'Gain valuable insights into your romantic relationships. Explore dynamics, challenges, and potential outcomes to nurture and improve your love life'),
  const Choice(
      title: 'assets/Celtic Cross Spread Tarot Card Reading.png',
      content:
          'Experience the depth of the Celtic Cross spread. Uncover layers of meaning and explore past, present, and future influences.'),
  const Choice(
      title: 'assets/Horshoe Spread Tarot Card Reading.png',
      content:
          "Your Horseshoe Spread reading will help you discover a unbique perspective on your life's path. Explore energies and gain insights into key areas of your life."),
  const Choice(
      title: 'assets/Pentagram Spread Tarot Card Reading.png',
      content:
          "Your Pentacle Spread will unveil the hidden meanings and connections within your life's journey. Explore the elements and aspects that shape your experiences."),
];
