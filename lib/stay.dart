
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser(){
    return auth.currentUser();
  }
}