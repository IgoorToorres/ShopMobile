import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/models/auth/provider/auth.dart';

// ignore: constant_identifier_names
enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  bool _isObscureText = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _authData = {
    "email": '',
    "password": '',
  };

  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;

  void _switchAuthMode() {
    setState(() {
      _authMode =
          _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
    });
  }

  void _switchObscureText() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu um erro:'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: Navigator.of(ctx).pop,
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Future<void> _onSubmit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    setState(() => _isLoading = true);
    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        await auth.login(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        await auth.signup(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on AuthException catch (err) {
      _showErrorDialog(err.toString());
    } catch (err) {
      _showErrorDialog('Erro inesperado!');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: _isLogin() ? 310 : 380,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (email) => _authData['email'] = email ?? '',
                validator: (_email) {
                  final email = _email ?? '';
                  if (email.trim().isEmpty || !email.contains('@')) {
                    return 'Email inválido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _switchObscureText,
                    icon: Icon(_isObscureText
                        ? Icons.visibility_off
                        : Icons.visibility),
                    iconSize: 20,
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: _isObscureText,
                controller: _passwordController,
                onSaved: (password) => _authData['password'] = password ?? '',
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.isEmpty || password.length < 6) {
                    return 'Senha deve conter minimo 6 letras';
                  }
                  return null;
                },
              ),
              if (_isSignup()) const SizedBox(height: 16),
              if (_isSignup())
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    suffixIcon: IconButton(
                      onPressed: _switchObscureText,
                      icon: Icon(_isObscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      iconSize: 20,
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _isObscureText,
                  validator: _isLogin()
                      ? null
                      : (_password) {
                          final password = _password ?? '';
                          if (password != _passwordController.text) {
                            return 'Senhas Informadas não conferem';
                          }
                          return null;
                        },
                ),
              const SizedBox(height: 24),
              if (_isLoading)
                CircularProgressIndicator(
                  color: Colors.blue,
                ),
              SizedBox(
                width: double.infinity,
                child: _isLoading
                    ? null
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _onSubmit,
                        child: Text(
                          _isLogin() ? 'Login' : 'Cadastrar',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
              ),
              TextButton(
                onPressed: _switchAuthMode,
                child: Text(
                  _isLogin()
                      ? 'Criar uma nova conta'
                      : 'Já tem uma conta? Entrar',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
