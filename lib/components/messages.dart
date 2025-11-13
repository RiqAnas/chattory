import 'package:flutter/material.dart';
import 'package:novoprojchat/components/messageBubble.dart';
import 'package:novoprojchat/core/models/charMessage.dart';
import 'package:novoprojchat/core/services/auth/authService.dart';
import 'package:novoprojchat/core/services/chat/chatService.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = Authservice().currentUser;
    // TODO: implement build
    return StreamBuilder<List<Charmessage>>(
      stream: Chatservice().messageStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Sem Mensagens"));
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (context, index) {
              return Messagebubble(
                key: ValueKey(msgs[index].id),
                message: msgs[index],
                belongsToUser: currentUser!.id == msgs[index].userId,
              );
            },
          );
        }
      },
    );
  }
}
