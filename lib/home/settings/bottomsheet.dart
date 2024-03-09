// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../mytheme.dart';
import '../../provider/app_config_provider.dart';

class Bottomsheet extends StatefulWidget {
  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color:
              provider.isDark() ? MyTheme.bottomColordark : MyTheme.whiteColor,
          borderRadius: BorderRadius.circular(30)),
      height: MediaQuery.of(context).size.height * .2,
      padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () async {
                await provider.changeLanguage("en");
                },
                child: provider.appLanguage == ('en')
                    ? selectedlanguage(AppLocalizations.of(context)!.english)
                    : unselectedlanguage(AppLocalizations.of(context)!.english)),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: MyTheme.grayColor,
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () async {
                 await provider.changeLanguage("ar");
                },
                child: provider.appLanguage == ('ar')
                    ? selectedlanguage(AppLocalizations.of(context)!.arabic)
                    : unselectedlanguage(AppLocalizations.of(context)!.arabic))
          ],
        ),
      ),
    );
  }

  Widget selectedlanguage(String text) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: provider.isDark()
              ? Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: MyTheme.whiteColor, fontWeight: FontWeight.bold)
              : Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: MyTheme.primaryColor, fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.check,
          color: provider.isDark() ? MyTheme.whiteColor : MyTheme.primaryColor,
          size: 30,
        )
      ],
    );
  }

  Widget unselectedlanguage(String text) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Text(
      text,
      style: provider.isDark()
          ? Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: MyTheme.primaryColor)
          : Theme.of(context).textTheme.titleSmall,
    );
  }
}
