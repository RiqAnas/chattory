import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:novoprojchat/core/models/charMessage.dart';
import 'package:novoprojchat/core/models/chatUser.dart';
import 'package:novoprojchat/core/services/chat/chatService.dart';

class Chatfirebaseservice implements Chatservice {
  @override
  Stream<List<Charmessage>> messageStream() {
    final store = FirebaseFirestore.instance;
    final snapshots = store
        .collection('chat')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .orderBy('createdAt', descending: true)
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });

    /* return Stream<List<Charmessage>>.multi((controller) {
      snapshots.listen((query) {
        for (final x in query.docs) {
          List<Charmessage> lista = query.docs.map((doc) {
            return doc.data();
          }).toList();
          controller.add(lista);
        
      });
    });*/
  }

  @override
  Future<Charmessage?> save(String text, Chatuser user) async {
    final store = FirebaseFirestore.instance;

    final msg = Charmessage(
      id: '',
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userImageURL: user.imageUrl,
      userName: user.name,
    );

    final docRef = await store
        .collection('chat')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(msg);

    final doc = await docRef.get();
    return doc.data()!;
  }

  Map<String, dynamic> _toFirestore(Charmessage msg, SetOptions? options) {
    return {
      'text': msg.text,
      'createdAt': DateTime.now().toIso8601String(),
      'userId': msg.id,
      'userName': msg.userName,
      'userImageUrl': msg.userImageURL,
    };
  }

  Charmessage _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return Charmessage(
      id: doc.id,
      text: doc['text'],
      createdAt: DateTime.parse(doc['createdAt']),
      userId: doc['userId'],
      userImageURL: doc['userImageUrl'],
      userName: doc['userName'],
    );
  }
}
