import 'package:check_location/demo.dart';
import 'package:check_location/sendlocation.dart';
import 'package:check_location/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  //const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  TextEditingController signin_email = TextEditingController();
  TextEditingController signin_pass = TextEditingController();

  signinUser() async{
    FirebaseUser sign_user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: signin_email.text, password: signin_pass.text);

    if(sign_user != null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SendLocation(recive_user: signin_email.text,)));
    }else{
      print("Sign In Faild");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: signin_email,
                decoration: InputDecoration(
                    labelText: "Email"
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: signin_pass,
                decoration: InputDecoration(
                    labelText: "Password"
                ),
                obscureText: true,
              ),
              FlatButton(
                onPressed: (){
                  signinUser();
                  print("tap sign in");
                },
                child: Text("Sign In"),
                color: Colors.blue,
              ),
              GestureDetector(
                child: Text("Or Sign up"),
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
