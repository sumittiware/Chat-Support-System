import 'package:chat_app_task/client/components/messege_field.dart';
import 'package:chat_app_task/client/components/messeges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClientChatScreen extends StatefulWidget {
  final String userId;

  const ClientChatScreen({
    super.key,
    required this.userId,
  });

  @override
  State<ClientChatScreen> createState() => _ClientChatScreenState();
}

class _ClientChatScreenState extends State<ClientChatScreen> {
  bool _isClosed = false;

  getValue() async {
    final fetchedData = await FirebaseFirestore.instance
        .collection('support')
        .doc(widget.userId)
        .get();

    final data = fetchedData.data()!;
    setState(() {
      _isClosed = (data['closed']) ?? false;
    });
  }

  @override
  void initState() {
    getValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Support'),
      ),
      body: Column(
        children: [
          Expanded(
            child: AllMesseges(
              userId: widget.userId,
            ),
          ),
          (_isClosed)
              ? Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  height: 50,
                  color: Colors.grey.shade400,
                  alignment: Alignment.center,
                  child: const Text(
                    'The chat is Closed by the agent, we hope the issue is solved, If not please start a new chat',
                    textAlign: TextAlign.center,
                  ),
                )
              : MessegeInputField(
                  isAdmin: false,
                  userId: widget.userId,
                ),
        ],
      ),
    );
  }
}
