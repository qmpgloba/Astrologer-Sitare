import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/screens/details%20screen/widgets/textfeild_widget.dart';

class DetailsPageThreeWidget extends StatelessWidget {
  const DetailsPageThreeWidget({
    super.key,
    required this.instagramProfileLinkController,
    required this.linkedInProfileLinkController,
    required this.websiteProfileLinkController,
    required this.earningExpectationController,
    required this.learnAstrologyContoller,
    required this.facebookProfileLinkController,
    required this.youtubeProfileLinkController,
  });
  final TextEditingController instagramProfileLinkController;
  final TextEditingController linkedInProfileLinkController;
  final TextEditingController websiteProfileLinkController;
  final TextEditingController earningExpectationController;
  final TextEditingController learnAstrologyContoller;
  final TextEditingController facebookProfileLinkController;
  final TextEditingController youtubeProfileLinkController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFeildWidgets(
            controller: instagramProfileLinkController,
            hintText: "Please let us know your Instagram profile",
            fieldName: "Instagram profile link",
            keyboardType: TextInputType.text,
            maxLines: 1,
            readOnly: false),
        TextFeildWidgets(
            controller: linkedInProfileLinkController,
            hintText: "Please let us know your LinkedIn profile",
            fieldName: "LinkedIn profile link",
            keyboardType: TextInputType.text,
            maxLines: 1,
            readOnly: false),
        TextFeildWidgets(
            controller: websiteProfileLinkController,
            hintText: "Enter your website profile",
            fieldName: "Website profile link",
            keyboardType: TextInputType.text,
            maxLines: 1,
            readOnly: false),
        TextFeildWidgets(
            controller: earningExpectationController,
            hintText: "Minimum monthly earning expectation",
            fieldName: "Minimum Earning Expectation from Sitare",
            keyboardType: TextInputType.text,
            maxLines: 1,
            readOnly: false),
        TextFeildWidgets(
            controller: learnAstrologyContoller,
            hintText: "Where did you learn Astrology?",
            fieldName: "From where did you learn Astrology?",
            keyboardType: TextInputType.text,
            maxLines: 1,
            readOnly: false),
        TextFeildWidgets(
            controller: facebookProfileLinkController,
            hintText: "Please let us know your Facebook profile",
            fieldName: "Facebook profile link",
            keyboardType: TextInputType.text,
            maxLines: 1,
            readOnly: false),
        TextFeildWidgets(
            controller: youtubeProfileLinkController,
            hintText: "Please let us know your Youtube channel",
            fieldName: "Youtube profile link",
            keyboardType: TextInputType.text,
            maxLines: 1,
            readOnly: false),
      ],
    );
  }
}
