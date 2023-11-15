import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';

const todoListKey = 'todo_list';

class TodoRepository {

  // TodoRepository() {
  //   SharedPreferences.getInstance().then((value) {
  //     sharedPreferences = value;
  //     debugPrint(sharedPreferences.getString('todo_list'));
  //   });
  // }

  late SharedPreferences sharedPreferences;

  Future<List<Todo>> getTodoList() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(todoListKey) ?? '[]';
    final jsonDecoded = jsonDecode(jsonString) as List;
    return jsonDecoded.map((e) => Todo.fromJson(e)).toList();
  }

  void saveTodoList(List<Todo> todos) {
    final jsonString = jsonEncode(todos);
    sharedPreferences.setString('todo_list', jsonString);
  }

}