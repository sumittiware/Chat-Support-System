import 'package:chat_app_task/firebase/firebase_utils.dart';
import 'package:flutter/material.dart';

class MessegeInputField extends StatefulWidget {
  final String userId;
  final bool isAdmin;

  const MessegeInputField({
    super.key,
    required this.userId,
    required this.isAdmin,
  });

  @override
  State<MessegeInputField> createState() => _MessegeInputFieldState();
}

class _MessegeInputFieldState extends State<MessegeInputField> {
  final _newMessegeController = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool sending = false;

  Future<void> _sendMsg() async {
    if (_newMessegeController.text.trim().isEmpty) return;
    setState(() {
      sending = true;
    });
    await FirebaseUtils.sendMessege(
      _newMessegeController.text.trim(),
      widget.userId,
      widget.isAdmin,
    );

    if (widget.isAdmin) {
      await FirebaseUtils.setLastSeen(widget.userId);
    }

    _newMessegeController.clear();
    _focus.unfocus();

    setState(() {
      sending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: _buildTextField(
              _newMessegeController,
              'Start Typing...',
            ),
          ),
          FloatingActionButton(
            onPressed: _sendMsg,
            elevation: 0,
            child: (sending)
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Icon(
                    Icons.send_rounded,
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        focusNode: _focus,
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          hintText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      ),
    );
  }
}
