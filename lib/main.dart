import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/screens/login%20screen/login_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: blackColor,
        // primarySwatch: ,
        colorScheme: ColorScheme.fromSeed(seedColor: blackColor),
        // scaffoldBackgroundColor: PRIMARY_COLOR,
        useMaterial3: true,
      ),
      home:  LoginScreen(),
    );
  }
}
