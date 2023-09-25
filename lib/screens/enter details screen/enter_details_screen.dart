import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/functions/add_astrologer_function.dart';
import 'package:sitare_astrologer_partner/model/astrologer_model.dart';
import 'package:sitare_astrologer_partner/screens/profile%20screen/profile_screen.dart';
import 'widgets/textfeild_widget.dart';

class EnterDetailsScreen extends StatefulWidget {
  EnterDetailsScreen({super.key});

  @override
  State<EnterDetailsScreen> createState() => _EnterDetailsScreenState();
}

class _EnterDetailsScreenState extends State<EnterDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextController = TextEditingController();

  final TextEditingController _emailTextController = TextEditingController();

  final TextEditingController _adressTextController = TextEditingController();

  final TextEditingController _phoneNumberTextController =
      TextEditingController();

  final TextEditingController _experienceTextController =
      TextEditingController();

  final TextEditingController _descriptionTextController =
      TextEditingController();

  // String? fileName;
  PlatformFile? _selectedFile;
  String? portfolioURL;

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
        backgroundColor: PRIMARY_COLOR,
        title: const Text('Astrologer Information'),
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
                          ? const Text('Attach file')
                          : Text(_selectedFile!.name)),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    // if (_formKey.currentState!.validate()) {
                    //   portfolioURL = await uploadFile(_selectedFile);
                    //   AstrologerModel astrologer = AstrologerModel(
                    //     fullName: _nameTextController.text,
                    //     emailAddress: _emailTextController.text,
                    //     phoneNumber: _phoneNumberTextController.text,
                    //     officeAddress: _adressTextController.text,
                    //     description: _descriptionTextController.text,
                    //     years: int.parse(_experienceTextController.text),
                        
                    //   );
                    //   await createAstrologer(astrologer);
                    //   Navigator.of(context).pushAndRemoveUntil(
                    //       MaterialPageRoute(
                    //         builder: (context) => ProfileScreen(),
                    //       ),
                    //       (route) => false);
                    // }
                  },
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: PRIMARY_COLOR,
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
