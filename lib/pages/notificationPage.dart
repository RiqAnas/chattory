import 'package:flutter/material.dart';
import 'package:novoprojchat/core/services/notification/pushNotificationService.dart';
import 'package:provider/provider.dart';

class Notificationpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final service = Provider.of<Pushnotificationservice>(
      context,
      listen: false,
    );
    final items = service.items;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificações"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].title),
            subtitle: Text(items[index].body),
          );
        },
      ),
    );
  }
}
