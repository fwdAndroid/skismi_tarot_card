import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:skismi_tarot_card/auth/login_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  MobileAds.instance
    ..initialize()
    ..updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: ['7C92BD192385F05DDBD6FC73370E2D63']),
    );

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.getDefaultUserAgent();
  }
  // Stripe.publishableKey = "pk_live_mnEMRXbl42AKpewOLEuBZDzD";

  // await Stripe.instance.applySettings();

  await Firebase.initializeApp();

  runApp(
    MaterialApp(home: MyApp()

        // TakePictureScreen(
        //   // Pass the appropriate camera to the TakePictureScreen widget.
        //   camera: firstCamera,
        // ),
        ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        nextScreen: LoginScreen(),
        splash: Image.asset(
          'assets/logo.png',
          fit: BoxFit.cover,
        ),
        duration: 3000,
        splashIconSize: 400,
        splashTransition: SplashTransition.slideTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: Colors.black,
      ),
    );
  }
}
