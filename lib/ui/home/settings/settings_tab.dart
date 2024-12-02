import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/language_provider.dart';
import 'package:to_do_app/providers/theme_provider.dart';
import 'package:to_do_app/ui/home/settings/show_language_modal_sheet.dart';
import 'package:to_do_app/ui/home/settings/show_theme_modal_sheet.dart';
import 'package:to_do_app/ui/style/theme.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    LanguageProvider languageProvider=Provider.of<LanguageProvider>(context);

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Language',
            style: TextStyle(
                color:
                    themeProvider.isDarkEnabled() ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              showLanguageModalBottomSheet(
                context,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: themeProvider.isDarkEnabled()
                    ? MyTheme.darkBottomNav
                    : Colors.white,
                border: Border.all(color: MyTheme.lightSecondary),
              ),
              height: 48,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    " ${languageProvider.getCurrentLanguage(context)}",
                    style: const TextStyle(color: MyTheme.lightSecondary),
                  ),
                  const Icon(Icons.expand_more_rounded)
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            'Mode',
            style: TextStyle(
                color:
                    themeProvider.isDarkEnabled() ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              showThemeModalBottomSheet(
                context,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: themeProvider.isDarkEnabled()
                    ? MyTheme.darkBottomNav
                    : Colors.white,
                border: Border.all(color: MyTheme.lightSecondary),
              ),
              height: 48,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    " ${themeProvider.getCurrentTheme(context)}",
                    style: const TextStyle(color: MyTheme.lightSecondary),
                  ),
                  const Icon(Icons.expand_more_rounded)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showThemeModalBottomSheet(
    BuildContext context,
  ) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      backgroundColor:
          themeProvider.isDarkEnabled() ? MyTheme.darkBottomNav : Colors.white,
      builder: (context) {
        return ShowThemeModalSheet(
          text1: 'Light',
          text2: 'dark',
        );
      },
    );
  }

  showLanguageModalBottomSheet(
    BuildContext context,
  ) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    showModalBottomSheet(
      backgroundColor:
          themeProvider.isDarkEnabled() ? MyTheme.darkBottomNav : Colors.white,
      context: context,
      builder: (context) {
        return ShowLanguageModalSheet(
          text1: 'English',
          text2: "العربية",
        );
      },
    );
  }
}
