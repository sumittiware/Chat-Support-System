import 'package:chat_app_task/admin/admin_dashboard.dart';
import 'package:chat_app_task/app/app_state.dart';
import 'package:chat_app_task/auth/login.dart';
import 'package:chat_app_task/client/client_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    Firebase.initializeApp(
      options: (kIsWeb)
          ? const FirebaseOptions(
              apiKey: 'AIzaSyCDsydDHrX70IRo1mOvsXEacWZLpuMASzY',
              appId: '1:695229070023:web:9feaa2b75ac472d14ddce2',
              messagingSenderId: '695229070023',
              projectId: 'letstalk-4bd39',
            )
          : null,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    if (!kIsWeb) {
      return const ClientDataScreen();
    } else {
      if (appState.loggedInAgent == null) {
        return const LoginScreen();
      }
      return const AdminDashBoard();
    }
  }
}
