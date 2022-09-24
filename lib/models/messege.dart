import 'package:cloud_firestore/cloud_firestore.dart';

class Messege {
  String id;
  String content;
  Timestamp timestamp;
  String userId;

  Messege({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.userId,
  });

  static Messege fromJson(QueryDocumentSnapshot<Map<String, dynamic>> json) {
    return Messege(
      id: json.id,
      content: json['content'] ?? '',
      timestamp: json['timestamp'] ?? Timestamp(0, 0),
      userId: json['userId'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'timestamp': timestamp,
      'userId': userId,
    };
  }
}

final firstMessage = Messege(
  id: '-1',
  content:
      'Welcome to the Braanch International help desk, Please provide your query.',
  timestamp: Timestamp(0, 0),
  userId: '-1',
);
