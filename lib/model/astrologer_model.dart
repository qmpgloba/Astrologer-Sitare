import 'dart:io';

import 'package:file_picker/file_picker.dart';

class AstrologerModel {
  final String fullName;
  final String emailAddress;
  final String phoneNumber;
  final String officeAddress;
  final String description;
  final int years;
   PlatformFile? portfolio;

  AstrologerModel(
      {required this.fullName,
      required this.emailAddress,
      required this.phoneNumber,
      required this.officeAddress,
      required this.description,
      required this.years,
       this.portfolio});

  toJson() {
    return {
      "name": fullName,
      "email": emailAddress,
      "phone number": phoneNumber,
      "office address": officeAddress,
      "personal description": description,
      "experience(in years)": years,
      "portfolio": portfolio,
    };
  }
}
