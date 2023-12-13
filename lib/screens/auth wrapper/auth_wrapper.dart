import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/functions/firebase_auth_methods.dart';
import 'package:sitare_astrologer_partner/screens/home%20screen/home_screen.dart';
import 'package:sitare_astrologer_partner/screens/welcome%20screen/welcome_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // final firebaseUser = context.watch<User?>();

    if(currentUser != null){
      return  const HomeScreen();
    }else{
      return   const WelcomeScreen();
    }
  }
}