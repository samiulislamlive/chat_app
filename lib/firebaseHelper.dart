import 'package:chat_app/login.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Service{
  final auth = FirebaseAuth.instance;

  void createUser(context, email, password) async{
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
         Navigator.push(context,
         MaterialPageRoute(builder: (context)=> LoginPage()))
      });
    }catch(e){
      errorBox(context, e);
    }
  }

  void loginUser(context, email, password) async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> ChatScreen()))
      });
    }catch(e){
      errorBox(context, e);
    }
  }

  void signOut(context) async{
    try{
      await auth.signOut();
    }catch(e){
      errorBox(context, e);
    }
  }
  void errorBox(context, e){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(
          "Error",
        ),
        content: Text(e.toString()),
      );
    }
    );
  }
}