import 'package:chat_app/firebaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register.dart';
import 'package:chat_app/register.dart';
class LoginPage extends StatelessWidget {
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
              Text("Login Page",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),),
              SizedBox(height: 10,),
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
                  service.loginUser(context, emailController.text, passwordController.text);
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
                    "Login",
                  )),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Registration())
                );
              },
                  child: Text(
                      "Do you have an account?"
                  )),
            ],
          ),
        ),
      ),
    );
  }
}