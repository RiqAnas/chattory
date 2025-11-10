import 'package:flutter/material.dart';
import 'package:novoprojchat/components/authForm.dart';
import 'package:novoprojchat/core/models/aFormData.dart';
import 'package:novoprojchat/core/services/auth/authService.dart';

class Authpage extends StatefulWidget {
  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(Aformdata formData) async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (formData.isLogin) {
        await Authservice().login(formData.email, formData.pass);
      } else {
        await Authservice().signUp(
          formData.nome,
          formData.email,
          formData.pass,
          formData.image!,
        );
      }
    } catch (e) {
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
