import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/firebase_utils.dart';
import 'package:untitled/model/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;
  List<Task> taskList = [];
  DateTime selectedDate = DateTime.now();

  Future<void> changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', appLanguage);

    notifyListeners();
  }

  Future<void> changeTheme(ThemeMode newTheme) async {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ThemeMode', appTheme.name);
    notifyListeners();
  }

  Future<void> loadSettings() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mode = prefs.getString('ThemeMode');
    String? language = prefs.getString('language');
    mode ??= 'light';
    appTheme = (mode == 'dark' ? ThemeMode.dark : ThemeMode.light);
    language ??= 'en';
    appLanguage = language;
  }

  bool isDark() {
    return appTheme == ThemeMode.dark;
  }

  void getAllTasksfromfirestore(String uid) async {
    // get all tasks
    QuerySnapshot<Task> query =
        await Firebaseutils.getTaskCollection(uid).get();
    taskList = query.docs.map(
      (doc) {
        return doc.data();
      },
    ).toList();
// fillert tasks
    taskList = taskList.where(
      (task) {
        if (selectedDate.day == task.time?.day &&
            selectedDate.month == task.time?.month &&
            selectedDate.year == task.time?.year) {
          return true;
        }
        return false;
      },
    ).toList();
    // sort tasks
    taskList.sort(
      (task1, task2) {
        return task1.time!.compareTo(task2.time!);
      },
    );
    notifyListeners();
  }

  void changeDate(DateTime newSelectDate, String uid) {
    selectedDate = newSelectDate;
    getAllTasksfromfirestore(uid);
  }
}
