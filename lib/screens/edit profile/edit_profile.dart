import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:sitare_astrologer_partner/functions/user%20profile/get_user_profile.dart';
import 'package:sitare_astrologer_partner/screens/edit%20profile/widgets/others_tab_widget.dart';
import 'package:sitare_astrologer_partner/screens/edit%20profile/widgets/skills_tab_widget.dart';

import '../../constants/app_constants.dart';
import '../../constants/ui_constants.dart';
import '../../model/astrologer_model.dart';
import '../details screen/widgets/textfeild_widget.dart';
import '../profile screen/profile_screen.dart';
import 'widgets/profile_tab_widget.dart';
import 'widgets/update_button_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameTextController = TextEditingController();

  TextEditingController _emailTextController = TextEditingController();

  TextEditingController _addressTextController = TextEditingController();

  TextEditingController _phoneNumberTextController = TextEditingController();

  TextEditingController _experienceTextController = TextEditingController();

  TextEditingController _descriptionTextController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController _contributionHoursTextController =
      TextEditingController();
  TextEditingController _heardAboutSitareTextController =
      TextEditingController();
  TextEditingController _travelledCountriesTextController =
      TextEditingController();
  TextEditingController _challengesFacedTextController =
      TextEditingController();
  TextEditingController instagramProfileLinkController =
      TextEditingController();
  TextEditingController linkedInProfileLinkController = TextEditingController();
  TextEditingController websiteProfileLinkController = TextEditingController();
  TextEditingController earningExpectationController = TextEditingController();
  TextEditingController learnAstrologyContoller = TextEditingController();
  TextEditingController facebookProfileLinkController = TextEditingController();
  TextEditingController youtubeProfileLinkController = TextEditingController();
  TextEditingController onboardTextController = TextEditingController();
  String? imagePath;
  String? imageUrl;
  String? genderDropDownValue;
  String? martialDropDownValue;
  String? workingStatus;
  String? qualificationValue;
  String? businessValue;
  int? referSitare = 1;
  String workingAnyOnlinePlatform = 'No';
  List<String> languagesDropdown = [];
  List<String> skillsDropdown = [];
  @override
  void initState() {
    super.initState();
    // Initialize the TabController with 4 tabs
    _tabController = TabController(length: 4, vsync: this);
    controllersIntialization();
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the TabController when done
    super.dispose();
  }

  Future<void> imagePick() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        imagePath = imagePicked.path;
      });

      imageUrl = await addProfileImge(imagePicked);
    }
  }

  Future<String> addProfileImge(XFile imagePicked) async {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(imagePicked.path));
      String imageUrl = await referenceImageToUpload.getDownloadURL();
      return imageUrl;
    } catch (e) {
      return profileImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Profile'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: Icon(Icons.person),
                text: 'Personal',
              ),
              Tab(
                icon: Icon(Icons.tab),
                text: 'Skills',
              ),
              Tab(
                icon: Icon(Icons.more),
                text: 'Others',
              ),
              Tab(
                icon: Icon(Icons.book),
                text: 'Assignment',
              ),
            ],
          ),
        ),
        body: FutureBuilder<DocumentSnapshot?>(
            future: getUserDataByNumber(
                FirebaseAuth.instance.currentUser!.phoneNumber!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData && snapshot.data != null) {
                userData = snapshot.data!.data() as Map<String, dynamic>;
                documentID = snapshot.data!.id;
                return Padding(
                  padding: EdgeInsets.all(size.width / 16),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ProfileTabWidget(
                                nameTextController: _nameTextController,
                                emailTextController: _emailTextController,
                                phoneNumberTextController:
                                    _phoneNumberTextController),
                            UpdateButtonWidget(
                              onTap: () async {
                                print("TAB 1");

                                AstrologerModel astrologer = AstrologerModel(
                                    fullName: _nameTextController.text.trim(),
                                    emailAddress:
                                        _emailTextController.text.trim(),
                                    phoneNumber: "+91" +
                                        _phoneNumberTextController.text.trim(),
                                    profilePic: imageUrl ??= profileImage,
                                    officeAddress:
                                        _addressTextController.text.trim(),
                                    description:
                                        _descriptionTextController.text.trim(),
                                    experienceYears: int.parse(
                                        _experienceTextController.text.trim()),
                                    contributeHours: int.parse(
                                        _contributionHoursTextController.text
                                            .trim()),
                                    heardAboutSitare:
                                        _heardAboutSitareTextController.text,
                                    gender: genderDropDownValue!,
                                    martialStatus: martialDropDownValue!,
                                    dateOfBirth: dateInput.text.trim(),
                                    languages: selectedLanguages,
                                    skills: selectedSkillsList,
                                    workingOnlinePLatform:
                                        workingAnyOnlinePlatform,
                                    instagramLink:
                                        instagramProfileLinkController.text
                                            .trim(),
                                    linkedInLink: linkedInProfileLinkController
                                        .text
                                        .trim(),
                                    websiteLink: websiteProfileLinkController
                                        .text
                                        .trim(),
                                    facebookLink: facebookProfileLinkController
                                        .text
                                        .trim(),
                                    youtubeLink:
                                        youtubeProfileLinkController.text.trim(),
                                    business: businessValue!,
                                    anyoneReferSitare: anyoneRefer,
                                    onBorad: onboardTextController.text.trim(),
                                    qualification: qualificationValue!,
                                    earningExpectation: earningExpectationController.text.trim(),
                                    learnAboutAstrology: learnAstrologyContoller.text.trim(),
                                    foreignCountries: int.parse(_travelledCountriesTextController.text),
                                    biggestChallenge: _challengesFacedTextController.text.trim(),
                                    currentWorkingStatus: workingStatus!);
                                await updateProfile(
                                    astrologer, _emailTextController.text);
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileScreen(),
                                    ),
                                    (route) => false);
                                // } else {
                                //   showAlertBox(
                                //       context,
                                //       'Please fill all the feilds',
                                //       whiteColor,
                                //       'close');
                                // }
                              },
                            ),
                          ],
                        ),
                      ),

                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 55,
                                  backgroundImage: imagePath == null
                                      ? NetworkImage(imageUrl!) as ImageProvider
                                      : FileImage(File(imagePath!)),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: InkWell(
                                      onTap: () {
                                        imagePick();
                                      },
                                      child: const Icon(
                                        Icons.add_a_photo,
                                        size: 30,
                                      ),
                                    ))
                              ],
                            ),
                            SkillTabWidget(
                                adressTextController: _addressTextController,
                                descriptionTextController:
                                    _descriptionTextController,
                                experienceTextController:
                                    _experienceTextController,
                                contributionHoursTextController:
                                    _contributionHoursTextController,
                                heardAboutSitareTextController:
                                    _heardAboutSitareTextController),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Gender',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                DropdownButtonFormField(
                                  value: genderDropDownValue,
                                  hint: const Text(
                                    'Gender',
                                  ),
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  // value: 'Male',
                                  items: genders
                                      .map(
                                        (String items) => DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    genderDropDownValue = value;
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Martial Status',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                DropdownButtonFormField(
                                  value: martialDropDownValue,
                                  hint: const AutoSizeText(
                                    'Martial status',
                                    maxLines: 1,
                                    maxFontSize: 18,
                                  ),
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  // value: 'Male',
                                  items: martialStatus
                                      .map(
                                        (String items) => DropdownMenuItem(
                                          value: items,
                                          child: Text(items),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    martialDropDownValue = value;
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Date of Birth',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                TextFormField(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'dd-MM-yyyy',
                                      hintStyle: TextStyle(color: greyColor)),
                                  controller: dateInput,
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2100));

                                    if (pickedDate != null) {
                                      //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickedDate);
                                      //formatted date output using intl package =>  2021-03-16

                                      dateInput.text =
                                          formattedDate; //set output date to TextField value.
                                    } else {}
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Languages Known',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                DropDownMultiSelect(
                                  hint: const AutoSizeText(
                                    'Select Languages',
                                    maxLines: 1,
                                    maxFontSize: 18,
                                  ),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  options: languagesList,
                                  selectedValues: languagesDropdown,
                                  onChanged: (List<String> value) {
                                    //   value = selectedCheckBoxValue;
                                    // setState(() {});
                                  },
                                  // whenEmpty: 'Select Languages',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Skills',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                DropDownMultiSelect(
                                  hint: const AutoSizeText(
                                    'Select Skills',
                                    maxLines: 1,
                                    maxFontSize: 18,
                                  ),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  options: skillsList,
                                  selectedValues: skillsDropdown,
                                  onChanged: (List<String> value) {},
                                  // whenEmpty: 'Select Languages',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Are you working on any other online platform?',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 'No',
                                      groupValue: workingAnyOnlinePlatform,
                                      onChanged: (value) {
                                        setState(() {
                                          workingAnyOnlinePlatform = value!;
                                        });
                                      },
                                    ),
                                    const Text('No'),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Radio(
                                      value: 'Yes',
                                      groupValue: workingAnyOnlinePlatform,
                                      onChanged: (value) {
                                        setState(() {
                                          workingAnyOnlinePlatform = value!;
                                        });
                                      },
                                    ),
                                    const Text('Yes'),
                                  ],
                                ),
                              ],
                            ),
                            UpdateButtonWidget(
                              onTap: () {
                                print("TAB 2");
                              },
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFeildWidgets(
                                controller: onboardTextController,
                                hintText: "Why we should onboard you?",
                                fieldName:
                                    "Why do you think we should onboard you?",
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                readOnly: false),
                            const Text(
                              "Select your highest qualification",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              dropdownColor: Colors.white,
                              value: qualificationValue,
                              onChanged: (newValue) {
                                setState(() {
                                  qualificationValue = newValue;
                                });
                              },
                              items: qualification
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                hintText: 'Select your qualification',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 25),
                            OthersTabWidget(
                              instagramProfileLinkController:
                                  instagramProfileLinkController,
                              earningExpectationController:
                                  earningExpectationController,
                              facebookProfileLinkController:
                                  facebookProfileLinkController,
                              learnAstrologyContoller: learnAstrologyContoller,
                              linkedInProfileLinkController:
                                  linkedInProfileLinkController,
                              websiteProfileLinkController:
                                  websiteProfileLinkController,
                              youtubeProfileLinkController:
                                  youtubeProfileLinkController,
                            ),
                            const Text(
                              "Main source of business(other than astrology)?",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              dropdownColor: Colors.white,
                              value: businessValue,
                              onChanged: (newValue) {
                                setState(() {
                                  businessValue = newValue;
                                });
                              },
                              items: business.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                hintText: 'Select your business',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 25),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Did anybody refer you to Sitare?',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 'No',
                                      groupValue: anyoneRefer,
                                      onChanged: (value) {
                                        setState(() {
                                          anyoneRefer = value!;
                                        });
                                      },
                                    ),
                                    const Text('No'),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Radio(
                                      value: 'Yes',
                                      groupValue: anyoneRefer,
                                      onChanged: (value) {
                                        setState(() {
                                          anyoneRefer = value!;
                                        });
                                      },
                                    ),
                                    const Text('Yes'),
                                  ],
                                ),
                              ],
                            ),
                            UpdateButtonWidget(
                              onTap: () {
                                print("TAB 3");
                              },
                            ),
                          ],
                        ),
                      ),

                      SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFeildWidgets(
                                controller: _travelledCountriesTextController,
                                hintText: '0',
                                fieldName:
                                    'Number of the foreign countries you lived/travelled to?',
                                keyboardType: TextInputType.number,
                                maxLines: 1,
                                readOnly: false),
                            TextFeildWidgets(
                                controller: _challengesFacedTextController,
                                hintText:
                                    'Write a challenge you faced in breif',
                                fieldName:
                                    'What was the biggest challenge you faced and how did you overcome it?',
                                keyboardType: TextInputType.text,
                                maxLines: 3,
                                readOnly: false),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Are you currently working a fulltime job?',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                DropdownButtonFormField(
                                  value: workingStatus,
                                  isExpanded: true,
                                  hint: const AutoSizeText(
                                    'Please let us know from the below options',
                                    maxLines: 1,
                                    maxFontSize: 16,
                                    // style: TextStyle(fontSize: 1),
                                  ),
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  items: working
                                      .map(
                                        (String items) => DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            items,
                                            softWrap: true,
                                          ),
                                          // child: AutoSizeText(
                                          //   items,
                                          //   maxLines: 2,
                                          //   maxFontSize: 14,
                                          //   minFontSize: 10,
                                          //   style: const TextStyle(fontSize: 12),
                                          // ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    workingStatus = value;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            UpdateButtonWidget(
                              onTap: () {
                                print("TAB 4");
                              },
                            ),
                          ],
                        ),
                      ),
                      // Replace with your content for Tab 4
                    ],
                  ),
                );
              } else {
                return const Text('Please add deatials');
              }
            }));
  }

  controllersIntialization() {
    _nameTextController = TextEditingController(
      text: userData!['name'],
    );
    _emailTextController = TextEditingController(
      text: userData!['email'],
    );
    _addressTextController = TextEditingController(
      text: userData!['office address'],
    );
    _phoneNumberTextController = TextEditingController(
      text: userData!['phone number'],
    );
    _experienceTextController = TextEditingController(
      text: userData!['experience(in years)'].toString(),
    );
    _descriptionTextController = TextEditingController(
      text: userData!['personal description'],
    );
    _contributionHoursTextController = TextEditingController(
      text: userData!["hours of contribution"].toString(),
    );
    _heardAboutSitareTextController = TextEditingController(
      text: userData!['Where did you hear about sitare'],
    );
    _travelledCountriesTextController = TextEditingController(
      text: userData!['Number of foreign countries'].toString(),
    );
    languagesDropdown = List<String>.from(userData!['languages'] ?? []);
    skillsDropdown = List<String>.from(userData!['skills'] ?? []);
    print(languagesDropdown);
    genderDropDownValue = userData!['gender'];
    martialDropDownValue = userData!['martial status'];
    dateInput = TextEditingController(
      text: userData!['date of birth'],
    );
    _challengesFacedTextController = TextEditingController(
      text: userData!['biggest challenge'],
    );
    workingAnyOnlinePlatform =
        userData!['working on any other online platform'];
    instagramProfileLinkController = TextEditingController(
      text: userData!['instagram profile link'],
    );
    linkedInProfileLinkController = TextEditingController(
      text: userData!['linkedin profile link'],
    );
    websiteProfileLinkController = TextEditingController(
      text: userData!['website profile link'],
    );
    earningExpectationController = TextEditingController(
      text: userData!['minimum earning expectation'],
    );
    learnAstrologyContoller = TextEditingController(
      text: userData!['form where did you learn astrology'],
    );
    facebookProfileLinkController = TextEditingController(
      text: userData!['facebook profile link'],
    );
    youtubeProfileLinkController = TextEditingController(
      text: userData!['youtube profile link'],
    );
    onboardTextController = TextEditingController(
      text: userData!['onboard you'],
    );
    businessValue = userData!['main source of business'];
    qualificationValue = userData!['highest qualification'];
    workingStatus = userData!['current working status'];
    anyoneRefer = userData!['did anyone refer sitare'];
    imageUrl = userData!['profile image'];
    print(imageUrl);
  }

  updateProfile(AstrologerModel astrologer, String email) async {
    final db = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot =
          await db.collection('users').where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        print("Entery Check: ${email} ");
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        await documentSnapshot.reference.update(astrologer.toJson());
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
