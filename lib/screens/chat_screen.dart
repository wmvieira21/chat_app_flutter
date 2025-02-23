import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: AppBar(
          toolbarHeight: 50,
          title: Text('Chat App'),
          actions: [
            IconButton(
                onPressed: () {
                  firebase.signOut();
                },
                icon: Icon(
                  Icons.exit_to_app,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ))
          ],
        ),
        body: Center(
          child: Text('data'),
        ));
  }
}
