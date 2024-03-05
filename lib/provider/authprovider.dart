import 'package:flutter/material.dart';
import 'package:untitled/model/user.dart';

class AuthUsers extends ChangeNotifier{
  MyUser? currentUser;

  void updateUsers (MyUser? newUser){
    if(currentUser != newUser){
      currentUser = newUser;
      notifyListeners();
    }

  }
}