import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    BuildContext ctx,
    String email,
    String userName,
    String password,
    bool isLogin,
  ) submitFn;

  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();

    FocusScope.of(context).unfocus(); //fecha o teclado

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(context, _userEmail.trim(), _userName.trim(),
          _userPassword.trim(), _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid e-mail!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'e-mail'),
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Invalid username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value;
                      },
                      decoration: InputDecoration(labelText: 'User name'),
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Invalid password!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(_isLogin ? 'Signup' : 'Signin'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
