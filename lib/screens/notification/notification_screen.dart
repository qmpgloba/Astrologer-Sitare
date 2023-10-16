import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sitare_astrologer_partner/functions/firebase_auth_methods.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: FutureBuilder(
        future: fetchNotifications(), // Create this function to fetch data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Display the list of notifications
            return buildNotificationList(snapshot.data);
          }
        },
      ),
    );
  }

  // Define a function to fetch notifications from Firestore
  Future<List<Map<String, dynamic>>?> fetchNotifications() async {
    try {
      final userUID = currentUser!.uid;
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore
          .collection('Notification')
          .where('uid', isEqualTo: userUID)
          .orderBy("timestamp", descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching notifications: $e');
      return null;
    }
  }

  // Build the list of notifications

  Widget buildNotificationList(List<Map<String, dynamic>>? notifications) {
    if (notifications == null || notifications.isEmpty) {
      return Center(child: Text('No notifications available.'));
    } else {
      return ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final timestamp = notification['timestamp'] as Timestamp;

          final formattedDate =
              DateFormat('dd MMMM').format(timestamp.toDate());
          final formattedTime =
              DateFormat('hh:mm a').format(timestamp.toDate());
          final date = formattedDate + " ${formattedTime}";

          return ListTile(
            title: Text(notification['title']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification['body']),
                Text(date),
              ],
            ),
            // You can display additional notification details here
          );
        },
      );
    }
  }
}
