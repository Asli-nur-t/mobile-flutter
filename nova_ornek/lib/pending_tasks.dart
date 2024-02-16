import 'package:flutter/material.dart';
import 'package:nova_ornek/todo_service.dart';
import 'package:nova_ornek/add_page.dart';
import 'package:nova_ornek/snackbar_helpers.dart';
import 'package:nova_ornek/todo_card.dart';
import 'package:nova_ornek/bottom_navigation.dart';
import 'package:nova_ornek/home_screen.dart';
class TodoListPage extends StatefulWidget {
  const TodoListPage({
    super.key,
  });

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
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
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                return TodoCard(
                    index: index,
                    item: item,
                    navigateEdit: navigateToEditPage,
                    deleteById: deleteById);
              }),
        ),
      ),

      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) async {
          setState(() {
            _currentIndex = index;
          });

          // Navbar geçişi
          if (_currentIndex == 1) {
            // The "Add Todo" tab is selected
            navigateToAddPage();
          }else if(_currentIndex == 2) {
            navigateToTodoHomePage();
          }else{
            navigateToTodoListPage();
          }

        },
      ),

     /* floatingActionButton: FloatingActionButton.extended(
          onPressed: navigateToAddPage,
          icon: Icon(Icons.add),
          label: Text('Add Todo')),*/
    );
  }

  Future<void> navigateToEditPage(Map item) async {
    final route =
    MaterialPageRoute(builder: (context) => AddTodoPage(todo: item));
    await Navigator.push(context, route);
    setState(() {
      isloading = true;
    });
    fetchTodo();
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(builder: (context) => AddTodoPage());
    await Navigator.push(context, route);
    setState(() {
      isloading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(String id) async {
    //delete the item
    final isSuccess = await TodoService.deleteById(id);
    if (isSuccess) {
      //Remove item from the todo list
      final filtered = items
          .where(
            (element) => element['_id'] != id,
      )
          .toList();
      setState(() {
        items = filtered;
      });
    } else {
      //show error
      showErrorSnackBar(context, message: 'Deletion failed');
    }
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

  void navigateToTodoHomePage() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  void navigateToTodoListPage() async {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TodoListPage()),
      );

  }
}

