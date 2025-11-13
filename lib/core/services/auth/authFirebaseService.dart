import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:novoprojchat/core/models/chatUser.dart';
import 'package:novoprojchat/core/services/auth/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authfirebaseservice implements Authservice {
  //transformar um atributo em statico faz ele ser não instanciavel (sendo um valor intrinseco à classe)
  static Chatuser? _currentUser;
  static final _userStream = Stream<Chatuser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);
      controller.add(_currentUser);
    }
  });

  Chatuser? get currentUser {
    return _currentUser;
  }

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<void> signUp(
    String nome,
    String email,
    String password,
    File? image,
  ) async {
    final auth = FirebaseAuth.instance;
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user == null) return;

    credential.user?.updateDisplayName(nome);

    _saveChatUser(_toChatUser(credential.user!));
  }

  Stream<Chatuser?> get userChanges {
    return _userStream;
  }

  static Chatuser _toChatUser(User user) {
    return Chatuser(
      email: user.email!,
      id: user.uid,
      imageUrl:
          'https://preview.redd.it/l0ergarfzst61.png?auto=webp&s=5de076eac09bb645d58b11cd8ce82f99ec487329',
      name: user.displayName ?? user.email!,
    );
  }

  Future<void> _saveChatUser(Chatuser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    docRef.set({
      'name': user.name,
      'email': user.email,
      'imageUrl':
          'https://preview.redd.it/l0ergarfzst61.png?auto=webp&s=5de076eac09bb645d58b11cd8ce82f99ec487329',
    });
  }
}
