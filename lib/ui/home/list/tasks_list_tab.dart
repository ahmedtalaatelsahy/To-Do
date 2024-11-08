import 'package:flutter/material.dart';
import 'package:to_do_app/ui/home/list/task_item.dart';

class TasksListTab extends StatelessWidget {
  const TasksListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => TaskItem(),
      separatorBuilder: (_, __) => Container(
        height: 20,
      ),
      itemCount: 3,
      padding: EdgeInsets.only(left: 20),
    );
  }
}
