// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/mytheme.dart';

class CustomTextFormField extends StatelessWidget{
  String labelText ;
  TextInputType keyboardType;
  TextEditingController controller;
  String? Function(String?) validator;
  bool obscuretext;
  CustomTextFormField({required this.labelText,this.keyboardType = TextInputType.text,required this.controller,required this.validator,this.obscuretext = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: TextStyle(fontSize: 15),
        decoration: InputDecoration(
          label: Text(labelText,style: TextStyle(fontSize: 15),),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: MyTheme.primaryColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: MyTheme.primaryColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            width: 2,
            color: MyTheme.redColor
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            width: 2,
            color: MyTheme.redColor
          ),
        ),
        ),
        keyboardType: keyboardType,
        controller:controller ,
        validator:validator ,
        obscureText:obscuretext ,
      ),
    );
  }

}