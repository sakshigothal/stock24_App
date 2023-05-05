import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stock24/Colors/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // floatingActionButton: Text('Next Generation App',style: TextStyle(fontSize: 18,color: whiteColor)),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: primaryColor,
      body: Image.asset('assets/WelcomeScreen/Google Pixel 4, 4XL – 2.png')
      //  Center(
      //   child: Text('Stock24',style: TextStyle(fontSize: 64,color: whiteColor)),
      // ),
    );
  }
}
