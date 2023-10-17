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
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: fetchNotifications(), // Create this function to fetch data
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Display the list of notifications
              return buildNotificationList(snapshot.data);
            }
          },
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>?> fetchNotifications() async {
    try {
      final userUID = currentUser!.uid;
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore
          .collection('Notification')
          .where('uid', isEqualTo: userUID)
          // .orderBy("timestamp", descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching notifications: $e');
      return null;
    }
  }

  Future<void> deleteAllNotifications() async {
    try {
      final userUID = currentUser!.uid;
      final firestore = FirebaseFirestore.instance;
      final querySnapshot = await firestore
          .collection('Notification')
          .where('uid', isEqualTo: userUID)
          .get();

      for (final document in querySnapshot.docs) {
        await document.reference.delete();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Notifications have been cleared.'),
        ),
      );

      setState(() {});
    } catch (e) {
      print('Error deleting notifications: $e');
    }
  }

  Widget buildNotificationList(List<Map<String, dynamic>>? notifications) {
    Size size = MediaQuery.sizeOf(context);

    return Padding(
      padding: EdgeInsets.all(size.width / 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Notifications",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              InkWell(
                onTap: () {
                  deleteAllNotifications();
                },
                child: Container(
                  width: size.width * 0.13,
                  height: size.width * 0.13,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withOpacity(0.7),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: size.width * 0.06,
                    ),
                  ),
                ),
              ),
            ],
          ),
          (notifications == null || notifications.isEmpty)
              ? Padding(
                  padding: EdgeInsets.only(top: size.width * 0.75),
                  child:
                      Text("Looks like you haven't recieved any notification"),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  shrinkWrap: true,
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
                      leading: InkWell(
                        onTap: () {},
                        child: Container(
                          width: size.width * 0.15,
                          height: size.width * 0.15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFd3f5d6),
                          ),
                          child: Center(
                            child: Image.asset("assets/images/call.png"),
                          ),
                        ),
                      ),
                      title: Text(notification['title']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notification['body']),
                          //Text(date),
                        ],
                      ),
                    );
                  },
                )
        ],
      ),
    );
  }
}
