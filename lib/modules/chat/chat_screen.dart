import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/chatForm.dart';

final _fireStore = FirebaseFirestore.instance;
late User signedInUser;

class ChatScreen extends StatefulWidget {
  static const String screenRoute = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextControler = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String? messageString;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getmessages()async {
  //  final messages= await _fireStore.collection('massages').get();
  //  for( var message in messages.docs){
  //   print(message.data());
  // }
  // }
  void messagesStreams() async {
    await for (var snapShot in _fireStore.collection('massages').orderBy('time').snapshots()) {
      for (var message in snapShot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
                height: 35,
                width: 35,
                child: Image.asset('images/comments.png')),
            SizedBox(
              width: 5,
            ),
            Text(
              'Chat',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              },
              icon: Icon(Icons.close))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamBuilder(),
            Container(
              decoration:
                  BoxDecoration(border: Border(top: BorderSide(width: 2))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: TextField(
                    controller: messageTextControler,
                    onChanged: (value) {
                      messageString = value;
                    },
                    decoration: InputDecoration(
                        hintText: 'Write your message...',
                        border: InputBorder.none),
                  )),
                  TextButton(
                      onPressed: () {
                        messageTextControler.clear();
                        _fireStore.collection('massages').add({
                          'text': messageString,
                          'sender': signedInUser.email,
                          'time' : FieldValue.serverTimestamp(),
                        });
                      },
                      child: Text(
                        'send',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w400,
                            fontSize: 20),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('massages').orderBy('time').snapshots(),
        builder: (context, snapShot) {
          List<MessageForm> messageWidgets = [];
          if (!snapShot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            );
          }
          final messages = snapShot.data!.docs.reversed;
          for (var message in messages) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final currentUser = signedInUser.email;
            if (currentUser == messageSender) {
              // from the singend in user
            }
            final mesasgeWidget = MessageForm(
              sender: messageSender,
              text: messageText,
              currentUser: currentUser == messageSender,
            );
            messageWidgets.add(mesasgeWidget);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageWidgets,
            ),
          );
        });
  }
}
