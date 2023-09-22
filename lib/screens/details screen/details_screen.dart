import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiselect/multiselect.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';

import '../enter details screen/widgets/textfeild_widget.dart';
import 'widgets/details_page_one_widget.dart';

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

  String? genderDropDownValue;
  String? martialDropDownValue;
  String? workingStatus;

  List<String> languagesList = [
    'English',
    "Hindi",
    "Malayalam",
    "Kannada",
    "Tamil",
  ];
  List<String> selectedLanguages = [];

  List<String> skillsList = [
    'Vedic',
    "Nadi",
    "Numerology",
    "Vastu",
    "Prashana",
    'KP',
    "Lal Kitab",
    "Western",
    "Tarot",
    "Palmistry",
    'Horary',
    "Face Reading",
    "Psychic",
    "Life Coach",
    "Cartomancy",
    'Loshu Grid',
    "Psychologist",
  ];
  List<String> selectedSkillsList = [];
  String selectedOption = 'No';

  var working = [
    'Yes, I am Working somewhere already as a full-timer',
    'No, I am not working anywhere else',
    'No, I am working as a part-timer or freelancer',
    'I own a business'
  ];
  var genders = [
    'Male',
    'Female',
    'Other',
  ];

  var martialStatus = [
    'Single',
    'Married',
    'Divorced',
  ];

  int currentStep = 0;
  continueStep() {
    if (currentStep < 2) {
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

  Widget controlsBuilder(context, details) {
    return currentStep < 2
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
                    backgroundColor: MaterialStatePropertyAll(PRIMARY_COLOR)),
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
                    backgroundColor: MaterialStatePropertyAll(PRIMARY_COLOR)),
                onPressed: details.onStepContinue,
                child: const Text(
                  'Save',
                  style: TextStyle(color: whiteColor),
                ),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: const Text('Details'),
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
            elevation: 0,
            steps: [
              Step(
                isActive: currentStep >= 0,
                state:
                    currentStep > 0 ? StepState.complete : StepState.disabled,
                title: const Text('0'),
                content: DetailsPageOneWidget(
                    nameTextController: _nameTextController,
                    emailTextController: _emailTextController,
                    phoneNumberTextController: _phoneNumberTextController),
              ),
              Step(
                  isActive: currentStep >= 1,
                  state:
                      currentStep > 1 ? StepState.complete : StepState.disabled,
                  title: const Text('1'),
                  content: Column(
                    children: [
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Gender',
                            style: const TextStyle(
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
                              // setState(() {
                              //   // dropDownValue = value!;
                              //   // category = value;
                              // });
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
                            style: const TextStyle(
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
                            style: const TextStyle(
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
                            style: const TextStyle(
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
                              print("${selectedLanguages}");
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
                            style: const TextStyle(
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
                              print("${selectedSkillsList}");
                              setState(() {});
                            },
                            // whenEmpty: 'Select Languages',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFeildWidgets(
                          controller: _contributionHoursTextController,
                          hintText: 'hours',
                          fieldName: 'How many hours you can contribute daily?',
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          readOnly: false),
                      TextFeildWidgets(
                          controller: _heardAboutSitareTextController,
                          hintText: 'Youtube,facebook..',
                          fieldName: 'Where did you hear about Sitare?',
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          readOnly: false),
                      Column(
                        children: [
                          const Text(
                              'Are you working on any other online platform?'),
                          Row(
                            children: [
                              Radio(
                                value: 'No',
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = value!;
                                  });
                                },
                              ),
                              const Text('No'),
                              const SizedBox(
                                width: 20,
                              ),
                              Radio(
                                value: 'Yes',
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = value!;
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
                isActive: currentStep >= 2,
                state:
                    currentStep > 2 ? StepState.complete : StepState.disabled,
                title: const Text('2'),
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
                          'Are you currently working a fulltune job?',
                          style:  TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        DropdownButtonFormField(
                          hint: const AutoSizeText(
                            'Please let us know from the below options',
                            maxLines: 1,
                            maxFontSize: 16,
                            style: TextStyle(fontSize: 14),
                          ),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                          
                          items: working
                              .map(
                                (String items) => DropdownMenuItem(
                                  value: items,
                                  child: AutoSizeText(
                            items,
                            maxLines: 2,
                            maxFontSize: 12,
                            minFontSize: 8,
                            style: TextStyle(fontSize: 12),
                          ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            workingStatus = value;
                          },
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
