
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/functions/contact%20function/contact_fuctions.dart';
import 'package:sitare_astrologer_partner/model/user_model.dart';
import 'package:sitare_astrologer_partner/screens/chat%20screen/service/chat_service.dart';

class ChatInputWidget extends StatelessWidget {
  const ChatInputWidget({
    super.key,
    required TextEditingController messageController, required this.chatService, required this.user, 
  }) : _messageController = messageController;

  final TextEditingController _messageController;
  final ChatService chatService;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
            Expanded(child: TextFormField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Type message',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50)
            
              )
            ),
            )),
            IconButton(onPressed: () {
            sendMessage(_messageController, chatService, user);
            }, icon: const Icon(Icons.send,size: 35,))
                ],),
    );
  }
}
