import 'dart:async';
import 'dart:math';

import 'package:novoprojchat/core/models/charMessage.dart';
import 'package:novoprojchat/core/models/chatUser.dart';
import 'package:novoprojchat/core/services/chat/chatService.dart';

class Chatmockservice implements Chatservice {
  static final List<Charmessage> _msg = [
    Charmessage(
      id: '1',
      text: 'OPAAAA!!! Boa tarde',
      createdAt: DateTime.now(),
      userId: '123',
      userImageURL:
          'https://preview.redd.it/l0ergarfzst61.png?auto=webp&s=5de076eac09bb645d58b11cd8ce82f99ec487329',
      userName: 'Teste',
    ),
    Charmessage(
      id: '2',
      text: 'Oiiii tudo bem?',
      createdAt: DateTime.now(),
      userId: '456',
      userImageURL:
          'https://preview.redd.it/l0ergarfzst61.png?auto=webp&s=5de076eac09bb645d58b11cd8ce82f99ec487329',
      userName: 'TesteR',
    ),
  ];
  static MultiStreamController<List<Charmessage>>? _controller;
  static final _msgsStream = Stream<List<Charmessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msg);
  });

  @override
  Stream<List<Charmessage>> messageStream() {
    return _msgsStream;
  }

  @override
  Future<Charmessage> save(String text, Chatuser user) async {
    final newMessage = Charmessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userImageURL: user.imageUrl,
      userName: user.name,
    );

    _msg.add(newMessage);
    _controller?.add(_msg.reversed.toList());
    return newMessage;
  }
}
