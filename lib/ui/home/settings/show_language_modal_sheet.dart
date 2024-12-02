import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/language_provider.dart';
import 'package:to_do_app/providers/theme_provider.dart';

class ShowLanguageModalSheet extends StatefulWidget {
  final String text1;
  final String text2;

  ShowLanguageModalSheet({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  State<ShowLanguageModalSheet> createState() => _ShowLanguageModalSheetState();
}

class _ShowLanguageModalSheetState extends State<ShowLanguageModalSheet> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              languageProvider.changeLanguage('English');
              Navigator.pop(context);
            }, // Assign the function directly
            child: Row(
              children: [
                Text(
                  widget.text1,
                  style: TextStyle(
                    color: themeProvider.isDarkEnabled()
                        ? Colors.white
                        : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          InkWell(
            onTap: () {
              languageProvider.changeLanguage('العربية');
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Text(
                  widget.text2,
                  style: TextStyle(
                    color: themeProvider.isDarkEnabled()
                        ? Colors.white
                        : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
