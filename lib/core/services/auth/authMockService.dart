import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:novoprojchat/core/models/chatUser.dart';
import 'package:novoprojchat/core/services/auth/authService.dart';

class Authmockservice implements Authservice {
  static final _defaultUser = Chatuser(
    email: "opa@gmail.com",
    id: '1',
    imageUrl:
        'https://preview.redd.it/l0ergarfzst61.png?auto=webp&s=5de076eac09bb645d58b11cd8ce82f99ec487329',
    name: 'teste',
  );
  //transformar um atributo em statico faz ele ser não instanciavel (sendo um valor intrinseco à classe)
  static Map<String, Chatuser> _users = {_defaultUser.email: _defaultUser};
  static Chatuser? _currentUser;
  static MultiStreamController<Chatuser?>? _controller;
  static final _userStream = Stream<Chatuser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
  });

  Chatuser? get currentUser {
    return _currentUser;
  }

  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  Future<void> logout() async {
    _updateUser(null);
  }

  Future<void> signUp(
    String nome,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = Chatuser(
      email: email,
      id: Random().nextDouble().toString(),
      imageUrl:
          image?.path ??
          'https://preview.redd.it/l0ergarfzst61.png?auto=webp&s=5de076eac09bb645d58b11cd8ce82f99ec487329',
      name: nome,
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  Stream<Chatuser?> get userChanges {
    return _userStream;
  }

  static void _updateUser(Chatuser? user) {
    _currentUser = null;
    _controller?.add(_currentUser);
  }
}
