import 'package:flutter/material.dart';
import 'package:untitled/home/settings/settingstab.dart';
import 'package:untitled/home/task_list/add_task_list.dart';
import '../mytheme.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title),
        toolbarHeight: MediaQuery.of(context).size.height * .23,
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
