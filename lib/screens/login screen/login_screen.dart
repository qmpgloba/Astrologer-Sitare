import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/functions/firebase_auth_methods.dart';
import 'package:sitare_astrologer_partner/screens/profile%20screen/profile_screen.dart';
import 'package:sitare_astrologer_partner/screens/signup%20screen/signup_screen.dart';
import 'package:sitare_astrologer_partner/widgets/alertbox.dart';

import 'widgets/custom_login_textfeild.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.all(size.width / 16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Login',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  const Text('Welcome back!'),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    size: size,
                    controller: emailTextController,
                    hintname: 'Email',
                    feildName: 'Email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    size: size,
                    controller: passwordTextController,
                    hintname: 'Password',
                    feildName: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        var result = await loginWithEmail(
                            email: emailTextController.text,
                            password: passwordTextController.text);
                        if (result == null) {
                          //Navigate the screen
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const ProfileScreen(),
                              ),
                              (route) => false);
                          // print('done');
                        } else {
                          // showToast(signUpSuccess, redColor);
                          // showSnackbar(context, signUpSuccess, redColor);
                          // ignore: use_build_context_synchronously
                          showAlertBox(context, result, whiteColor, 'Retry');
                        }
                      }
                    },
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: blackColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 12),
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
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                            color: FONT_COLOR,
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: blackColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
