import 'package:chat_app_task/admin/components/all_chats.dart';
import 'package:chat_app_task/admin/components/chat_tile.dart';
import 'package:chat_app_task/admin/components/profile_view.dart';
import 'package:chat_app_task/admin/components/single_chat.dart';
import 'package:chat_app_task/app/app_state.dart';
import 'package:chat_app_task/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({super.key});

  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}

class _AdminDashBoardState extends State<AdminDashBoard> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _buildAdminDashboard();
  }

  Widget _buildAdminDashboard() {
    return Scaffold(
      appBar: _getAppBar(),
      body: _getDashBoardBody(),
    );
  }

  PreferredSize _getAppBar() {
    return PreferredSize(
      preferredSize: Size(
        MediaQuery.of(context).size.width,
        kToolbarHeight,
      ),
      child: Material(
        elevation: 4,
        child: Container(
          height: kToolbarHeight,
          color: Colors.blue,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'images/logo.png',
                ),
              ),
              const SizedBox(
                width: 24,
              ),
              const Text(
                'Help Desk Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getDashBoardBody() {
    final size = MediaQuery.of(context).size;
    final appState = Provider.of<AppState>(context);
    if (size.width <= 1024) {
      appState.adjustToSmallScreen();
      return Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: _buildAllChats(),
          ),
          if (appState.currentUserId != null && appState.currentUserId != '-1')
            SizedBox(
              height: size.height,
              width: size.width,
              child: _buildChatComponent(),
            )
        ],
      );
    }
    return Row(
      children: [
        SizedBox(
          height: size.height,
          width: size.width * 0.4,
          child: _buildAllChats(),
        ),
        const VerticalDivider(),
        Expanded(
          child: _buildChatComponent(),
        ),
      ],
    );
  }

  Widget _buildAllChats() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        top: 8,
        bottom: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(_searchController, 'Search'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatusTab(ChatStatus.all, 'All chats'),
              _buildStatusTab(ChatStatus.unassigned, 'Unassigned'),
              _buildStatusTab(ChatStatus.active, 'Active'),
              _buildStatusTab(ChatStatus.inactive, 'Inactive'),
              _buildStatusTab(ChatStatus.solved, 'Solved'),
            ],
          ),
          const Expanded(
            child: AllChats(),
          )
        ],
      ),
    );
  }

  Widget _buildChatComponent() {
    final size = MediaQuery.of(context).size;
    final appState = Provider.of<AppState>(context);

    return Container(
      padding: const EdgeInsets.only(
        right: 8,
        top: 8,
        bottom: 8,
      ),
      height: size.height,
      child: Stack(
        children: [
          const ChatComponent(),
          if (appState.showProfile) const ProfileComponent(),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Consumer<AppState>(
      builder: (_, appState, __) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            onChanged: (value) {
              appState.setPrefix(value);
            },
            decoration: InputDecoration(
              hintText: label,
              prefixIcon: const Icon(Icons.search_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        );
      },
    );
  }

  _buildStatusTab(ChatStatus curr, String label) {
    return Consumer<AppState>(
      builder: (_, appState, __) {
        return GestureDetector(
          onTap: () {
            if (appState.chatStatus == curr) return;
            appState.setChatStatus(curr);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: TextStyle(
                color:
                    (appState.chatStatus == curr) ? Colors.blue : Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
