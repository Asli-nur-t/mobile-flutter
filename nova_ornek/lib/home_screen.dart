import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nova_ornek/todo_service.dart';
import 'package:nova_ornek/add_page.dart';
import 'package:nova_ornek/snackbar_helpers.dart';
import 'package:nova_ornek/todo_card.dart';
import 'package:nova_ornek/bottom_navigation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isloading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Todo List'),
      ),
      body: Visibility(
        visible: isloading,
        child: Center(
          child: CircularProgressIndicator(),
        ),
        replacement: _currentIndex == 0
            ? RefreshIndicator(
          onRefresh: fetchTodo,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Ekranın üst kısmı
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Toplam Görev: ${items.length}'),
                    Text(
                        'Tamamlanan Görev: ${items.where((item) => item['completed'] == true).length}'),
                    Text(
                        'Bekleyen Görev: ${items.where((item) => item['completed'] == false).length}'),
                  ],
                ),
              ),

              // Bekleyen Görevler Listesi
              Text(
                'Bekleyen Görevler:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length > 3 ? 3 : items.length,
                  itemBuilder: (context, index) {
                    final item = items[index] as Map;
                    return ListTile(
                      title: Text(
                        item['title'] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        item['description'] ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
            : Container(), // Diğer sekmelerde içerik yok
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) async {
          setState(() {
            _currentIndex = index;
          });

          // navbar geçişi
          if (_currentIndex == 1) {
            // Navigator.push(...
            // Yeni Görev ekranına geçiş yapabilirsiniz.
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Yeni Görev',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tüm Görevler',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        icon: Icon(Icons.add),
        label: Text('Add Todo'),
      ),
    );



  }




  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    await Navigator.push(context, route);
    setState(() {
      isloading = true;
    });
    fetchTodo();
  }





  Future<void> fetchTodo() async {
    final response = await TodoService.fetchTodos();
    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      return showErrorSnackBar(context, message: 'something went wrong');
    }
    setState(() {
      isloading = false;
    });
  }
}




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



