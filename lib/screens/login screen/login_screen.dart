import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/functions/firebase_auth_methods.dart';
import 'package:sitare_astrologer_partner/screens/login%20screen/widgets/mobile_number_textfeild_widget.dart';
import 'package:sitare_astrologer_partner/screens/otp%20screen/otp_screen.dart';
import 'package:sitare_astrologer_partner/screens/profile%20screen/profile_screen.dart';
import 'package:sitare_astrologer_partner/widgets/alertbox.dart';

import 'widgets/custom_login_textfeild.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String countyCode = '91';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: EdgeInsets.all(size.width / 14),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              // autovalidateMode: AutovalidateMode.always,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('WELCOME'),
                  SizedBox(
                    height: size.width * .2,
                  ),
                  MobileNumberTextFeildWidget(
                    mobileNumberController: mobileNumberController,
                    onCountryChanged: (country) {
                      countyCode = country.dialCode;
                    },
                  ),
                  SizedBox(
                    height: size.width / 14,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (mobileNumberController.text.isEmpty) {
                          showAlertBox(context, 'Please enter Mobile number',
                              whiteColor, 'Close');
                        } else {
                          if (_formKey.currentState!.validate()) {
                            var phoneNumber =
                                '+$countyCode${mobileNumberController.text}';
                            
                           
                              var result =
                                  await phoneAuthentication(phoneNumber);
                              if (result == null) {
                                // showSnackbar(
                                //     context, 'OTP sent Succesfully', greenColor);
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>  OTPScreen(mobileNumber: mobileNumberController.text),
                                ));
                              } else {
                                // ignore: use_build_context_synchronously
                                showAlertBox(
                                    context, result, whiteColor, 'close');
                              }
                            } else {
                              // ignore: use_build_context_synchronously
                              showAlertBox(
                                  context,
                                  'Enter a valid mobile number',
                                  whiteColor,
                                  'Retry');
                            }
                          
                        }

                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => const OTPScreen(),
                        // ));
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          const RoundedRectangleBorder(),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(blackColor),
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(
                            color: FONT_COLOR, // Border color
                            width: 1.0, // Border width
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: Text(
                          'PROCEED',
                          style: TextStyle(color: FONT_COLOR),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
    // return Scaffold(
    //   backgroundColor: whiteColor,
    //   body: SafeArea(
    //       child: Center(
    //     child: Padding(
    //       padding: EdgeInsets.all(size.width / 16),
    //       child: Form(
    //         key: _formKey,
    //         child: SingleChildScrollView(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               const Text('Login',
    //                   style:
    //                       TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    //               const Text('Welcome back!'),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               CustomTextField(
    //                 size: size,
    //                 controller: emailTextController,
    //                 hintname: 'Email',
    //                 feildName: 'Email',
    //               ),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               CustomTextField(
    //                 size: size,
    //                 controller: passwordTextController,
    //                 hintname: 'Password',
    //                 feildName: 'Password',
    //                 obscureText: true,
    //               ),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               GestureDetector(
    //                 onTap: () async {
    //                   if (_formKey.currentState!.validate()) {
    //                     var result = await loginWithEmail(
    //                         email: emailTextController.text,
    //                         password: passwordTextController.text);
    //                     if (result == null) {
    //                       //Navigate the screen
    //                       // ignore: use_build_context_synchronously
    //                       Navigator.of(context).pushAndRemoveUntil(
    //                           MaterialPageRoute(
    //                             builder: (context) => const ProfileScreen(),
    //                           ),
    //                           (route) => false);
    //                       // print('done');
    //                     } else {
    //                       // showToast(signUpSuccess, redColor);
    //                       // showSnackbar(context, signUpSuccess, redColor);
    //                       // ignore: use_build_context_synchronously
    //                       showAlertBox(context, result, whiteColor, 'Retry');
    //                     }
    //                   }
    //                 },
    //                 child: Container(
    //                   width: double.maxFinite,
    //                   decoration: BoxDecoration(
    //                       color: blackColor,
    //                       borderRadius: BorderRadius.circular(30)),
    //                   child: const Padding(
    //                     padding:
    //                         EdgeInsets.symmetric(horizontal: 5, vertical: 12),
    //                     child: Center(
    //                       child: Text(
    //                         'Login',
    //                         maxLines: 1,
    //                         style: TextStyle(
    //                             fontSize: 18,
    //                             color: whiteColor,
    //                             fontWeight: FontWeight.bold),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 15,
    //               ),
                 
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   )),
    // );
  }
}
