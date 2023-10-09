import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:sitare_astrologer_partner/constants/app_constants.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/functions/add_astrologer_function.dart';
import 'package:sitare_astrologer_partner/model/astrologer_model.dart';
import 'package:sitare_astrologer_partner/screens/home%20screen/home_screen.dart';
import 'package:sitare_astrologer_partner/widgets/alertbox.dart';
import 'widgets/textfeild_widget.dart';
import 'widgets/details_page_one_widget.dart';
import 'widgets/details_page_three_widget.dart';
import 'widgets/details_page_two_part_one_widget.dart';

class DetailsEnterScreen extends StatefulWidget {
  const DetailsEnterScreen({super.key});

  @override
  State<DetailsEnterScreen> createState() => _DetailsEnterScreenState();
}

class _DetailsEnterScreenState extends State<DetailsEnterScreen> {
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
  TextEditingController dateInput = TextEditingController();
  final TextEditingController _contributionHoursTextController =
      TextEditingController();
  final TextEditingController _heardAboutSitareTextController =
      TextEditingController();
  final TextEditingController _travelledCountriesTextController =
      TextEditingController();
  final TextEditingController _challengesFacedTextController =
      TextEditingController();
  final TextEditingController instagramProfileLinkController =
      TextEditingController();
  final TextEditingController linkedInProfileLinkController =
      TextEditingController();
  final TextEditingController websiteProfileLinkController =
      TextEditingController();
  final TextEditingController earningExpectationController =
      TextEditingController();
  final TextEditingController learnAstrologyContoller = TextEditingController();
  final TextEditingController facebookProfileLinkController =
      TextEditingController();
  final TextEditingController youtubeProfileLinkController =
      TextEditingController();
  final TextEditingController onboardTextController = TextEditingController();
  String? imagePath;
  String? imageUrl;
  String? genderDropDownValue;
  String? martialDropDownValue;
  String? workingStatus;
  String? qualificationValue;
  String? businessValue;
  int? referSitare = 1;
  // Function to handle radio button changes.
  void setSelectedRadio(int value) {
    setState(() {
      referSitare = value;
    });
  }

