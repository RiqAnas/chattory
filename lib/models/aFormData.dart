enum AuthMode { Signup, Login }

class Aformdata {
  String nome = '';
  String email = '';
  String pass = '';
  AuthMode _mode = AuthMode.Login;

  bool get isLogin {
    return _mode == AuthMode.Login;
  }

  bool get isSignup {
    return _mode == AuthMode.Signup;
  }

  void toggleMode() {
    _mode = isLogin ? AuthMode.Signup : AuthMode.Login;
  }
}
