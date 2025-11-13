import 'package:flutter/material.dart';
import 'package:novoprojchat/components/messages.dart';
import 'package:novoprojchat/components/newMessage.dart';
import 'package:novoprojchat/core/models/chatNotification.dart';
import 'package:novoprojchat/core/services/auth/authService.dart';
import 'package:novoprojchat/core/services/notification/pushNotificationService.dart';
import 'package:novoprojchat/pages/notificationPage.dart';
import 'package:provider/provider.dart';

class Chatpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              items: [
                DropdownMenuItem(
                  value: "logout",
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app, color: Colors.black),
                        SizedBox(width: 10),
                        Text("Sair"),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == "logout") {
                  Authservice().logout();
                }
              },
              icon: Icon(Icons.more_vert, color: Colors.black),
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Notificationpage()),
                ),
                icon: Icon(Icons.notifications, color: Colors.black),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  maxRadius: 5,
                  backgroundColor: Colors.red,
                  child: Text(
                    '${Provider.of<Pushnotificationservice>(context).items.length}',
                    style: TextStyle(fontSize: 9),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Center(child: Messages())),
            Newmessage(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<Pushnotificationservice>(
            context,
            listen: false,
          ).add(Chatnotification(title: 'Texto', body: "texto"));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
