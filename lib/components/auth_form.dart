import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/exceptions/auth_exception.dart';
import 'package:shopapp/models/auth.dart';

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

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Ocorreu um Erro',
          style: TextStyle(color: Colors.black),
        ),
        content: Text(
          msg,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        //Login
        await auth.login(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        // Registrar
        await auth.signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(16),
      width: deviceSize.width * 0.85,
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
              onSaved: (email) => _authData['email'] = email ?? '',
              validator: (_email) {
                final email = _email ?? '';
                if (email.trim().isEmpty || !email.contains('@')) {
                  return 'Informe um e-mail válido.';
                }
                return null;
              },
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
              onSaved: (password) => _authData['password'] = password ?? '',
              validator: (_password) {
                final password = _password ?? '';
                if (password.isEmpty || password.length < 5) {
                  return 'Informe uma senha válida';
                }
                return null;
              },
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
                        if (password != _passwordController.text) {
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
