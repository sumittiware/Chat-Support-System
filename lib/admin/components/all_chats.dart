import 'package:chat_app_task/admin/components/chat_tile.dart';
import 'package:chat_app_task/app/app_state.dart';
import 'package:chat_app_task/common/placeholder_widget.dart';
import 'package:chat_app_task/models/chat.dart';
import 'package:chat_app_task/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllChats extends StatefulWidget {
  const AllChats({super.key});

  @override
  State<AllChats> createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('support').snapshots(),
      builder: (context, snapshots) {
        if (snapshots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final data = snapshots.data!.docs;
        print('here : ${data.length}');
        List<Chat> chats = [];

        for (var ele in data) {
          chats.add(Chat.fromJson(ele));
        }

        // Shows only assigned Chats
        if (appState.chatStatus == ChatStatus.unassigned) {
          chats.removeWhere((chat) => chat.agentId != '-1');
        }
        if (appState.chatStatus == ChatStatus.active) {
          // remove all inactive chats
          chats.removeWhere((chat) {
            if (chat.lastseen == Timestamp(0, 0)) {
              return true;
            }
            final timediff = Timestamp.now().seconds - chat.lastseen.seconds;
            if (timediff < 900) {
              return false;
            }
            return true;
          });
        }
        //the chats that are inactive For more than 15 min
        if (appState.chatStatus == ChatStatus.inactive) {
          chats.removeWhere((chat) {
            if (chat.lastseen == Timestamp(0, 0)) {
              return false;
            }
            final timediff = Timestamp.now().seconds - chat.lastseen.seconds;
            if (timediff < 900) {
              return true;
            }
            return false;
          });
        }

        // only finished chats will be displayed
        if (appState.chatStatus == ChatStatus.solved) {
          chats.removeWhere((chat) => !chat.isClosed);
        }

        if (appState.prefix.isNotEmpty) {
          chats.removeWhere((chat) => !chat.id.startsWith(appState.prefix));
        }

        if (chats.isEmpty) {
          return const PlaceHolderWidget(label: 'No data found!');
        }

        return ListView.builder(
          itemBuilder: ((context, index) {
            final chat = chats[index];
            return ChatTile(chat: chat);
          }),
          itemCount: chats.length,
        );
      },
    );
  }
}
