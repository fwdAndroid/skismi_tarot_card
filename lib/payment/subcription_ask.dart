import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:skismi_tarot_card/ads/ads_service.dart';
import 'package:skismi_tarot_card/main_screen.dart';
import 'package:skismi_tarot_card/payment/monthly_web_page.dart';
import 'package:skismi_tarot_card/payment/weekly_web_page.dart';
import 'package:skismi_tarot_card/payment/yearly_web_page.dart';

class SubsriptionAsk extends StatefulWidget {
  SubsriptionAsk({super.key});

  @override
  State<SubsriptionAsk> createState() => _SubsriptionAskState();
}

class _SubsriptionAskState extends State<SubsriptionAsk> {
  TextEditingController controller = TextEditingController();
  Map<String, dynamic>? paymentIntent;
  int selectedIndex = 0;
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Skismi Horoscope Astrology",
            style:
                GoogleFonts.roboto(fontSize: 40, fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    // _showInterstitialAd();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => MainScreen()));
                  },
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.yellowAccent,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Image.asset("assets/ss.png"),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Subscription Guide'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text(
                                    'When the page is open please click on the "continue" button in the center of the page. After submitting your payment, please wait to click on the "Confirm payment" button to process your subscription.'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Continue'),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => WeeklyWebPage(
                                              title: "Weekly",
                                              url:
                                                  "https://checkout.stripe.com/c/pay/cs_live_b1u5Ov4moSYZT6GCvr21rXzCJGPSKeUpmTpNXUlHdXiaHjeUXcbP7EkNLV#fidkdWxOYHwnPyd1blppbHNgWmhrQEhXXWdpMTdETnVgckpJQHBHX0F%2FQScpJ3VpbGtuQH11anZgYUxhJz8nM2pAM3dNNnxgY2RwNlxmZkhIJyknd2BjYHd3YHdKd2xibGsnPydtcXF1Pyoqdm5sdmhsK2ZqaConeCUl",
                                              //"https://buy.stripe.com/test_fZe9Eba2i5zJ1yg5kk"
                                            )));
                              },
                            ),
                            TextButton(
                              child: const Text('Back'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffFDDC5C),
                        borderRadius: BorderRadius.circular(25)),
                    width: 150,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Weekly",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("\$ 6.99")
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Subscription Guide'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text(
                                    'When the page is open please click on the "continue" button in the center of the page. After submitting your payment, please wait to click on the "Confirm payment" button to process your subscription.'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Continue'),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => MonthlyWebPage(
                                              title: "Monthly",
                                              url:
                                                  "https://checkout.stripe.com/c/pay/cs_live_b1h3HdLi5vUcJmTcHJM0ExMMo0CCkhlt6qgr8pk4s30kXD2l4wDI7HMfk1#fidkdWxOYHwnPyd1blppbHNgWmhrQEhXXWdpMTdETnVgckpJQHBHX0F%2FQScpJ3VpbGtuQH11anZgYUxhJz8nM2pAMW9%2FPFJGM0FcNFQxNTU0Jyknd2BjYHd3YHdKd2xibGsnPydtcXF1Pyoqdm5sdmhsK2ZqaConeCUl ",
                                            )));
                              },
                            ),
                            TextButton(
                              child: const Text('Back'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xffFDDC5C),
                        borderRadius: BorderRadius.circular(25)),
                    width: 150,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Monthly",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("\$ 14.99")
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () async {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Subscription Guide'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text(
                                'When the page is open please click on the "continue" button in the center of the page. After submitting your payment, please wait to click on the "Confirm payment" button to process your subscription.'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Continue'),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => YearlyWebPage(
                                          title: "Yearly",
                                          url:
                                              "https://checkout.stripe.com/c/pay/cs_live_b15J9bBXB1QJpf5XeiLRcL991oOiXrqUtnOddG1PVt5O9ZmQ6qYEulY3Rx#fidkdWxOYHwnPyd1blppbHNgWmhrQEhXXWdpMTdETnVgckpJQHBHX0F%2FQScpJ3VpbGtuQH11anZgYUxhJz8nY19gMW9%2FZzVCN2tMZ3RANz1kJyknd2BjYHd3YHdKd2xibGsnPydtcXF1Pyoqdm5sdmhsK2ZqaConeCUl ",
                                        )));
                          },
                        ),
                        TextButton(
                          child: const Text('Back'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffFDDC5C),
                    borderRadius: BorderRadius.circular(25)),
                width: 150,
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Yearly",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("\$ 59.99")
                  ],
                ),
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

  //Payment Function
}
