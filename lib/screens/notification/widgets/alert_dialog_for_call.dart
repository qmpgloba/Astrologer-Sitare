
// ignore_for_file: use_build_context_synchronously

  import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/functions/contact%20function/make_call_function.dart';
import 'package:sitare_astrologer_partner/functions/firebase_auth_methods.dart';
import 'package:sitare_astrologer_partner/functions/user%20profile/get_user_profile.dart';

Future<dynamic> alertDialogForCall(BuildContext context, Map<String, dynamic> notification) {
    return showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  backgroundColor: whiteColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20)),
                                  // title:  Text(
                                  //   title,
                                  //   style: const TextStyle(fontSize: 18),
                                  // ),
                                  content: const Text(
                                    'Do you want to call?',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'No',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        )),
                                    TextButton(
                                        onPressed: () async {
                                          String? userMobileNumber =
                                              await fetchUserMobileNumber(
                                                  notification['user_uid']);
                                          // print(notification['user_uid']);
                                          if (userMobileNumber != null) {
                                            // Use the user's mobile number as needed
                                            // print(
                                            //     'User mobile number: $userMobileNumber');
                                            makeCknowlarityCall(
                                                userMobileNumber,
                                                currentUser!.phoneNumber!);
                                           
                                            Navigator.of(context).pop();
                                          } else {
                                            // print('User not found');
                                            // Handle the case when the user is not found
                                          }
                                        
                                        },
                                        child: const Text(
                                          'Yes',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                        ))
                                  ],
                                ));
  }