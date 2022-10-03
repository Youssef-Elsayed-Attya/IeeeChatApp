
import 'package:chatapp/modules/login/login_screen.dart';
import 'package:chatapp/modules/home/welcom_screen.dart';
import 'package:chatapp/modules/chat/chat_screen.dart';
import 'package:chatapp/modules/login/AuthScreen.dart';
import 'package:chatapp/modules/login/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'modules/intro/Splach.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  // WidgetsFlutterBinding.ensureInitialized();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        backgroundColor: Colors.deepPurple,
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark
      ),
      //home: WelcomeScreen(),
      initialRoute: Splach.screenRoute ,
      routes: {
        Splach.screenRoute:(context)=>Splach(),
        WelcomeScreen.screenRoute:(context)=>WelcomeScreen(),
        RegScreen.screenRoute:(context)=>RegScreen(),
        LoginScreen.screenRoute:(context)=>LoginScreen(),
        ChatScreen.screenRoute:(context)=>ChatScreen(),
      } ,
    );
  }
}

