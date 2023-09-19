import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/functions/firebase_auth_methods.dart';
import 'package:sitare_astrologer_partner/screens/login%20screen/login_screen.dart';
import 'package:sitare_astrologer_partner/screens/login%20screen/widgets/custom_login_textfeild.dart';
import 'package:sitare_astrologer_partner/widgets/alertbox.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();
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
                  Text('Sign Up',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    size: size,
                    controller: emailTextController,
                    hintname: 'Email',
                    feildName: 'Email',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    size: size,
                    controller: passwordTextController,
                    hintname: 'Password',
                    feildName: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    size: size,
                    controller: confirmPasswordTextController,
                    hintname: 'Confirm Password',
                    feildName: 'Confirm Password',
                    password: passwordTextController,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        var result = await signUpWithEmail(
                            email: emailTextController.text.trim(),
                            password: passwordTextController.text.trim());
                        if (result == null) {
                          //Navigate the screen
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
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
                          color: redColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 12),
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
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already heave an account?",
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
                            builder: (context) => LoginScreen(),
                          ));
                        },
                        child: const Text(
                          "Login",
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
