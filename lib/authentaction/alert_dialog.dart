// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/mytheme.dart';

class DialogUlits {
  static void showLoading(
      {required BuildContext context, required String message}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(
                backgroundColor: MyTheme.primaryColor,
              ),
              SizedBox(
                width: 10,
              ),
              Text(message,style: TextStyle(fontSize: 15),),
            ],
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(
      {required BuildContext context, required String message, String? title,String?posAction,Function?posFunction,String?negAction,Function?negFunction}) {
    List<Widget> actions = [];
    if(posAction != null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        if(posFunction != null){
        posFunction.call();
        }
      }, child: Text(posAction)));
    }
    if(negAction != null){
      actions.add(TextButton(onPressed: (){
        if(negFunction != null){
        negFunction.call();
        }
        Navigator.pop(context);
      }, child: Text(negAction)));
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message,style: TextStyle(fontSize: 15),),
          title: Text(title ?? "",style: TextStyle(color: MyTheme.primaryColor),),
          actions: actions,
        );
      },
    );
  }
}
