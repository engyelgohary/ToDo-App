// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, non_constant_identifier_names, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/firebase_utils.dart';
import 'package:untitled/model/task.dart';
import 'package:untitled/provider/authprovider.dart';
import '../../mytheme.dart';
import '../../provider/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Add_Task extends StatefulWidget {
  static String routeName = 'Add task';

  @override
  State<Add_Task> createState() => _Add_TaskState();
}

class _Add_TaskState extends State<Add_Task> {
  String title = '';
  String des = '';
  var selecteddate = DateTime.now();
  var _FromKey = GlobalKey<FormState>();
  late AppConfigProvider provider;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: Text(
              AppLocalizations.of(context)!.add_new_task,
              style: provider.isDark()
                  ? Theme.of(context).textTheme.titleMedium
                  : Theme.of(context).textTheme.titleMedium,
            )),
            Form(
              key: _FromKey,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(fontSize: 15),
                    onChanged: (text) {
                      title = text;
                    },
                    validator: (text) {
                      if (text!.isEmpty) {
                        return 'Please enter your title';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText:  AppLocalizations.of(context)!.hintTitle,
                        hintStyle:  provider.isDark()
                  ? Theme.of(context).textTheme.titleMedium
                  : Theme.of(context).textTheme.titleMedium,),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 15),
                    onChanged: (text) {
                      des = text;
                    },
                    validator: (text) {
                      if (text!.isEmpty) {
                        return 'Please enter your description here';
                      }
                      return null;
                    },
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText:  AppLocalizations.of(context)!.hintDesc,
                      hintStyle:  provider.isDark()
                  ? Theme.of(context).textTheme.titleMedium
                  : Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              AppLocalizations.of(context)!.date,
              style: provider.isDark()
                  ? Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 20, color: MyTheme.whiteColor)
                  : Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 20),
            ),
            SizedBox(
              height: 40,
            ),
            Center(
                child: InkWell(
              onTap: () {
                showCalender();
              },
              child: Text(
                DateFormat.yMMMd().format(selecteddate),
                style: provider.isDark()
                    ? Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: MyTheme.whiteColor)
                    : Theme.of(context).textTheme.titleSmall,
              ),
            )),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: Text(AppLocalizations.of(context)!.add,
                    style: provider.isDark()
                        ? Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: MyTheme.whiteColor)
                        : Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: MyTheme.whiteColor)))
          ],
        ),
      ),
    );
  }

  showCalender() async {
    var date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 600)),
        initialDate: DateTime.now());
    if (date != null) {
      selecteddate = date;
    }
    setState(() {});
  }

  void addTask() {
    var userprovider = Provider.of<AuthUsers>(context, listen: false);

    if (_FromKey.currentState!.validate() == true) {
      Task task = Task(title: title, description: des, time: selecteddate);
      Firebaseutils.addTaskToFireStore(task, userprovider.currentUser!.id!)
          .then((value) => {
                Navigator.pop(context),
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Task Added Successfully.'),
                  ),
                ),
              });
    }
  }
}
