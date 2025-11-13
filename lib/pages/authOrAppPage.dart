import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:novoprojchat/core/models/chatUser.dart';
import 'package:novoprojchat/core/services/auth/authService.dart';
import 'package:novoprojchat/pages/authPage.dart';
import 'package:novoprojchat/pages/chatPage.dart';
import 'package:novoprojchat/pages/loadingPage.dart';

class Authorapppage extends StatelessWidget {
  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: init(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loadingpage();
        } else {
          return StreamBuilder<Chatuser?>(
            stream: Authservice().userChanges,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Loadingpage();
              } else {
                return snapshot.hasData ? Chatpage() : Authpage();
              }
            },
          );
        }
      },
    );
  }
}
