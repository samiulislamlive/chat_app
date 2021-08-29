import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/firebaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Service service = Service();

  final auth = FirebaseAuth.instance;

  getCurrentUser(){
    final user = auth.currentUser;
    if(user!=null)
      {
        loginUser = user;
      }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff327fa8),
        actions: [
          IconButton(onPressed: () async{
            service.signOut(context);
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.remove("email");
          },
              icon: Icon(Icons.logout))
        ],
        title: Text(loginUser!.email.toString()),
      ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}
