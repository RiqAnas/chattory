import 'dart:io';

import 'package:flutter/material.dart';
import 'package:novoprojchat/components/userImagePicker.dart';
import 'package:novoprojchat/core/models/aFormData.dart';

class Authform extends StatefulWidget {
  final void Function(Aformdata) onSubmit;

  Authform({required this.onSubmit});
  @override
  State<Authform> createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  final _formKey = GlobalKey<FormState>();
  final _authData = Aformdata();
  File? _imager;

  void _showError(String msg) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).disabledColor,
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_imager == null && _authData.isSignup) {
      return _showError("Imagem não cadastrada!");
    }

    widget.onSubmit(_authData);
  }

  //Exemplo de como funciona uma função de atribuição indireta
  void _handleImagePick(File image) {
    _imager = image;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_authData.isSignup)
                Userimagepicker(onImagePick: _handleImagePick),

              if (_authData.isSignup)
                TextFormField(
                  //atribui um valor para diferenciar cada campo
                  key: ValueKey("name"),
                  //valor inicial
                  initialValue: _authData.nome,
                  onChanged: (name) => _authData.nome = name,
                  decoration: InputDecoration(label: Text("Nome")),
                  validator: (_name) {
                    final name = _name ?? '';
                    if (name.trim().length < 5) {
                      return 'Nome deve ter no mínimo 6 caracters';
                    }
                    return null;
                  },
                ),
              TextFormField(
                key: ValueKey("email"),
                initialValue: _authData.email,
                onChanged: (email) => _authData.email = email,
                decoration: InputDecoration(label: Text("Email")),
                validator: (_email) {
                  final email = _email ?? '';
                  if (!email.contains('@')) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: ValueKey("password"),
                initialValue: _authData.pass,
                onChanged: (password) => _authData.pass = password,
                obscureText: true,
                decoration: InputDecoration(label: Text("Senha")),
                validator: (_pass) {
                  final password = _pass ?? '';
                  if (password.trim().length < 5) {
                    return 'Senha deve ter no mínimo 6 caracters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_authData.isLogin ? "Entrar" : "Cadastrar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _authData.toggleMode();
                  });
                },
                child: Text(_authData.isLogin ? "Se cadastrar" : "Fazer login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
