// ignore_for_file: camel_case_types, must_be_immutable, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:untitled/firebase_utils.dart';
import 'package:untitled/home/task_list/edit_task_list.dart';
import 'package:untitled/model/task.dart';
import 'package:untitled/provider/authprovider.dart';
import '../../mytheme.dart';
import '../../provider/app_config_provider.dart';
import 'package:page_transition/page_transition.dart';

class Task_item extends StatelessWidget {
  Task task;
  Task_item({required this.task});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var userprovider = Provider.of<AuthUsers>(context);

    return Container(
      margin: EdgeInsets.all(15),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .4,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(20),
              onPressed: (context) {
                Firebaseutils.deleteTask(task, userprovider.currentUser!.id!)
                    .then((value) => {
                          provider.getAllTasksfromfirestore(
                              userprovider.currentUser!.id!)
                        });
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(20),
              onPressed: (context) {
                Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: Edit_task(taskmodel: task),
                    ),
                );
              },
              backgroundColor: MyTheme.primaryColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: provider.isDark()
                ? MyTheme.bottomColordark
                : MyTheme.whiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height * .11,
                color: MyTheme.primaryColor,
                width: 4,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title ?? "",
                    style: provider.isDark()
                        ? Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: MyTheme.primaryColor)
                        : Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: MyTheme.primaryColor),
                  ),
                  Text(
                    task.description ?? "",
                    style: provider.isDark()
                        ? Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 15, color: MyTheme.grayColor)
                        : Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 15),
                  ),
                ],
              )),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.symmetric(horizontal: 9),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:
                      task.isDone! ? MyTheme.greenColor : MyTheme.primaryColor,
                ),
                child: task.isDone!
                    ? Center(
                        child: Text(
                          'Done !',
                          style: TextStyle(
                            color: MyTheme.whiteColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.check,
                          color: MyTheme.whiteColor,
                          size: 30,
                        ),
                        onPressed: () {
                          bool newIsDoneStatus = !task.isDone!;
                          Firebaseutils.updateTaskDoneStatus(
                                  task,
                                  newIsDoneStatus,
                                  userprovider.currentUser!.id!)
                              .then((value) {
                            provider.getAllTasksfromfirestore(
                                userprovider.currentUser!.id!);
                          });
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
