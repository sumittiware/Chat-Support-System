import 'package:chat_app_task/models/chat.dart';
import 'package:chat_app_task/utils/enums.dart';
import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  String? _loggedInAgent;
  String? _loggedInAgentId;
  String? _currentUserId;
  String _prefix = '';
  Chat? _currentChat;

  ChatStatus _chatStatus = ChatStatus.all;
  bool _showProfile = false;
  bool _isSmallScreen = false;

  String? get loggedInAgent => _loggedInAgent;
  String? get loggedInAgentId => _loggedInAgentId;
  String? get currentUserId => _currentUserId;
  String get prefix => _prefix;
  ChatStatus get chatStatus => _chatStatus;
  bool get showProfile => _showProfile;
  bool get isSmallScreen => _isSmallScreen;
  Chat? get currentChat => _currentChat;

  void setAgent(String agent) {
    _loggedInAgent = agent;
    notifyListeners();
  }

  void setAgentId(String id) {
    _loggedInAgentId = id;
    notifyListeners();
  }

  void setCurrentUserId(String id) {
    _currentUserId = id;
    notifyListeners();
  }

  void setChatStatus(ChatStatus status) {
    _chatStatus = status;
    notifyListeners();
  }

  void setProfileView(bool val) {
    _showProfile = val;
    notifyListeners();
  }

  void popChatScreen() {
    _currentUserId = null;
    _currentChat = null;
    notifyListeners();
  }

  void adjustToSmallScreen() {
    _isSmallScreen = true;
    notifyListeners();
  }

  void setPrefix(String val) {
    _prefix = val;
    notifyListeners();
  }

  void setCurrentChat(Chat chat) {
    _currentChat = chat;
    notifyListeners();
  }

  void closeChat() {
    _currentChat!.isClosed = true;
    notifyListeners();
  }
}
