import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chatapp/modules/home/welcom_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/modules/login/login_screen.dart';
import 'package:chatapp/modules/home/welcom_screen.dart';
import 'package:chatapp/modules/chat/chat_screen.dart';
import 'package:chatapp/modules/login/AuthScreen.dart';
import 'package:chatapp/modules/login/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Splach extends StatelessWidget {
  static const String screenRoute='Splach';
  final _auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        backgroundColor: Colors.deepPurple,
        duration:4000 ,
        splashIconSize: 150,
        splashTransition: SplashTransition.fadeTransition,
        animationDuration:Duration(seconds: 1) ,
        splash: Container(
            child:Image.asset('images/comments.png')
        ),
        nextScreen: _auth.currentUser!=null ? ChatScreen() : WelcomeScreen());
  }
}
