import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/functions/add_astrologer_function.dart';
import 'package:sitare_astrologer_partner/functions/firebase_auth_methods.dart';
import 'package:sitare_astrologer_partner/functions/user%20profile/get_user_profile.dart';
import 'package:sitare_astrologer_partner/model/astrologer_model.dart';
import 'package:sitare_astrologer_partner/screens/auth%20wrapper/auth_wrapper.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'High Important channel' //id,
        'High Important Notification', //title
    "This channel is used for important notification.", //description
    importance: Importance.high,
    playSound: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    saveNotificationToFirestore(notification, message.data);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await _initFCM();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: blackColor,
        // primarySwatch: ,
        fontFamily: 'Muli',
        colorScheme: ColorScheme.fromSeed(seedColor: blackColor),
        // scaffoldBackgroundColor: PRIMARY_COLOR,
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}

_initFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? fcmKeyToken = await FirebaseMessaging.instance.getToken();
 if(currentUser!=null){
   String currentFcmToken = await fetchFcmToken(currentUser!.uid) as String;
  if (currentFcmToken != fcmKeyToken) {
   Map<String, dynamic>? userData =
      await  getAstroDetailsByUid(currentUser!.uid);
      
    AstrologerModel astrologer = AstrologerModel(
        uid: currentUser!.uid,
        fullName: userData!['name'],
        emailAddress: userData['email'],
        phoneNumber: userData['phone number'],
        profilePic: userData['profile image'],
        officeAddress: userData['office address'],
        description: userData['personal description'],
        experienceYears: userData['experience(in years)'],
        contributeHours: userData['hours of contribution'],
        heardAboutSitare: userData['Where did you hear about sitare'],
        gender: userData['gender'],
        martialStatus: userData['martial status'],
        dateOfBirth: userData['date of birth'],
        languages: userData['languages'],
        skills: userData['skills'],
        workingOnlinePLatform: userData['working on any other online platform'],
        instagramLink: userData['instagram profile link'],
        linkedInLink: userData['linkedin profile link'],
        websiteLink: userData['website profile link'],
        facebookLink: userData['facebook profile link'],
        youtubeLink: userData['youtube profile link'],
        business: userData['main source of business'],
        anyoneReferSitare: userData['did anyone refer sitare'],
        onBorad: userData['onboard you'],
        qualification: userData['highest qualification'],
        earningExpectation: userData['minimum earning expectation'],
        learnAboutAstrology: userData['form where did you learn astrology'],
        foreignCountries: userData['Number of foreign countries'],
        biggestChallenge: userData['biggest challenge'],
        currentWorkingStatus: userData['current working status'],
        fcmToken: fcmKeyToken!);
        await updateAstrologer(astrologer, currentUser!.uid);
 }
        
  }
  // ignore: unused_local_variable
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      // Handle data payload messages
      saveNotificationToFirestore(notification, message.data);
      // Create a custom notification
      flutterLocalNotificationsPlugin.show(
        notification.hashCode, // Unique ID for the notification
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(channel.id, channel.name,
              channelDescription: channel.description,
              color: Colors.white,
              playSound: true,
              icon: "@mipmap/ic_launcher"),
        ),
      );
    }
  });
}

void saveNotificationToFirestore(
    RemoteNotification notification, Map<String, dynamic> data) {
  final firestore = FirebaseFirestore.instance;

  final notificationData = {
    'title': notification.title,
    'body': notification.body,
    'timestamp': DateTime.now(),
    'uid': currentUser!.uid,
    'user_uid': data['uid'],
  };

  firestore
      .collection('Notification')
      .add(notificationData)
      .then((_) {})
      .catchError((error) {});
}
