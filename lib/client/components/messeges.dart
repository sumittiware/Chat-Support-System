import 'package:chat_app_task/models/messege.dart';
import 'package:chat_app_task/utils/date_utli.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllMesseges extends StatefulWidget {
  final String userId;

  const AllMesseges({
    super.key,
    required this.userId,
  });

  @override
  State<AllMesseges> createState() => _AllMessegesState();
}

class _AllMessegesState extends State<AllMesseges> {
  final List<Messege> _messeges = [];
  final _controller = ScrollController(
    keepScrollOffset: true,
  );
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('support')
          .doc(widget.userId)
          .collection('chats')
          .orderBy(
            'timestamp',
          )
          .snapshots(),
      builder: (context, snapshots) {
        if (snapshots.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return _buildMessegeBody(snapshots);
      },
    );
  }

  Widget _buildMessegeBody(var snapshots) {
    final fetchedData = snapshots.data!.docs;
    _messeges.clear();
    _messeges.add(firstMessage);
    for (var ele in fetchedData) {
      _messeges.add(Messege.fromJson(ele));
    }

    return ListView.builder(
      controller: _controller,
      itemBuilder: ((context, index) {
        final curr = _messeges[index];
        bool isAdmin = (curr.userId == '-1');
        return Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isAdmin ? Colors.blue : Colors.grey.shade300,
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(16),
              bottomRight: const Radius.circular(16),
              topLeft: Radius.circular(isAdmin ? 4 : 16),
              topRight: Radius.circular(isAdmin ? 16 : 4),
            ),
          ),
          child: Column(
            crossAxisAlignment:
                (isAdmin) ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Text(
                curr.content,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                getFormatedDate(curr.timestamp),
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
      }),
      itemCount: _messeges.length,
    );
  }
}
