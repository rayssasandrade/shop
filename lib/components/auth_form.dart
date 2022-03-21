import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.Signup;
      } else {
        _authMode = AuthMode.Login;
      }
    });
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();

    if (_isLogin()) {
      //Login
    } else {
      // Registrar
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(16),
      width: deviceSize.width * 0.75,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'E-mail',
                labelStyle: TextStyle(
                    color: Colors.teal, fontFamily: "Lato", fontSize: 15.0),
                filled: true,
                fillColor: Color.fromRGBO(131, 208, 201, 0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide(color: Colors.black, width: 0.5),
                ),
                //InputBorder.none,
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.teal,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (_email) {
                final email = _email ?? '';
                if (email.trim().isEmpty || !email.contains('@')) {
                  return 'Infome uma e-mail válida';
                }
                return null;
              },
              onSaved: (email) => _authData['email'] = email ?? '',
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(
                    color: Colors.teal, fontFamily: "Lato", fontSize: 15.0),
                filled: true,
                fillColor: Color.fromRGBO(131, 208, 201, 0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(90.0)),
                  borderSide: BorderSide(color: Colors.black, width: 0.5),
                ),
                //InputBorder.none,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.teal,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              controller: _passwordController,
              validator: (_password) {
                final password = _password ?? '';
                if (password.isEmpty || password.length < 5) {
                  return 'Infome uma senha válida';
                }
                return null;
              },
              onSaved: (password) => _authData['password'] = password ?? '',
            ),
            SizedBox(
              height: 10,
            ),
            if (_isSignup())
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Confirmar senha',
                  labelStyle: TextStyle(
                      color: Colors.teal, fontFamily: "Lato", fontSize: 15.0),
                  filled: true,
                  fillColor: Color.fromRGBO(131, 208, 201, 0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(90.0)),
                    borderSide: BorderSide(color: Colors.black, width: 0.5),
                  ),
                  //InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.teal,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                validator: _isLogin()
                    ? null
                    : (_password) {
                        final password = _password ?? '';
                        if (password != _passwordController) {
                          return 'Senhas informadas não conferem.';
                        }
                        return null;
                      },
              ),
            SizedBox(
              height: 20,
            ),
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _submit,
                child:
                    Text(_authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: _switchAuthMode,
              child: Text(
                  _isLogin() ? 'Não tem uma conta?' : 'Já possui uma conta?'),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "Não possui conta ? ",
            //       style: TextStyle(color: Theme.of(context).primaryColor),
            //     ),
            //     GestureDetector(
            //       onTap: () {},
            //       child: Text(
            //         "Registrar",
            //         style: TextStyle(
            //             color: Theme.of(context).primaryColor,
            //             fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
