import 'package:flutter/material.dart';
import 'package:novoprojchat/components/authForm.dart';
import 'package:novoprojchat/models/aFormData.dart';

class Authpage extends StatefulWidget {
  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  bool _isLoading = false;

  void _handleSubmit(Aformdata formData) {
    setState(() {
      _isLoading = true;
    });
    print(formData.email);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Authform(onSubmit: _handleSubmit),
            ),
          ),
          if (_isLoading)
            Container(
              decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              child: Center(child: RefreshProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
