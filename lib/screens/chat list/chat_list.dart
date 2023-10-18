import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/screens/chat%20screen/service/chat_service.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {

    ChatService _chatService = ChatService();
    return Scaffold(
      appBar: AppBar(title: Text('Chat list'),),
      // body: SafeArea(child: FutureBuilder(future: _chatService.fetchUsersFromMessages(currentUserId, otherUserId), builder: builder)),
    );
  }
}