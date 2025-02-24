import 'package:flutter/material.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  _setUpNotifications() async {
    await firebaseMessaging.requestPermission();
    final token = await firebaseMessaging.getToken();
    firebaseMessaging.subscribeToTopic('chat');
  }

  @override
  void initState() {
    super.initState();
    _setUpNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Messenger'),
          actions: [
            IconButton(
              onPressed: () {
                firebase.signOut();
              },
              icon: Icon(
                Icons.logout_outlined,
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatMessages(),
            ),
            NewMessage(),
          ],
        ));
  }
}
