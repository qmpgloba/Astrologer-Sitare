import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/screens/enter%20details%20screen/widgets/textfeild_widget.dart';

class DetailsPageTwoPartOneWidget extends StatelessWidget {
  const DetailsPageTwoPartOneWidget({
    super.key,
    required TextEditingController adressTextController,
    required TextEditingController descriptionTextController,
    required TextEditingController experienceTextController,
    required TextEditingController contributionHoursTextController,
    required TextEditingController heardAboutSitareTextController,
  })  : _adressTextController = adressTextController,
        _descriptionTextController = descriptionTextController,
        _experienceTextController = experienceTextController,
        _contributionHoursTextController = contributionHoursTextController,
        _heardAboutSitareTextController = heardAboutSitareTextController;

  final TextEditingController _adressTextController;
  final TextEditingController _descriptionTextController;
  final TextEditingController _experienceTextController;
  final TextEditingController _contributionHoursTextController;
  final TextEditingController _heardAboutSitareTextController;

  @override
  Widget build(BuildContext context) {
    return Column(
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
      ],
    );
  }
}
