import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalTasks = 0;
  int completedTasks = 0;
  int pendingTasks = 0;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Toplam Görev: $totalTasks',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Tamamlanan Görev: $completedTasks',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Bekleyen Görev: $pendingTasks',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Bekleyen Görevler:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Buraya ListView ekleyerek bekleyen son 3 görevi listeleyebilirsiniz.
            // Örneğin:
             ListView.builder(
               itemCount: 3,
               itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Görev $index'),
                subtitle: Text('Görev açıklaması $index'),
                 );
              },
             ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // Burada index'e göre ilgili sayfaya geçiş yapabilirsiniz.
          // Örneğin:
           if (index == 0) {
             Navigator.pushReplacementNamed(context, '/');
           } else if (index == 1) {
             Navigator.pushReplacementNamed(context, '/new_task');
           } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/all_tasks');
           }
        },
      ),
    );
  }
}
