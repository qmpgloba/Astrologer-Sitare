import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'widgets/textfeild_widget.dart';

class EnterDetailsScreen extends StatelessWidget {
  EnterDetailsScreen({super.key});
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _adressTextController = TextEditingController();
  final TextEditingController _phoneNumberTextController =
      TextEditingController();
  final TextEditingController _experienceTextController =
      TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
  final TextEditingController _fileNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: const Text('Astrologer Information'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width / 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFeildWidgets(
                  controller: _nameTextController,
                  hintText: 'Full Name',
                  fieldName: 'Name',
                  keyboardType: TextInputType.name,
                  maxLines: 1,
                  readOnly: false),
              TextFeildWidgets(
                  controller: _emailTextController,
                  hintText: 'Email',
                  fieldName: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  readOnly: false),
              TextFeildWidgets(
                  controller: _phoneNumberTextController,
                  hintText: 'Phone Number',
                  fieldName: 'Phone Number',
                  keyboardType: TextInputType.phone,
                  maxLines: 1,
                  readOnly: false),
              TextFeildWidgets(
                  controller: _adressTextController,
                  hintText: 'Address',
                  fieldName: 'Office Address',
                  keyboardType: TextInputType.name,
                  maxLines: 3,
                  readOnly: false),
              TextFeildWidgets(
                  controller: _descriptionTextController,
                  hintText: 'Description',
                  fieldName: 'Personal Description',
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  readOnly: false),
              TextFeildWidgets(
                  controller: _experienceTextController,
                  hintText: 'Years',
                  fieldName: 'Experience(in years)',
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  readOnly: false),
              TextFeildWidgets(
                  controller: _fileNameController,
                  hintText: 'Tap here to attach file',
                  fieldName: 'Portfolio',
                  keyboardType: TextInputType.none,
                  maxLines: 1,
                  readOnly: true)
            ],
          ),
        ),
      ),
    );
  }
}
