import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';

import '../enter details screen/widgets/textfeild_widget.dart';

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
    if(value<currentStep){
      setState(() {
      currentStep = value;
    });
    }
  }

  Widget controlsBuilder(context, details) {
    return currentStep <2 ?  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: currentStep>0,
          child: ElevatedButton(
            style:
                const ButtonStyle(backgroundColor: MaterialStatePropertyAll(greyColor)),
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
    ):Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style:
              const ButtonStyle(backgroundColor: MaterialStatePropertyAll(greyColor)),
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
                isActive: currentStep>=0,
                state: currentStep >0? StepState.complete:StepState.disabled,
                title: const Text('0'),
                content:Column(
                  children: [TextFeildWidgets(
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
                    readOnly: false),],
                ),
              ),
              Step(
                 isActive: currentStep>=1,
                 state: currentStep >1? StepState.complete:StepState.disabled,
                title: const Text('1'),
                content:Column(children: [
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
                ],)
              ),
              Step(
                 isActive: currentStep>=2,
                 state: currentStep >2? StepState.complete:StepState.disabled,
                title: const Text('2'),
                content: const Text('data'),
              ),
            ]),
      ),
    );
  }
}
