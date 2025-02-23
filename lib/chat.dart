import 'package:flutter/material.dart';
import 'package:chat_app/screens/auth.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:chat_app/utils/utils.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firebase.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            return const ChatScreen();
          }
          return const AuthScreen();
        });
  }
}
