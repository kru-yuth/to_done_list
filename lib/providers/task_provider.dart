import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_done_list/models/task.dart';

class TaskProvider with ChangeNotifier {
  late Box<Task> _tasksBox;

  TaskProvider() {
    _initHive();
  }

  Future<void> _initHive() async {
    _tasksBox = await Hive.openBox<Task>('tasks');
    notifyListeners();
  }

  List<Task> get tasks => _tasksBox.values.toList();

  void addTask(Task task) {
    _tasksBox.add(task);
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasksBox.deleteAt(index);
    notifyListeners();
  }

  void editTask(int index, Task newTask) {
    _tasksBox.putAt(index, newTask); // อัปเดตข้อมูลใน Hive
    notifyListeners(); // แจ้งให้ UI อัปเดต
  }

  int get totalScore => tasks.fold(0, (sum, task) => sum + task.difficulty);
}