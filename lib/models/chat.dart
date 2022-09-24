import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String id;
  Timestamp lastseen;
  String agent;
  String agentId;
  bool isClosed;

  Chat({
    required this.id,
    required this.lastseen,
    required this.agent,
    required this.agentId,
    required this.isClosed,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lastSeen': lastseen,
      'agent': agent,
      'closed': isClosed,
      'agentId': agentId,
    };
  }

  static Chat fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return Chat(
      id: json.id,
      lastseen: json.data()['lastseen'] ?? Timestamp(0, 0),
      agent: json.data()['agent'] ?? 'unassigned',
      isClosed: json.data()['closed'] ?? false,
      agentId: json.data()['agentId'] ?? '-1',
    );
  }
}
