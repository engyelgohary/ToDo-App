// ignore_for_file: use_key_in_widget_constructors

import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/home/task_list/task_item.dart';
import 'package:untitled/provider/app_config_provider.dart';
import 'package:untitled/provider/authprovider.dart';
import '../../mytheme.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var userprovider = Provider.of<AuthUsers>(context);

    provider.getAllTasksfromfirestore(userprovider.currentUser!.id!);

    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: provider.selectedDate,
          onDateChange: (selectedDate) {
            provider.changeDate(selectedDate, userprovider.currentUser!.id!);
          },
          activeColor: MyTheme.primaryColor,
          dayProps: EasyDayProps(
            todayHighlightStyle: TodayHighlightStyle.withBackground,
            todayHighlightColor: MyTheme.whiteColor,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Task_item(
                task: provider.taskList[index],
              );
            },
            itemCount: provider.taskList.length,
          ),
        )
      ],
    );
  }
}
