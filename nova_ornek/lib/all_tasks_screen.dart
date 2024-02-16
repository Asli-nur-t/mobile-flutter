import 'package:flutter/material.dart';
import 'bottom_navigation.dart';
import 'package:http/http.dart' as http;

class AllTasksScreen extends StatelessWidget {
  final List<Map<String, dynamic>> todoList;

  AllTasksScreen({required this.todoList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tüm Görevler'),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          final todo = todoList[index];
          return ListTile(
            title: Text(todo['title']),
            subtitle: Text(todo['description']),
          );
        },
      ),
    );
  }
}