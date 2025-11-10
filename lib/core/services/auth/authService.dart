import 'dart:io';
import 'package:novoprojchat/core/models/chatUser.dart';
import 'package:novoprojchat/core/services/auth/authMockService.dart';

abstract class Authservice {
  Chatuser? get currentUser;

  Stream<Chatuser?> get userChanges;

  Future<void> signUp(String nome, String email, String password, File image);
  Future<void> login(String email, String password);
  Future<void> logout();

  factory Authservice() {
    return Authmockservice();
  }
}
