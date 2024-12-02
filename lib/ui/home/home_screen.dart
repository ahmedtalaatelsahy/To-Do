import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/auth_provider.dart';
import 'package:to_do_app/providers/theme_provider.dart';
import 'package:to_do_app/ui/home/settings/settings_tab.dart';
import 'package:to_do_app/ui/login/login_screen.dart';
import 'package:to_do_app/ui/style/theme.dart';

import 'add_task_bottom_sheet.dart';
import 'list/tasks_list_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [const TasksListTab(), SettingsTab()];
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    var authProvider = Provider.of<AppAuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '   To Do List',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          InkWell(
              onTap: () {
                authProvider.logout();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: const Icon(Icons.logout_rounded)),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        color: themeProvider.isDarkEnabled()
            ? MyTheme.darkBottomNav
            : Colors.white,
        shape: const CircularNotchedRectangle(),
        elevation: 0,
        child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                currentTabIndex = index;
              });
            },
            currentIndex: currentTabIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: '')
            ]),
      ),
      body: tabs[currentTabIndex],
    );
  }

  void showAddTaskBottomSheet() {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    showModalBottomSheet(
        context: context,
        backgroundColor: themeProvider.isDarkEnabled()
            ? MyTheme.darkBottomNav
            : Colors.white,
        builder: (
          BuildContext context,
        ) {
          return const AddTaskBottomSheet();
        });
  }
}
