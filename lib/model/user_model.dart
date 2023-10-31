class UserModel {
  final String uid;
  final String name;
  final String email;
  final String userProfileImage;
  final String phoneNumber;
  final String? gender;
  final String? dateofBirth;
  final String? placeofBirth;
  final String? timeofBirth;
  final String? maritalStatus;
  final String? problem;
  final List<String?>? partnerDetails;

  UserModel({
    this.gender,
    this.dateofBirth,
    this.placeofBirth,
    this.timeofBirth,
    this.maritalStatus,
    this.problem,
    required this.userProfileImage,
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.partnerDetails,
  });

  toJson() {
    return {
      'uid': uid,
      'full name': name,
      'email': email,
      'phone number': phoneNumber,
      'profile image':userProfileImage,
      'gender': gender,
      'dateofBirth': dateofBirth,
      'placeofBirth': placeofBirth,
      'timeofBirth': timeofBirth,
      'maritalStatus': maritalStatus,
      'problem': problem,
      'PartnerDetails': partnerDetails,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'],
      name: data['full name'],
      email: data['email'],
      phoneNumber: data['phone number'],
      userProfileImage: data['profile image'],
      gender: data['gender'],
      dateofBirth: data['dateofBirth'],
      placeofBirth: data['placeofBirth'],
      timeofBirth: data['timeofBirth'],
      maritalStatus: data['maritalStatus'],
      problem: data['problem'],
      partnerDetails: List<String?>.from(data['PartnerDetails'] ?? []),
    );
  }
}
