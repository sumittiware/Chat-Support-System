import 'package:chat_app_task/admin/admin_dashboard.dart';
import 'package:chat_app_task/app/app_state.dart';
import 'package:chat_app_task/firebase/firebase_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_usernameController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      return;
    }
    setState(() {
      _loading = true;
    });
    final appState = Provider.of<AppState>(context, listen: false);
    final agentId = await FirebaseUtils.loginAgent(
      _usernameController.text.trim(),
      _passwordController.text.trim(),
    );
    if (agentId == null) {
      return;
    }

    appState.setAgentId(agentId);
    appState.setAgent(_usernameController.text.trim());

    Future.delayed(
      const Duration(seconds: 0),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return const AdminDashBoard();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int width = MediaQuery.of(context).size.width.toInt();

    if (width > 500) {
      width = 500;
    }
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: (width.ceilToDouble() - 100),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'images/logo.png',
                  height: 50,
                  fit: BoxFit.fitHeight,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Login to Help Desk'),
              const SizedBox(
                height: 8,
              ),
              _buildTextField(
                _usernameController,
                'Username',
                Icons.account_circle_rounded,
                false,
              ),
              _buildTextField(
                _passwordController,
                'Password',
                Icons.lock_rounded,
                true,
              ),
              const SizedBox(height: 8),
              _buildButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData iconsData,
    bool isPassword,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(iconsData),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 60,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: _submit,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          side: const BorderSide(color: Colors.blue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.blue,
        ),
        child: (_loading)
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
