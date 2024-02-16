
import 'dart:convert';

import 'package:flutter/material.dart';
import 'bottom_navigation.dart';
import 'package:http/http.dart' as http;
class TodoService {
  static const apiUrl = "https://api.nstack.in/v1/todos";
  List<Map<String, dynamic>> todoList = [];

  Future<void> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);

        if (data != null) {
          if (data is List) {
            todoList = List<Map<String, dynamic>>.from(data);
          } else if (data is Map) {
            if (data['todos'] != null) {
              todoList = List<Map<String, dynamic>>.from(data['todos']);
            } else {
              throw Exception('Invalid response format, missing "todos" key');
            }
          } else {
            throw Exception('Invalid response format');
          }
        } else {
          throw Exception('Received null data in response');
        }
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      throw Exception('Failed to fetch todos: $e');
    }
  }


  Future<void> addTodo(Map<String, dynamic> todoData) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(todoData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add todo');
    }
  }

  Future<void> updateTodo(int id, Map<String, dynamic> todoData) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      body: jsonEncode(todoData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodo(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete todo');
    }
  }
}
