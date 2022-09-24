import 'package:chat_app_task/app/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';

class ProfileComponent extends StatelessWidget {
  const ProfileComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Container(
      padding: const EdgeInsets.all(8),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Customer Profile',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                appState.setProfileView(false);
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            randomAvatar(
              appState.currentUserId!,
              height: 70,
              width: 70,
            ),
            const SizedBox(
              height: 16,
            ),
            Text("User Id : ${appState.currentUserId!}"),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
