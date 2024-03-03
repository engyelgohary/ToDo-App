import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:untitled/home/task_list/task_item.dart';
import '../../mytheme.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {},
          activeColor: MyTheme.primaryColor,
          dayProps: EasyDayProps(
            todayHighlightStyle: TodayHighlightStyle.withBackground,
            todayHighlightColor: MyTheme.whiteColor,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Task_item();
            },
            itemCount: 30,
          ),
        )
      ],
    );
  }
}
