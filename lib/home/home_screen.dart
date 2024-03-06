// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/authentaction/login/login_screen.dart';
import 'package:untitled/home/settings/settingstab.dart';
import 'package:untitled/home/task_list/add_task_list.dart';
import 'package:untitled/provider/app_config_provider.dart';
import '../mytheme.dart';
import '../provider/authprovider.dart';
import 'task_list/tasklisttab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "Home_Screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int select = 0;

  @override
  Widget build(BuildContext context) {
    var userprovider = Provider.of<AuthUsers>(context);
    var provider = Provider.of<AppConfigProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
            "${AppLocalizations.of(context)!.title} \n ${userprovider.currentUser!.name!}"),
        toolbarHeight: MediaQuery.of(context).size.height * .23,
        actions: [
          IconButton(
              onPressed: () {
                provider.taskList = [];
                userprovider.currentUser = null;
                Navigator.pushReplacementNamed(context, Login.routeName);
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: SingleChildScrollView(
          child: BottomNavigationBar(
            currentIndex: select,
            onTap: (value) {
              select = value;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    size: 30,
                  ),
                  label: AppLocalizations.of(context)!.tasklist),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    size: 30,
                  ),
                  label: AppLocalizations.of(context)!.setting),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
            side: BorderSide(
          color: MyTheme.whiteColor,
          width: 6,
        )),
        backgroundColor: MyTheme.primaryColor,
        child: Icon(
          Icons.add,
          color: MyTheme.whiteColor,
          size: 30,
        ),
        onPressed: () {
          showAddBottomSheet();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: select == 0 ? TaskList() : Settings(),
    );
  }

  void showAddBottomSheet() {
    showModalBottomSheet(context: context, builder: (context) => Add_Task());
  }
}
