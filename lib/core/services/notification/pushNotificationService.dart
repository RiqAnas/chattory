import 'package:flutter/material.dart';
import 'package:novoprojchat/core/models/chatNotification.dart';

class Pushnotificationservice with ChangeNotifier {
  List<Chatnotification> _items = [];

  List<Chatnotification> get items {
    return [..._items];
  }

  void add(Chatnotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  void remove(int i) {
    _items.removeAt(i);
  }
}
