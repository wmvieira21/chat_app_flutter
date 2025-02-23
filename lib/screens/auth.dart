import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthScreen();
  }
}

class _AuthScreen extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late UserCredential user;
  bool isLogin = true;

  _onLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        user = await firebase.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } on FirebaseAuthException catch (error) {
        showSnackBarMessage(context, error.message.toString());
      }
    }
  }

  _onSignup() async {
    if (_formKey.currentState!.validate()) {
      try {
        user = await firebase.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } on FirebaseAuthException catch (error) {
        showSnackBarMessage(context, error.message.toString());
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Email Address'),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains('@')) {
                                  return 'Invalid email.';
                                }
                                return null;
                              },
                              controller: emailController,
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Password'),
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              autocorrect: false,
                              validator: (value) {
                                if (value!.isEmpty || value.trim().length < 5) {
                                  return 'Password must have at leat 6 caracters.';
                                }
                                return null;
                              },
                              controller: passwordController,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            if (isLogin)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer),
                                onPressed: _onLogin,
                                child: Text('Log In'),
                              ),
                            if (!isLogin)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer),
                                onPressed: _onSignup,
                                child: Text('Sign Up'),
                              ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isLogin = !isLogin;
                                });
                              },
                              child: Text(isLogin
                                  ? 'Create an account'
                                  : 'Already have an account'),
                            ),
                          ],
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
