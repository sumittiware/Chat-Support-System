import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class FirebaseUtils {
  static Future<void> setAgentToChat(
    String userId,
    String agentId,
    String agentName,
  ) async {
    await FirebaseFirestore.instance.collection('support').doc(userId).update({
      'agentId': agentId,
      'agent': agentName,
    });
  }

  static Future<void> setLastSeen(String userId) async {
    await FirebaseFirestore.instance.collection('support').doc(userId).update(
      {
        'lastseen': Timestamp.now(),
      },
    );
  }

  static Future<void> sendMessege(
    String content,
    String userId,
    bool isAdmin,
  ) async {
    await FirebaseFirestore.instance
        .collection('support')
        .doc(userId)
        .collection('chats')
        .add(
      {
        'content': content,
        'timestamp': Timestamp.now(),
        'userId': isAdmin ? '-1' : userId,
      },
    );
  }

  static Future<String?> loginAgent(String username, String password) async {
    try {
      final fetchedData =
          await FirebaseFirestore.instance.collection('agents').get();

      final data = fetchedData.docs;
      for (var element in data) {
        final userName = element.data()['agentname'];
        final passWord = element.data()['password'];
        if (userName == username && passWord == password) {
          return element.id;
        }
      }
    } catch (_) {
      print(_.toString());
      return null;
    }

    return null;
  }

  static Future<void> closeChat(String userId) async {
    await FirebaseFirestore.instance.collection('support').doc(userId).update(
      {
        'closed': true,
      },
    );
  }

  static Future<void> uploadCSVtoFirebase() async {
    try {
      final rawData = await rootBundle.loadString("files/data.csv");
      List<List<dynamic>> listData =
          const CsvToListConverter().convert(rawData);
      int n = listData.length;
      for (int i = 1; i < n; i++) {
        final data = listData[i];

        int id = data[0];
        String timestamp = data[1];
        String content = data[2];
        List<String> temp = timestamp.split(' ');
        List<String> date = temp[0].split('-');
        List<String> time = temp[1].split(':');

        DateTime newDate = DateTime(
          int.parse(date[0]),
          int.parse(date[1]),
          int.parse(date[2]),
          int.parse(time[0]),
          int.parse(time[1]),
          int.parse(time[2]),
        );

        await FirebaseFirestore.instance
            .collection('support')
            .doc(id.toString())
            .set({
          'userId': id.toString(),
        });
        await FirebaseFirestore.instance
            .collection('support')
            .doc(id.toString())
            .collection('chats')
            .add({
          'content': content,
          'timestamp': Timestamp.fromDate(newDate),
          'userId': id.toString(),
        });

        print('added : $i');
      }

      print('Done!!');
    } catch (_) {
      print(_.toString());
    }
  }
}
