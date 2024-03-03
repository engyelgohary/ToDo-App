import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/model/task.dart';

import '../../mytheme.dart';
import '../../provider/app_config_provider.dart';


class Task_item extends StatelessWidget {
  Task task ;
  Task_item({required this.task});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: provider.isDark() ? MyTheme.bottomColordark : MyTheme.whiteColor,
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
              color: MyTheme.primaryColor,
            ),
            child: IconButton(
              icon: Icon(
                Icons.check,
                color: MyTheme.whiteColor,
                size: 30,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
