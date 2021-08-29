import 'package:cloud_firestore/cloud_firestore.dart';
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

  final storeMessage = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  TextEditingController msg = TextEditingController();

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Group Chat", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),),
          Container(
            height: 500,
            color: Colors.white,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                reverse: true,
                  child: ShowMessages())),
          Row(
            children: [
              Expanded(child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xff327fa8),
                      width: 0.7,
                    )
                  )
                ),
                alignment: Alignment.bottomCenter,
                child: TextField(
                  controller: msg,
                  decoration: InputDecoration(
                      hintText: "Enter message"
                  ),
                ),
              )),
              IconButton(onPressed: (){
                if(msg.text.isNotEmpty){
                  storeMessage.collection("messages").doc().set({
                    "messages": msg.text.trim(),
                    "user": loginUser!.email.toString(),
                    "time": DateTime.now(),
                  }
                  );
                  msg.clear();
                }
              },
                  icon: Icon(Icons.send), color: Color(0xff327fa8),)
            ],
          ),

        ],
      ),
    );
  }
}

class ShowMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("messages").orderBy("time").snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            primary: true,
            physics: ScrollPhysics(),
            itemBuilder: (context, index){
          QueryDocumentSnapshot x = snapshot.data!.docs[index];
          return ListTile(
            title: Column(
              crossAxisAlignment: loginUser!.email== x['user']
                  ?CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,
                  vertical: 10),
                  color:loginUser!.email==x['user']?Colors.blue.withOpacity(0.3):
                  Colors.amber.withOpacity(0.4),
                    child: Column(
                      children: [
                        Text(x['messages'],),
                        SizedBox(height: 8,),
                        Text(
                          "User: " + x['user'],
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.green
                        ),)
                      ],
                    )
                )
              ],
            )
          );
        });
      },
    );
  }
}

