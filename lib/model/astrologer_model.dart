class AstrologerModel {
  final String fullName;
  final String emailAddress;
  final String phoneNumber;
  final String profilePic;
  final String officeAddress;
  final String description;
  final int experienceYears;
  final int contributeHours;
  final String heardAboutSitare;
  final String gender;
  final String martialStatus;
  final String dateOfBirth;
  final List languages;
  final List skills;
  final String workingOnlinePLatform;
  final String instagramLink;
  final String linkedInLink;
  final String websiteLink;
  final String facebookLink;
  final String youtubeLink;
  final String business;
  final String anyoneReferSitare;
  final String onBorad;
  final String qualification;
  final String earningExpectation;
  final String learnAboutAstrology;
  final int foreignCountries;
  final String biggestChallenge;
  final String currentWorkingStatus;

  AstrologerModel(
      {required this.fullName,
      required this.emailAddress,
      required this.phoneNumber,
      required this.profilePic,
      required this.officeAddress,
      required this.description,
      required this.experienceYears,
      required this.contributeHours,
      required this.heardAboutSitare,
      required this.gender,
      required this.martialStatus,
      required this.dateOfBirth,
      required this.languages,
      required this.skills,
      required this.workingOnlinePLatform,
      required this.instagramLink,
      required this.linkedInLink,
      required this.websiteLink,
      required this.facebookLink,
      required this.youtubeLink,
      required this.business,
      required this.anyoneReferSitare,
      required this.onBorad,
      required this.qualification,
      required this.earningExpectation,
      required this.learnAboutAstrology,
      required this.foreignCountries,
      required this.biggestChallenge,
      required this.currentWorkingStatus});

  // AstrologerModel(
  //     {required this.fullName,
  //     required this.emailAddress,
  //     required this.phoneNumber,

  //     required this.officeAddress,
  //     required this.description,
  //     required this.years,
  //     });

  toJson() {
    return {
      "name": fullName,
      "email": emailAddress,
      "phone number": phoneNumber,
      "profile image": profilePic,
      "office address": officeAddress,
      "personal description": description,
      "experience(in years)": experienceYears,
      "hours of contribution": contributeHours,
      "Where did you hear about sitare": heardAboutSitare,
      "gender": gender,
      "martial status": martialStatus,
      "date of birth": dateOfBirth,
      "languages": languages,
      "skills": skills,
      "working on any other online platform": workingOnlinePLatform,
      "onboard you": onBorad,
      "highest qualification":qualification,
      "instagram profile link": instagramLink,
      "linkedin profile link": linkedInLink,
      "website profile link": websiteLink,
      "minimum earning expectation": earningExpectation,
      "form where did you learn astrology": learnAboutAstrology,
      "facebook profile link": facebookLink,
      "youtube profile link":  youtubeLink,
      "main source of business": business,
      "did anyone refer sitare": anyoneReferSitare,
      "Number of foreign countries": foreignCountries,
      "biggest challenge": biggestChallenge,
      "current working status": currentWorkingStatus

    };
  }
}
