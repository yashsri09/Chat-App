import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futuresnapshot) {
        if (futuresnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (ctx, chatsnapshot) {
            if (chatsnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatdocs = chatsnapshot.data.documents;

            return ListView.builder(
              reverse: true,
              itemCount: chatdocs.length,
              itemBuilder: (ctx, index) => MessageBubble(
                chatdocs[index]['text'],
                chatdocs[index]['userid'] == futuresnapshot.data.uid,
                ValueKey(chatdocs[index].documentID),
                chatdocs[index]['username'],
                chatdocs[index]['userImage'],
              ),
            );
          },
        );
      },
    );
  }
}
