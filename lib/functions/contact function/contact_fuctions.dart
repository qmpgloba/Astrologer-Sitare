
import 'package:flutter/material.dart';
import 'package:sitare_astrologer_partner/model/user_model.dart';
import 'package:sitare_astrologer_partner/screens/chat%20screen/service/chat_service.dart';

void sendMessage(TextEditingController controller,ChatService chatService,UserModel user) async {
    if (controller.text.isNotEmpty) {
      await chatService.sendMessage(
          user.uid, controller.text);

      controller.clear();
    }
  }

  