  int currentStep = 0;
  continueStep() {
    if (currentStep < 3) {
      setState(() {
        currentStep = currentStep + 1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }

  onStepTapped(int value) {
    if (value < currentStep) {
      setState(() {
        currentStep = value;
      });
    }
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

  Widget controlsBuilder(context, details) {
    return currentStep < 3
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: currentStep > 0,
                child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(greyColor)),
                  onPressed: details.onStepCancel,
                  child: const Text(
                    'Back',
                    style: TextStyle(color: whiteColor),
                  ),
                ),
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(blackColor)),
                onPressed: details.onStepContinue,
                child: const Text(
                  'Continue',
                  style: TextStyle(color: whiteColor),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(greyColor)),
                onPressed: details.onStepCancel,
                child: const Text(
                  'Back',
                  style: TextStyle(color: whiteColor),
                ),
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(blackColor)),
                onPressed: () async {
                  if (_formKey.currentState!.validate() ||
                      genderDropDownValue != null ||
                      martialDropDownValue != null ||
                      selectedLanguages.isNotEmpty ||
                      selectedSkillsList.isNotEmpty ||
                      businessValue != null ||
                      qualificationValue != null ||
                      workingStatus != null) {
                    AstrologerModel astrologer = AstrologerModel(
                        fullName: _nameTextController.text.trim(),
                        emailAddress: _emailTextController.text.trim(),
                        phoneNumber:
                            "+91${_phoneNumberTextController.text.trim()}",
                        profilePic: imageUrl ??= profileImage,
                        officeAddress: _adressTextController.text.trim(),
                        description: _descriptionTextController.text.trim(),
                        experienceYears:
                            int.parse(_experienceTextController.text.trim()),
                        contributeHours: int.parse(
                            _contributionHoursTextController.text.trim()),
                        heardAboutSitare: _heardAboutSitareTextController.text,
                        gender: genderDropDownValue!,
                        martialStatus: martialDropDownValue!,
                        dateOfBirth: dateInput.text.trim(),
                        languages: selectedLanguages,
                        skills: selectedSkillsList,
                        workingOnlinePLatform: workingAnyOnlinePlatform,
                        instagramLink:
                            instagramProfileLinkController.text.trim(),
                        linkedInLink: linkedInProfileLinkController.text.trim(),
                        websiteLink: websiteProfileLinkController.text.trim(),
                        facebookLink: facebookProfileLinkController.text.trim(),
                        youtubeLink: youtubeProfileLinkController.text.trim(),
                        business: businessValue!,
                        anyoneReferSitare: anyoneRefer,
                        onBorad: onboardTextController.text.trim(),
                        qualification: qualificationValue!,
                        earningExpectation:
                            earningExpectationController.text.trim(),
                        learnAboutAstrology:
                            learnAstrologyContoller.text.trim(),
                        foreignCountries:
                            int.parse(_travelledCountriesTextController.text),
                        biggestChallenge:
                            _challengesFacedTextController.text.trim(),
                        currentWorkingStatus: workingStatus!);
                    await createAstrologer(astrologer);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                        (route) => false);
                  } else {
                    showAlertBox(context, 'Please fill all the feilds',
                        whiteColor, 'close');
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: whiteColor),
                ),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        title: const Text(
          'Details',
          style: TextStyle(color: whiteColor),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
            currentStep: currentStep,
            onStepContinue: continueStep,
            onStepCancel: cancelStep,
            onStepTapped: onStepTapped,
            controlsBuilder: controlsBuilder,
            type: StepperType.horizontal,
            connectorColor: const MaterialStatePropertyAll(blackColor),
            elevation: 0,
            steps: [
              Step(
                label: currentStep == 0
                    ? const AutoSizeText(
                        'Personal Details',
                        maxFontSize: 12,
                        maxLines: 2,
                        minFontSize: 10,
                        style: TextStyle(color: blackColor),
                      )
                    : const Text(''),
                isActive: currentStep >= 0,
                state:
                    currentStep > 0 ? StepState.complete : StepState.disabled,
                title: const SizedBox(),
                content: DetailsPageOneWidget(
                    nameTextController: _nameTextController,
                    emailTextController: _emailTextController,
                    phoneNumberTextController: _phoneNumberTextController),
              ),
              Step(
                  label: currentStep == 1
                      ? const AutoSizeText(
                          'Skill Details',
                          maxFontSize: 12,
                          maxLines: 2,
                          minFontSize: 10,
                          style: TextStyle(color: blackColor),
                        )
                      : const Text(''),
                  isActive: currentStep >= 1,
                  state:
                      currentStep > 1 ? StepState.complete : StepState.disabled,
                  title: const SizedBox(),
                  content: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundImage: imagePath == null
                                ? const AssetImage('assets/images/download.png')
                                    as ImageProvider
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
                      const SizedBox(
                        height: 10,
                      ),
                      DetailsPageTwoPartOneWidget(
                          adressTextController: _adressTextController,
                          descriptionTextController: _descriptionTextController,
                          experienceTextController: _experienceTextController,
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
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          DropdownButtonFormField(
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
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          DropdownButtonFormField(
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
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                                    DateFormat('dd-MM-yyyy').format(pickedDate);
                                //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  dateInput.text =
                                      formattedDate; //set output date to TextField value.
                                });
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
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                            selectedValues: selectedLanguages,
                            onChanged: (List<String> value) {
                              //   value = selectedCheckBoxValue;
                              setState(() {});
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
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                            selectedValues: selectedSkillsList,
                            onChanged: (List<String> value) {
                              //   value = selectedCheckBoxValue;
                              setState(() {});
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
                            'Are you working on any other online platform?',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
                      )
                    ],
                  )),
              Step(
                label: currentStep == 2
                    ? const AutoSizeText(
                        'Other Details',
                        maxFontSize: 12,
                        maxLines: 2,
                        minFontSize: 10,
                        style: TextStyle(color: blackColor),
                      )
                    : const Text(''),
                isActive: currentStep >= 2,
                state:
                    currentStep > 2 ? StepState.complete : StepState.disabled,
                title: const SizedBox(),
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFeildWidgets(
                        controller: onboardTextController,
                        hintText: "Why we should onboard you?",
                        fieldName: "Why do you think we should onboard you?",
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
                          .map<DropdownMenuItem<String>>((String value) {
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
                    DetailsPageThreeWidget(
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
                      items: business
                          .map<DropdownMenuItem<String>>((String value) {
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
                              fontSize: 16, fontWeight: FontWeight.bold),
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
                    )
                  ],
                ),
              ),
              Step(
                label: currentStep == 3
                    ? const AutoSizeText(
                        'Assignment',
                        maxFontSize: 12,
                        maxLines: 2,
                        minFontSize: 10,
                        style: TextStyle(color: blackColor),
                      )
                    : const Text(''),
                isActive: currentStep >= 3,
                state:
                    currentStep > 3 ? StepState.complete : StepState.disabled,
                title: const SizedBox(),
                content: Column(
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
                        hintText: 'Write a challenge you faced in breif',
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
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButtonFormField(
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
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
