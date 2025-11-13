import 'package:flutter/material.dart';
import 'package:novoprojchat/core/models/charMessage.dart';

class Messagebubble extends StatelessWidget {
  final Charmessage message;
  final bool belongsToUser;

  Messagebubble({required this.message, required this.belongsToUser, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Row(
          mainAxisAlignment: belongsToUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: belongsToUser ? Colors.lightBlueAccent : Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: belongsToUser
                        ? Radius.circular(12)
                        : Radius.zero,
                    bottomRight: belongsToUser
                        ? Radius.zero
                        : Radius.circular(12),
                  ),
                ),
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: belongsToUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.userName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(message.text),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: belongsToUser ? null : 100,
          right: belongsToUser ? 165 : null,
          child: CircleAvatar(),
        ),
      ],
    );
  }
}
