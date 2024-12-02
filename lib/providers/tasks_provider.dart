import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/dataBase/collection/task_collection.dart';
import 'package:to_do_app/dataBase/model/task.dart';
import 'package:to_do_app/date_utils.dart';

class TasksProvider extends ChangeNotifier {
  TaskCollection taskCollection = TaskCollection();
  Future<List<Task>> getAllTasks(String userId, DateTime selectedDate) async {
    var tasksList =
        await taskCollection.getAllTasks(userId, selectedDate.dateOnly());
    return tasksList;
  }

  Future<void> addTask(String userId, Task task) async {
    await taskCollection.createTask(userId, task);
    notifyListeners();
    return;
  }

  Future<void> removeTask(String userId, Task task) async {
    await taskCollection.removeTask(userId, task);
    notifyListeners();
    return;
  }

  static TasksProvider getInstance(BuildContext context, {bool listen = true}) {
    return Provider.of<TasksProvider>(context, listen: listen);
  }
}
