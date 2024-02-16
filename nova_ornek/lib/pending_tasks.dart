import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PendingTasksScreen extends StatefulWidget {
  @override
  _PendingTasksScreenState createState() => _PendingTasksScreenState();
}

class _PendingTasksScreenState extends State<PendingTasksScreen> {
  List<Map<String, dynamic>> pendingTasks = [];

  @override
  void initState() {
    super.initState();
    fetchPendingTasks();
  }

  Future<void> fetchPendingTasks() async {
    final response = await http.get('http://api.nstack.in/pending_tasks');

    if (response.statusCode == 200) {
      setState(() {
        pendingTasks = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      // Handle error
      print('Failed to load pending tasks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bekleyen Görevler'),
      ),
      body: ListView.builder(
        itemCount: pendingTasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              pendingTasks[index]['title'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(pendingTasks[index]['description']),
            onTap: () {
              // Burada tıklanan görevin detaylarına geçmek için bir işlem yapabilirsiniz.
              // Örneğin: Navigator.pushNamed(context, '/task_details', arguments: pendingTasks[index]);
            },
          );
        },
      ),
    );
  }
}
