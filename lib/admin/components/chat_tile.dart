import 'package:chat_app_task/app/app_state.dart';
import 'package:chat_app_task/firebase/firebase_utils.dart';
import 'package:chat_app_task/models/chat.dart';
import 'package:chat_app_task/utils/date_utli.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';

class ChatTile extends StatefulWidget {
  final Chat chat;
  const ChatTile({
    super.key,
    required this.chat,
  });

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onTap: () {
        final timediff = Timestamp.now().seconds - widget.chat.lastseen.seconds;

        if (appState.loggedInAgentId != widget.chat.agentId && timediff < 900) {
          alreadyAssigneduserDialog();
          return;
        }

        appState.setCurrentUserId(widget.chat.id);
        appState.setCurrentChat(widget.chat);
        FirebaseUtils.setAgentToChat(
          appState.currentUserId!,
          appState.loggedInAgentId!,
          appState.loggedInAgent!,
        );
      },
      key: Key(widget.chat.id),
      leading: randomAvatar(
        widget.chat.id,
        height: 40,
        width: 40,
      ),
      selected: (appState.currentUserId == widget.chat.id),
      selectedTileColor: Colors.grey.shade200,
      title: Text('UserId : ${widget.chat.id}'),
      subtitle: Text('Agent : ${widget.chat.agent}'),
      trailing: Text(getFormatedDate(widget.chat.lastseen)),
    );
  }

  void alreadyAssigneduserDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close_rounded),
                ),
                const Text(
                  'This chat is already handled by other agent,\nPlease pick up another one',
                  textAlign: TextAlign.center,
                )
              ],
            ),
          );
        });
  }
}
