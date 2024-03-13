// ignore_for_file: prefer_const_constructors, camel_case_types, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled/firebase_utils.dart';
import 'package:untitled/model/task.dart';
import 'package:untitled/mytheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:untitled/provider/app_config_provider.dart';
import 'package:untitled/provider/authprovider.dart';

class Edit_task extends StatefulWidget {
  static String routeName = 'Edit task';
  final Task taskmodel;
  const Edit_task({required this.taskmodel});

  @override
  State<Edit_task> createState() => _Edit_taskState();
}

class _Edit_taskState extends State<Edit_task> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.taskmodel.title!;
    descriptionController.text = widget.taskmodel.description!;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var userprovider = Provider.of<AuthUsers>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .23,
        title: Text(AppLocalizations.of(context)!.title),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                controller: titleController,
                onChanged: (value) {
                  widget.taskmodel.title = value;
                },
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
                height: 20,
              ),
              TextFormField(
                controller: descriptionController,
                onChanged: (value) {
                  widget.taskmodel.description = value;
                },
                maxLines: 4,
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
                  widget.taskmodel.time= date;
                }
                setState(() {});
              },
              child: Text(
                DateFormat.yMMMd().format(widget.taskmodel.time!),
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
              Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        await Firebaseutils.updateTask(
                            widget.taskmodel, userprovider.currentUser!.id!);
                        if (mounted) {
                          Navigator.pop(context);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                           AppLocalizations.of(context)!.save,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: MyTheme.whiteColor),
                        ),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
