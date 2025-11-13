import 'package:flutter/material.dart';
import 'package:novoprojchat/core/services/auth/authService.dart';
import 'package:novoprojchat/core/services/chat/chatService.dart';

class Newmessage extends StatefulWidget {
  @override
  State<Newmessage> createState() => _NewmessageState();
}

class _NewmessageState extends State<Newmessage> {
  String _enterMessage = '';
  final _controller = TextEditingController();

  Future<void> _sendMessage() async {
    final user = Authservice().currentUser;

    if (user != null) {
      await Chatservice().save(_enterMessage, user);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onChanged: (msg) {
              setState(() {
                _enterMessage = msg;
              });
            },
            decoration: InputDecoration(labelText: "Nova mensagem"),
          ),
        ),
        IconButton(
          onPressed: _enterMessage.trim().isEmpty ? null : _sendMessage,
          icon: Icon(Icons.send),
        ),
      ],
    );
  }
}
