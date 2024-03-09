// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:untitled/home/settings/themBottomsheet.dart';
import '../../mytheme.dart';
import '../../provider/app_config_provider.dart';
import 'bottomsheet.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 25,
          ),
          Text(
            AppLocalizations.of(context)!.language,
            style: provider.isDark()
                ? Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: MyTheme.whiteColor)
                : Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              showLanguageBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: provider.isDark()
                      ? MyTheme.bottomColordark
                      : MyTheme.whiteColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appLanguage == 'en'
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                    style: provider.isDark()
                        ? Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: MyTheme.primaryColor)
                        : Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: MyTheme.primaryColor),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                    color: MyTheme.primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            AppLocalizations.of(context)!.theme,
            style: provider.isDark()
                ? Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: MyTheme.whiteColor)
                : Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              showThemBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: provider.isDark()
                      ? MyTheme.bottomColordark
                      : MyTheme.whiteColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.isDark()
                        ? AppLocalizations.of(context)!.dark
                        : AppLocalizations.of(context)!.light,
                    style: provider.isDark()
                        ? Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: MyTheme.primaryColor)
                        : Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: MyTheme.primaryColor),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                    color: MyTheme.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Bottomsheet(),
    );
  }

  void showThemBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemBottomsheet(),
    );
  }
}
