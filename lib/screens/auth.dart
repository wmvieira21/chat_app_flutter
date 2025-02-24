import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/widgets/user_image_picker.dart';
import 'package:chat_app/utils/utils.dart';

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
  final TextEditingController usernameController = TextEditingController();
  late UserCredential user;

  File? userImageFile;
  String? imageUrlDownloaded;
  bool isLogingIn = true;
  bool isLoading = false;

  _onLogin() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        user = await firebase.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } on FirebaseAuthException catch (error) {
        showSnackBarMessage(context, error.message.toString());
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  _onSignup() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        if (userImageFile != null) {
          user = await _createUserWithEmailAndPassword();
          imageUrlDownloaded = await _updaloadFileImage();
          _saveUserToFirestore();
        } else {
          throw FirebaseAuthException(
              code: 'image_error',
              message: 'Please pick an image before signing up.');
        }
      } on FirebaseAuthException catch (error) {
        showSnackBarMessage(context, error.message.toString());
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<UserCredential> _createUserWithEmailAndPassword() async {
    return await firebase.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }

  Future<void> _saveUserToFirestore() async {
    await firestore.collection('users').doc(user.user!.uid).set({
      'username': usernameController.text,
      'email': emailController.text,
      'image_url': imageUrlDownloaded,
    });
  }

  Future<String> _updaloadFileImage() async {
    final storageRef =
        storage.ref().child('user_images').child('${user.user!.uid}.jpg');
    await storageRef.putFile(userImageFile!);
    return await storageRef.getDownloadURL();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
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
                            if (!isLogingIn)
                              UserImagePicker(
                                  onImagePick: (pickedImage) =>
                                      userImageFile = pickedImage),
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
                            if (!isLogingIn)
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Username'),
                                keyboardType: TextInputType.text,
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      value.trim().length < 4) {
                                    return 'Username must have at leat 4 caracters.';
                                  }
                                  return null;
                                },
                                controller: usernameController,
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
                            if (isLoading) CircularProgressIndicator(),
                            if (isLogingIn && !isLoading)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer),
                                onPressed: _onLogin,
                                child: Text('Log In'),
                              ),
                            if (!isLogingIn && !isLoading)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer),
                                onPressed: _onSignup,
                                child: Text('Sign Up'),
                              ),
                            if (!isLoading)
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isLogingIn = !isLogingIn;
                                  });
                                },
                                child: Text(isLogingIn
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
