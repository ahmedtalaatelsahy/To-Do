import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/theme_provider.dart';

class ShowThemeModalSheet extends StatefulWidget {
  final String text1;
  final String text2;

  ShowThemeModalSheet({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  State<ShowThemeModalSheet> createState() => _ShowThemeModalSheetState();
}

class _ShowThemeModalSheetState extends State<ShowThemeModalSheet> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
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
              themeProvider.changeTheme(ThemeMode.light); // or dark
              Navigator.pop(context); // Close the modal sheet
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
              themeProvider.changeTheme(ThemeMode.dark); // or light
              Navigator.pop(context);
            }, // Assign the function directly
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