import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/firebase_utils.dart';
import 'package:untitled/home/task_list/add_task_list.dart';
import 'package:untitled/model/task.dart';
import 'package:untitled/mytheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:untitled/provider/app_config_provider.dart';

class Edit_task extends StatefulWidget {
  static String routeName = 'Edit task';

  @override
  State<Edit_task> createState() => _Edit_taskState();
}

class _Edit_taskState extends State<Edit_task> {
   String title = '';
   String des = '';
   late TextEditingController _titleController;
   late TextEditingController _descriptionController;
   late Task args;
  
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Task args = ModalRoute.of(context)?.settings.arguments as Task;
    var provider = Provider.of<AppConfigProvider>(context);
      _titleController.text = args.title!;
    _descriptionController.text = args.description!;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .23,
        title: Text(AppLocalizations.of(context)!.title),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: provider.isDark()
                ? MyTheme.bottomColordark
                : MyTheme.whiteColor,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              AppLocalizations.of(context)!.title_task,
              style: provider.isDark()
                  ? Theme.of(context).textTheme.titleMedium
                  : Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 10,
            ),
                 TextFormField(
                style: TextStyle(fontSize: 15),
                controller: _titleController,
                onChanged: (text) {
                  setState(() {
                    title = text;
                  });
                },
                enabled: true,
              ),
            SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.des,
              style: provider.isDark()
                  ? Theme.of(context).textTheme.titleMedium
                  : Theme.of(context).textTheme.titleMedium,
            ),
       
            SizedBox(
              height: 10,
            ),
           TextFormField(
                style: TextStyle(fontSize: 15),
                controller: _descriptionController,
                onChanged: (text) {
                  setState(() {
                    des = text;
                  });
                },
                maxLines: 4,
                enabled: true,
              ),
            SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.date,
              style: provider.isDark()
                  ? Theme.of(context).textTheme.titleMedium
                  : Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: InkWell(
              onTap: () async {
                var date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 600)),
                    initialDate: DateTime.now());
                if (date != null) {
                  args.time = date;
                }
                setState(() {});
              },
              child: Text(
                DateFormat.yMMMd().format(args.time as DateTime),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                       _updateTask(args);
                    },
                    child: Text(AppLocalizations.of(context)!.save,
                        style: provider.isDark()
                            ? Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.whiteColor)
                            : Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.whiteColor))),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(AppLocalizations.of(context)!.back,
                        style: provider.isDark()
                            ? Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.whiteColor)
                            : Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.whiteColor))),
              ],
            ),
          ]),
        ),
      ),
    );
  }
   void _updateTask(Task task) {
    task.title = _titleController.text;
    task.description = _descriptionController.text;
    Firebaseutils.updateTask(task)
        .then((_) {
      Navigator.of(context).pop();
    });
  }
}
