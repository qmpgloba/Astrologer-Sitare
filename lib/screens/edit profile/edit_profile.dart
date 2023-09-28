import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/functions/add_astrologer_function.dart';
import 'package:sitare_astrologer_partner/screens/profile%20screen/profile_screen.dart';

import '../details screen/widgets/textfeild_widget.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EnterDetailsScreenState();
}

class _EnterDetailsScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   PlatformFile? _selectedFile;
  late String portfolioURL;
   String? currentFileName;

  late final TextEditingController _nameTextController;

  late final TextEditingController _emailTextController;

  late final TextEditingController _adressTextController;

  late final TextEditingController _phoneNumberTextController;

  late final TextEditingController _experienceTextController;

  late final TextEditingController _descriptionTextController;
      @override
  void initState() {
   
    super.initState();
    _nameTextController = TextEditingController(text: userData!['name']);
    _emailTextController = TextEditingController(text: userData!['email']);
    _adressTextController = TextEditingController(text: userData!['office address']);
    _phoneNumberTextController = TextEditingController(text: userData!['phone number']);
    _experienceTextController = TextEditingController(text: userData!['experience(in years)'].toString());
    _descriptionTextController = TextEditingController(text: userData!['personal description']);


currentFileName= getFileNameFromUrl(userData!['portfolio']);
  }

  // String? fileName;
 

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'docx']);

    if (result != null) {
      setState(() {
        // Store the selected file in the variable
        // fileName = file.path;
        _selectedFile = result.files.single;
      });
    } else {
      // User canceled the file picking operation.
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        title: const Text('Edit Information',style: TextStyle(color: whiteColor),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width / 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                const Text(
                  'Portfolio',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextButton.icon(
                      onPressed: () {
                        _pickFile();
                      },
                      icon: const Icon(Icons.attach_file),
                      label: _selectedFile == null
                          ?  Text(currentFileName??'Attach file')
                          : Text(_selectedFile!.name)),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    // if (_formKey.currentState!.validate()) {
                    //   portfolioURL = await uploadFile(_selectedFile)?? portfolioURL;
                    //   // AstrologerModel astrologer = AstrologerModel(fullName: _nameTextController.text, emailAddress: _emailTextController.text, phoneNumber: _phoneNumberTextController.text, profilePic: profilePic, officeAddress: officeAddress, description: description, experienceYears: experienceYears, contributeHours: contributeHours, heardAboutSitare: heardAboutSitare, gender: gender, martialStatus: martialStatus, dateOfBirth: dateOfBirth, languages: languages, skills: skills, workingOnlinePLatform: workingOnlinePLatform, instagramLink: instagramLink, linkedInLink: linkedInLink, websiteLink: websiteLink, facebookLink: facebookLink, youtubeLink: youtubeLink, business: business, anyoneReferSitare: anyoneReferSitare, onBorad: onBorad, qualification: qualification, earningExpectation: earningExpectation, learnAboutAstrology: learnAboutAstrology, foreignCountries: foreignCountries, biggestChallenge: biggestChallenge, currentWorkingStatus: currentWorkingStatus)
                    //   await updateAstrologerInformation(astrologer,documentID!);
                    //   Navigator.of(context).pushAndRemoveUntil(
                    //       MaterialPageRoute(
                    //         builder: (context) => const ProfileScreen(),
                    //       ),
                    //       (route) => false);
                    // }
                  },
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: blackColor,
                        borderRadius: BorderRadius.circular(3)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: Center(
                        child: Text(
                          'REGISTER',
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
        ),
      ),
    );
  }
}
