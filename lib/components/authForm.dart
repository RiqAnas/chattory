import 'package:flutter/material.dart';
import 'package:novoprojchat/models/aFormData.dart';

class Authform extends StatefulWidget {
  final void Function(Aformdata) onSubmit;

  Authform({required this.onSubmit});
  @override
  State<Authform> createState() => _AuthformState();
}

class _AuthformState extends State<Authform> {
  final _formKey = GlobalKey<FormState>();
  final _authData = Aformdata();

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    widget.onSubmit(_authData);
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
