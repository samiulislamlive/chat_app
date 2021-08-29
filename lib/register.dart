import 'package:chat_app/firebaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class Registration extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Service service = Service();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff327fa8),
        title: Center(
          child: Text(
            "Flutter Group Chat",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Registration Page",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: "Enter your Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "Enter your Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: "Enter Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                ),
              ),
              ElevatedButton(onPressed: () async{
                SharedPreferences pref = await SharedPreferences.getInstance();
                if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
                  service.createUser(context, emailController.text, passwordController.text);
                  
                  pref.setString("email", emailController.text);
                }
                else
                  {
                    service.errorBox(context, "Please enter email and password");
                  }
              },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.only(left: 70, right: 70),
                  ),
                  child: Text(
                    "Register",
                  )),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage())
                );
              },
                  child: Text(
                      "Already have an account?"
                  )),
            ],
          ),
        ),
      ),
    );
  }
}