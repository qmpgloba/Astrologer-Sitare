import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/screens/details%20screen/widgets/custom_textformfeild_widget.dart';

class DetailsPageThreeWidget extends StatelessWidget {
  const DetailsPageThreeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          text: "Instagram profile link",
          hintText: "Please let us know your Instagram profile",
        ),
        CustomTextFormField(
          text: "LinkedIn profile link",
          hintText: "Please let us know your LinkedIn profile",
        ),
        CustomTextFormField(
          text: "Website profile link",
          hintText: "Enter your website profile",
        ),
        CustomTextFormField(
          text: "Minimum Earning Expectation from Sitare",
          hintText: "Minimum monthly earning expectation",
        ),
        CustomTextFormField(
          text: "From where did you learn Astrology?",
          hintText: "Where did you learn Astrology?",
        ),
        CustomTextFormField(
          text: "Facebook profile link",
          hintText: "Please let us know your Facebook profile",
        ),
        CustomTextFormField(
          text: "Youtube profile link",
          hintText: "Please let us know your Youtube channel",
        ),
      ],
    );
  }
}
