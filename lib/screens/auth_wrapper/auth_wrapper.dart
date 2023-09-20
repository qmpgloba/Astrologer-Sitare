

import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/functions/firebase_auth_methods.dart';
import 'package:sitare_astrologer_partner/screens/login%20screen/login_screen.dart';
import 'package:sitare_astrologer_partner/screens/profile%20screen/profile_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // final firebaseUser = context.watch<User?>();
    if (currentUser != null) {
      return const ProfileScreen();
    } else {
      return LoginScreen();
    }
  }
}
