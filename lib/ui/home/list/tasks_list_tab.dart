import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/dataBase/model/task.dart';
import 'package:to_do_app/date_utils.dart';
import 'package:to_do_app/firebase/firebase_auth.dart';
import 'package:to_do_app/providers/auth_provider.dart';
import 'package:to_do_app/providers/tasks_provider.dart';
import 'package:to_do_app/providers/theme_provider.dart';
import 'package:to_do_app/ui/home/list/task_item.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class TasksListTab extends StatefulWidget {
  const TasksListTab({super.key});

  @override
  State<TasksListTab> createState() => _TasksListTabState();
}

class _TasksListTabState extends State<TasksListTab> {
  List<Task>? tasksList;
  late AppAuthProvider provider;
  late TasksProvider tasksProvider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<AppAuthProvider>(context, listen: false);
  }

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    tasksProvider = TasksProvider.getInstance(context, listen: true);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        EasyDateTimeLine(
          activeColor: Colors.indigo,
          initialDate: DateTime.now(),
          onDateChange: (date) {
            setState(() {
              selectedDate = date;
            });
          },
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
          stream: tasksProvider.taskCollection.listenForTask(
              provider.authUser?.uid ?? '', selectedDate.dateOnly()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  children: [
                    const Text("Something went wrong"),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: const Text("Try again"))
                  ],
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            tasksList = snapshot.data?.docs.map((doc) => doc.data()).toList();
            return ListView.separated(
                itemBuilder: (context, index) {
                  return TaskItem(
                    task: tasksList![index],
                    onDeleteClick: (task) {
                      deleteTask(task);
                    },
                  );
                },
                separatorBuilder: (_, __) {
                  return Container(
                    height: 20,
                  );
                },
                padding: const EdgeInsets.only(left: 20),
                itemCount: tasksList?.length ?? 0);
          },
        )),
      ],
    );
  }

  void deleteTask(Task task) async {
    showLoadingDialog(context, message: "please waite...");
    try {
      await tasksProvider.removeTask(provider.authUser?.uid ?? '', task);
      Navigator.pop(context);
      setState(() {});
    } catch (e) {
      showMessageDialog(context,
          message: "something went wrong",
          posButtonTitle: "try again", posButtonAction: () {
        deleteTask(task);
      });
    }
  }
}

/*
FutureBuilder<List<Task>>(
            future: tasksProvider.getAllTasks(provider.authUser?.uid ?? '',selectedDate),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  children: [
                    const Text("Error fetching tasks"),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {});
                        },
                        child: const Text("try again"))
                  ],
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              tasksList = snapshot.data;
              return ListView.separated(
                  itemBuilder: (context, index) => TaskItem(
                        task: tasksList![index],
                        onDeleteClick: deleteTask,
                      ),
                  separatorBuilder: (_, __) => Container(
                        height: 20,
                      ),
                  padding: const EdgeInsets.only(left: 20),
                  itemCount: tasksList?.length ?? 0);
            },
          ),
 */
