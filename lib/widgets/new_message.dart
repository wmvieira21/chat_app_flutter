import 'package:chat_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() {
    return _NewMessage();
  }
}

class _NewMessage extends State<NewMessage> {
  final _messagecontroller = TextEditingController();

  _submitMessage() async {
    FocusScope.of(context).unfocus();

    final enteredMessage = _messagecontroller.text;
    if (enteredMessage.trim().isEmpty) {
      return;
    }

    final user = firebase.currentUser!;
    final userData = await firestore.collection('users').doc(user.uid).get();

    await firestore.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['username'],
      'userImage': userData.data()!['image_url'],
    });
    _messagecontroller.clear();
  }

  @override
  void dispose() {
    _messagecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 15, right: 1, bottom: 14),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                decoration: InputDecoration(
                  labelText: 'Send a message...',
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                maxLines: 1,
                autocorrect: true,
                enableSuggestions: true,
                textCapitalization: TextCapitalization.sentences,
                controller: _messagecontroller,
              ),
            ),
            IconButton(
                onPressed: _submitMessage,
                icon: Icon(
                  Icons.send,
                  size: 25,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                )),
          ],
        ));
  }
}
