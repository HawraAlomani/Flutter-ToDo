import 'package:flutter/material.dart';
import 'package:mytodo_app/model/todo.dart';

class TaskData extends ChangeNotifier{
  List <Todo> tasks =[
    Todo(title: 'shopping today'),
    Todo(title: 'exercise'),
    Todo(title: 'study for the exam'),
  ];
  void addToList(String newTask){
    tasks.add(Todo(title: newTask));
    notifyListeners();
  }
}