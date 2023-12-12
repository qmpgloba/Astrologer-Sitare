// ignore: must_be_immutable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/functions/firebase_auth_methods.dart';
import 'package:sitare_astrologer_partner/screens/details%20screen/details_screen.dart';
import 'package:sitare_astrologer_partner/screens/home%20screen/home_screen.dart';
import 'package:sitare_astrologer_partner/screens/widgets/alertbox.dart';

// ignore: must_be_immutable
class OTPScreen extends StatelessWidget {
  OTPScreen({super.key, required this.mobileNumber});
  final String mobileNumber;

  OtpFieldController otpController = OtpFieldController();
  String otp = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width / 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('ENTER VERIFICATION CODE'),
              SizedBox(
                height: size.width * .15,
              ),
              OTPTextField(
                length: 6,
                width: size.width,
                fieldWidth: size.width / 8,
                style: const TextStyle(fontSize: 14),
                textFieldAlignment: MainAxisAlignment.spaceEvenly,
                fieldStyle: FieldStyle.underline,
                controller: otpController,
                onCompleted: (pin) async {
                  try {
                    await verifyOTP(pin);
                    bool exist = await checkPhoneNumberExistence(mobileNumber);
                    if (exist) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) =>  HomeScreen(),
                          ),
                          (route) => false);
                    } else {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const DetailsEnterScreen(),
                          ),
                          (route) => false);
                    }
                    // ignore: unused_catch_clause
                  } on FirebaseAuthException catch (e) {
                    // ignore: use_build_context_synchronously
                    showAlertBox(context, 'Invalid OTP', whiteColor, 'Close');
                  }
                },
                otpFieldStyle: OtpFieldStyle(
                  enabledBorderColor: FONT_COLOR,
                  focusBorderColor: Colors.black,
                ),
              ),
              SizedBox(
                height: size.width * .12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Dont receive the OTP? ',
                    style: TextStyle(color: FONT_COLOR),
                  ),
                  GestureDetector(
                    onTap: () {
                      //add function here
                    },
                    child: const Text(
                      'Resend OTP',
                      style: TextStyle(color: redColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ))),
    );
  }
}
