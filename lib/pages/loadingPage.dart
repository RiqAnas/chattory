import 'package:flutter/material.dart';

class Loadingpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RefreshProgressIndicator(),
            SizedBox(height: 10),
            Text("Carregando...", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
