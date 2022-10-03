import 'package:chatapp/models/button.dart';
import 'package:chatapp/modules/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegScreen extends StatefulWidget {
  static const String screenRoute = 'registration_screen';

  @override
  _RegScreenState createState() => _RegScreenState();
}

class _RegScreenState extends State<RegScreen> {
  final _auth = FirebaseAuth.instance;
  late String emailController ;
  late String passwordController;
  bool showSpinner=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Image.asset('images/comments.png'),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (String value) {
                  print(value);
                  emailController=value;
                },

                decoration: InputDecoration(
                  labelText: 'Email Address',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.grey, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
                  prefixIcon: Icon(
                    Icons.email,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onChanged: (String value) {
                  print(value);
                  passwordController=value;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                  ),
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              MyButton(
                  color: Colors.blue[500]!,
                  text: 'Sign up',
                  onPressed: () async {
                    setState(() {
                      showSpinner=true;
                    });
                    try{
                      final newUser= await _auth.createUserWithEmailAndPassword(
                          email: emailController,
                          password: passwordController,
                      );
                          Navigator.pushNamed(context, ChatScreen.screenRoute);
                          setState(() {
                            showSpinner=false;
                          });
                    }catch(e){
                      print(e);
                    };

                  })
            ],
          ),
        ),
      ),
    );
  }
}
