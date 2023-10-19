import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/model/user_model.dart';
import 'package:sitare_astrologer_partner/screens/chat%20screen/chat_screen.dart';
import 'package:sitare_astrologer_partner/screens/chat%20screen/service/chat_service.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

  //  List<UserModel> users = [];
   ChatService _chatService = ChatService();

  // @override
  // void initState() {
  //   super.initState();
  //   fetchData();
  // }

  // Future<void> fetchData() async {
  //   String currentUserId = FirebaseAuth.instance.currentUser!.uid; // Replace with your current user ID
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('chat_rooms')
  //       .where('participants', arrayContains: currentUserId)
  //       .get();

  //   List<String> chatIds = _chatService.extractChatIds(querySnapshot, currentUserId);
  //   print(chatIds);
  //   List<UserModel> fetchedUsers = await _chatService.fetchOtherParticipants(chatIds, currentUserId);

  //   setState(() {
  //     users = fetchedUsers;
  //   });
  // }

  @override
  Widget build(BuildContext context) {

   
    return Scaffold(
      appBar: AppBar(title: Text('Chat list'),),
      // body: SafeArea(child: ListView.builder(
      //   itemCount: users.length,
      //   itemBuilder: (context, index) {
      //    return users.isEmpty ? Center(child: Text('data')): ListTile(
      //       title: Text(users[index].name),
      //       // subtitle: Text(users[index].),
      //     );
      // },)),
      body: SafeArea(child: FutureBuilder(future: _chatService.fetchOtherParticipants(), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.hasData) {
              List<UserModel> users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreen(user: users[index]),));
                    },
                    child: ListTile(
                      title: Text(users[index].name),
                      // subtitle: Text(users[index].email),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No data available'));
            }
      }})),
    );
  }
}