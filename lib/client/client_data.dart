import 'dart:math';

import 'package:chat_app_task/client/client_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ClientDataScreen extends StatefulWidget {
  const ClientDataScreen({super.key});

  @override
  State<ClientDataScreen> createState() => _ClientDataScreenState();
}

class _ClientDataScreenState extends State<ClientDataScreen> {
  final Set<int> availUsers = <int>{};

  @override
  void initState() {
    fetchUsers();
    super.initState();
  }

  fetchUsers() async {
    final rawData = await rootBundle.loadString("assets/files/data.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);

    for (int i = 1; i < listData.length; i++) {
      availUsers.add(listData[i][0]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Interntional"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Select any of the available User Ids',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  final value = availUsers.toList()[index];

                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) {
                            return ClientChatScreen(
                              userId: value.toString(),
                            );
                          },
                        ),
                      );
                    },
                    title: Text('User : $value'),
                  );
                }),
                itemCount: availUsers.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          int newValue = Random().nextInt(10000);
          while (availUsers.contains(newValue)) {
            newValue = Random().nextInt(10000);
          }
          await FirebaseFirestore.instance
              .collection('support')
              .doc(newValue.toString())
              .set({
            'userId': newValue.toString(),
          });
          Future.delayed(const Duration(seconds: 0), () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return ClientChatScreen(
                    userId: newValue.toString(),
                  );
                },
              ),
            );
          });
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
