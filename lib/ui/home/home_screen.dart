import 'package:flutter/material.dart';
import 'package:to_do_app/ui/home/settings/settings_tab.dart';

import 'list/tasks_list_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [TasksListTab(), SettingsTab()];
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '   To Do List',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        elevation: 0,
        child: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                currentTabIndex = index;
              });
            },
            currentIndex: currentTabIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: '')
            ]),
      ),
      body: tabs[currentTabIndex],
    );
  }
}