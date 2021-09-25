
import 'package:check_location/sendlocation.dart';
import 'package:check_location/signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



class SignupPage extends StatefulWidget {
  //const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  Future createUser() async{
    FirebaseUser _user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.text, password: _password.text);
    if(_user != null){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SendLocation(recive_user: _email.text,)));
    }else{
      print("not create user");
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
                controller: _name,
                decoration: InputDecoration(
                    labelText: "Name"
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: _email,
                decoration: InputDecoration(
                    labelText: "Email"
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _password,
                decoration: InputDecoration(
                    labelText: "Password"
                ),
                obscureText: true,
              ),
              FlatButton(
                onPressed: (){
                  createUser();
                  print("tap sign up");
                },
                child: Text("Sign Up"),
                color: Colors.blue,
              ),
              GestureDetector(
                child: Text("Or Sign in"),
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninPage())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
