import 'package:chat_app_task/app/app_state.dart';
import 'package:chat_app_task/client/components/messege_field.dart';
import 'package:chat_app_task/client/components/messeges.dart';
import 'package:chat_app_task/common/placeholder_widget.dart';
import 'package:chat_app_task/firebase/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';

class ChatComponent extends StatefulWidget {
  const ChatComponent({
    super.key,
  });

  @override
  State<ChatComponent> createState() => _ChatComponentState();
}

class _ChatComponentState extends State<ChatComponent> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return (appState.currentUserId == null)
        ? const PlaceHolderWidget(
            label: 'Welcome to Branch International Help desk',
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'UserId : ${appState.currentUserId!}',
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  appState.setProfileView(true);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: randomAvatar(
                    appState.currentUserId!,
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    FirebaseUtils.closeChat(appState.currentChat!.id)
                        .then((_) => appState.closeChat());
                  },
                  child: const Text(
                    'Close chat',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                if (appState.isSmallScreen)
                  IconButton(
                    onPressed: () {
                      appState.popChatScreen();
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.black,
                    ),
                  )
              ],
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Column(
              children: [
                Expanded(
                  child: AllMesseges(
                    userId: appState.currentUserId!,
                  ),
                ),
                if (!appState.currentChat!.isClosed)
                  MessegeInputField(
                    isAdmin: true,
                    userId: appState.currentUserId!,
                  ),
              ],
            ),
          );
  }
}
