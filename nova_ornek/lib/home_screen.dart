import 'dart:convert';
/*
import 'package:flutter/material.dart';
import 'bottom_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:nova_ornek/all_tasks_screen.dart';
import 'package:nova_ornek/todo_service.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // TodoService sınıfını bir değişken olarak ekleyin
  TodoService _todoService = TodoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(hintText: 'Description'),
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 8,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitData,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) async{
          setState(() {
            _currentIndex = index;
          });

          // navbar geçişi
          if (_currentIndex == 2) {
            await _fetchTodoList(); // Fetch todo list before navigating
            print(_fetchTodoList());
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllTasksScreen(todoList: _todoService.todoList)),
            );

          }
        },
      ),
    );
  }

  Future<void> submitData() async {
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false,
    };

    final url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      // Eğer başarıyla eklenirse, ekledikten sonra todo listesini güncelle
      await _fetchTodoList();
      print("Todo added successfully");
    } else {
      print("Failed to add todo. Response: ${response.statusCode}");
    }

    // Ekledikten sonra text alanlarını temizle
    titleController.clear();
    descriptionController.clear();
  }

  Future<void> _fetchTodoList() async {
    try {
      // Todo listesini güncelle
      await _todoService.fetchTodos();
      // setState ile liste güncellenecek ve ekran yenilenecek
      setState(() {});
    } catch (e) {
      print("Error fetching todo list: $e");
    }
  }

}*/



