import 'package:blood_hub/screens/auth/signUp.dart';
import 'package:blood_hub/screens/intro/onBoarding.dart';
import 'package:blood_hub/screens/intro/splash.dart';
import 'package:blood_hub/theme/theme.dart';
import 'package:blood_hub/widgets/request.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Blood Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: darkTheme,
      // theme: ThemeProvider.of(context),
      home: OnBoardingScreen(),
    );
  }
}
