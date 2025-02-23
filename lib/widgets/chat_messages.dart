import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firestore
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'No messages yet!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            );
          }

          final chatDocs = snapshot.data!.docs;
          return ListView.builder(
              padding: EdgeInsets.only(left: 10, right: 13, bottom: 40),
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  shadowColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(chatDocs[index]['userImage']),
                    ),
                    title: Text(chatDocs[index]['username']),
                    subtitle: Text(chatDocs[index]['text']),
                  ),
                );
              });
        });
  }
}
