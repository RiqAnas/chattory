import 'package:flutter/material.dart';
import 'package:novoprojchat/core/services/auth/authMockService.dart';

class Chatpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Chat"),
            TextButton(
              onPressed: () => Authmockservice().logout(),
              child: Text("logout"),
            ),
          ],
        ),
      ),
    );
  }
}
