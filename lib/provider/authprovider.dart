import 'package:flutter/material.dart';
import 'package:untitled/model/task.dart';
import 'package:untitled/model/user.dart';

class AuthUsers extends ChangeNotifier {
  MyUser? currentUser;
  Task? task;

  void updateUsers(MyUser? newUser) {
    if (currentUser != newUser) {
      currentUser = newUser;
      notifyListeners();
    }
  }

   void updateTasks(Task? newTask) {
    if (task != newTask) {
      task = newTask;
      notifyListeners();
    }
  }
}
