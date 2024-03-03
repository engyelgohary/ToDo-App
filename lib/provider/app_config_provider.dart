import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/firebase_utils.dart';
import 'package:untitled/model/task.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;
  List<Task> taskList = [];
  DateTime selectedDate = DateTime.now();

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners();
  }

  bool isDark() {
    return appTheme == ThemeMode.dark;
  }

  void getAllTasksfromfirestore () async{
    // get all tasks
   QuerySnapshot<Task> query = await Firebaseutils.getTaskCollection().get();
 taskList = query.docs.map((doc) {
    return doc.data();
  },).toList();
// fillert tasks
  taskList = taskList.where((task) {
    if(selectedDate.day == task.time?.day
     && selectedDate.month == task.time?.month 
     && selectedDate.year == task.time?.year
    ){
      return true;
    }
    return false;
  },).toList();
  // sort tasks
  taskList.sort((task1, task2) {
   return task1.time!.compareTo(task2.time!);
  },);
 notifyListeners(); 
}
void changeDate(DateTime newSelectDate){
    selectedDate = newSelectDate;
    getAllTasksfromfirestore();
}
}