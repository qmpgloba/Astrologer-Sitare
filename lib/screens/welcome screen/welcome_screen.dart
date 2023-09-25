import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/screens/login%20screen/login_screen.dart';
import 'package:sitare_astrologer_partner/screens/signup%20screen/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
          child: Center(
            child: Padding(
              padding:  EdgeInsets.all(size.width/16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text('Hello There!',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      // SizedBox(height: size.width*.5,),
              Image.asset('assets/images/welcome.png',width: size.width*.5,),
              const SizedBox(height: 15,),
              GestureDetector(
                  onTap: ()  {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
                  },
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: blackColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                      child: Center(
                        child: Text(
                          'Login',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 18,
                              color: whiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: ()  {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen(),));
                  },
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                      child: Center(
                        child: Text(
                          'Sign Up',
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 18,
                              color: whiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                    ],
                  ),
            ),
          )),
    );
  }
}
