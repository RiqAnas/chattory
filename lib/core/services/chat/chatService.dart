import 'package:novoprojchat/core/models/charMessage.dart';
import 'package:novoprojchat/core/models/chatUser.dart';
import 'package:novoprojchat/core/services/chat/chatFirebaseService.dart';

abstract class Chatservice {
  //stream vai mostrar mensagens recebidas ao invés de uma lista estática
  Stream<List<Charmessage>> messageStream();
  Future<Charmessage?> save(String text, Chatuser user);

  factory Chatservice() {
    return Chatfirebaseservice();
  }
}
