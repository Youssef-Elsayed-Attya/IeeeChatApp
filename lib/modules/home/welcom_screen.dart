import 'package:chatapp/models/button.dart';
import 'package:chatapp/modules/login/login_screen.dart';
import 'package:chatapp/modules/login/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String screenRoute='welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: Image.asset('images/comments.png'),
                ),
                Text(
                  'IEEE Message',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: Color(0xff2e386b),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            MyButton(
                color: Colors.deepPurpleAccent,
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.screenRoute);
                },
                text: 'Sign in'
            ),
            MyButton(
                color: Colors.blue[500]!,
                onPressed: () {
                  Navigator.pushNamed(context, RegScreen.screenRoute);
                },
                text: 'Sign up'
            ),
          ],
        ),
      ),
    );
  }
}
