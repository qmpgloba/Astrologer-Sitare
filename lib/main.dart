// ignore_for_file: empty_catches

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cron/cron.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sitare_astrologer_partner/constants/ui_constants.dart';
import 'package:sitare_astrologer_partner/functions/add_astrologer_function.dart';
import 'package:sitare_astrologer_partner/functions/available_slots_function/available_function.dart';
import 'package:sitare_astrologer_partner/functions/firebase_auth_methods.dart';
import 'package:sitare_astrologer_partner/functions/user%20profile/get_user_profile.dart';
import 'package:sitare_astrologer_partner/model/astrologer_model.dart';
import 'package:sitare_astrologer_partner/model/availability_slots_model.dart';
import 'package:sitare_astrologer_partner/screens/auth%20wrapper/auth_wrapper.dart';
import 'package:sitare_astrologer_partner/screens/home%20screen/home_screen.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'High Important channel' //id,
        'High Important Notification', //title
    "This channel is used for important notification.", //description
    importance: Importance.high,
    playSound: true);
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
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
  tzdata.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
  await _initFCM();
  scheduleCronJob();
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
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: blackColor,
          titleTextStyle: TextStyle(
            color: whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
          iconTheme: IconThemeData(
            color: whiteColor,
          ),
        ),
        buttonTheme: const ButtonThemeData(buttonColor: blackColor),
      ),
      home: FutureBuilder(
        future: fetchBookedSlotsAndNotify(DateTime.now()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Show a loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            WidgetsBinding.instance.addObserver(AppLifecycleObserver());
            return const AuthWrapper();
          }
        },
      ),
    );
  }
}

_initFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? fcmKeyToken = await FirebaseMessaging.instance.getToken();
  if (currentUser != null) {
    String currentFcmToken = await fetchFcmToken(currentUser!.uid) as String;
    if (currentFcmToken != fcmKeyToken) {
      Map<String, dynamic>? userData =
          await getAstroDetailsByUid(currentUser!.uid);

      AstrologerModel astrologer = AstrologerModel(
        isOnline: userData!['isOnline'],
        uid: currentUser!.uid,
        fullName: userData['name'],
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
        fcmToken: fcmKeyToken!,
        rpm: userData['rpm'],
      );
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
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            color: Colors.white,
            playSound: true,
            icon: "@mipmap/ic_launcher",
          ),
        ),
      );
    }
  });
}

void saveNotificationToFirestore(
    RemoteNotification notification, Map<String, dynamic> data) {
  final firestore = FirebaseFirestore.instance;

  try {
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
  } catch (e) {}
}

Future<void> fetchBookedSlotsAndNotify(DateTime selectedDate) async {
  try {
    List<AvailabilityModel> availableSlots =
        await getAvailableSlotsForDate(currentUser!.uid, selectedDate);

    if (availableSlots.isNotEmpty) {
      DateTime now = tz.TZDateTime.now(tz.local);
      for (var slot in availableSlots) {
        for (var timeString in slot.bookedSlots) {
          List<String> timeComponents = timeString.split(':');
          int hours = int.parse(timeComponents[0]);
          int minutes = int.parse(timeComponents[1]);

          DateTime slotTime = DateTime(selectedDate.year, selectedDate.month,
              selectedDate.day, hours, minutes);

          DateTime notificationTime =
              slotTime.subtract(const Duration(minutes: 13));
          if (now.isAfter(notificationTime) && now.isBefore(slotTime)) {
            Duration difference = slotTime.difference(now);
            int differenceInMinutes = difference.inMinutes;
            await sendNotification(
              'Appointment Reminder',
              'Your appointment is in ${differenceInMinutes + 1} minutes!',
            );
          }
        }
      }
    }
  } catch (e) {}
}

Future<void> sendNotification(String title, String body) async {
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    channel.id,
    channel.name,
    channelDescription: channel.description,
    color: Colors.white,
    playSound: true,
    icon: "@mipmap/ic_launcher",
  );

  NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    title,
    body,
    platformChannelSpecifics,
  );
}

void scheduleCronJob() {
  final cron = Cron();

  const cronExpression = '*/5 * * * *';

  cron.schedule(Schedule.parse(cronExpression), () async {
    await fetchBookedSlotsAndNotify(DateTime.now());
  });
}

class AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      print('paused');
      // App is in the background
      // Check if the toggle is on, and start the 30-minute timer if true
      if (userData!['isOnline']) {
        startTimer();
      }
    } else if (state == AppLifecycleState.resumed) {
      print('resumed');
      // App is resumed
      // Cancel the timer if the app is active
      cancelTimer();
    }
  }
}

void startTimer() {
  const thirtyMinutes = Duration(minutes: 30);
  _timer = Timer(thirtyMinutes, () {
    AstrologerModel astrologer = AstrologerModel(
      isOnline: false,
      uid: currentUser!.uid,
      fullName: userData!['name'],
      emailAddress: userData!['email'],
      phoneNumber: userData!['phone number'],
      profilePic: userData!['profile image'],
      officeAddress: userData!['office address'],
      description: userData!['personal description'],
      experienceYears: userData!['experience(in years)'],
      contributeHours: userData!['hours of contribution'],
      heardAboutSitare: userData!['Where did you hear about sitare'],
      gender: userData!['gender'],
      martialStatus: userData!['martial status'],
      dateOfBirth: userData!['date of birth'],
      languages: userData!['languages'],
      skills: userData!['skills'],
      workingOnlinePLatform: userData!['working on any other online platform'],
      instagramLink: userData!['instagram profile link'],
      linkedInLink: userData!['linkedin profile link'],
      websiteLink: userData!['website profile link'],
      facebookLink: userData!['facebook profile link'],
      youtubeLink: userData!['youtube profile link'],
      business: userData!['main source of business'],
      anyoneReferSitare: userData!['did anyone refer sitare'],
      onBorad: userData!['onboard you'],
      qualification: userData!['highest qualification'],
      earningExpectation: userData!['minimum earning expectation'],
      learnAboutAstrology: userData!['form where did you learn astrology'],
      foreignCountries: userData!['Number of foreign countries'],
      biggestChallenge: userData!['biggest challenge'],
      currentWorkingStatus: userData!['current working status'],
      fcmToken: userData!['fcmToken']!,
      rpm: userData!['rpm'],
    );
    updateAstrologer(astrologer, currentUser!.uid);
    // updateStatus(false); // Set astrologer's status to offline after 30 minutes of inactivity
  });
}

Timer? _timer;
void cancelTimer() {
  _timer?.cancel(); // Cancel the timer if it's active
}
