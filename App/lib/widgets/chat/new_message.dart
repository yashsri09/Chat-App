import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredmessage = '';
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userdata =
        await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('chat').add({
      'text': _enteredmessage,
      'createdAt': Timestamp.now(),
      'userid': user.uid,
      'username': userdata['username'],
      'userImage': userdata['image_url'],
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Send a message....',
              ),
              onChanged: (value) {
                setState(() {
                  _enteredmessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
              Icons.send,
            ),
            onPressed: _enteredmessage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
