import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/dataBase/model/task.dart';
import 'package:to_do_app/date_utils.dart';
import 'package:to_do_app/firebase/firebase_auth.dart';
import 'package:to_do_app/ui/style/theme.dart';

typedef OnDeleteClick = void Function(Task task);

class TaskItem extends StatelessWidget {
  OnDeleteClick onDeleteClick;
  TaskItem({super.key, required this.task, required this.onDeleteClick});
  Task task;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane:
          ActionPane(motion: const BehindMotion(), extentRatio: 0.3, children: [
        SlidableAction(
          onPressed: (_) {
            showMessageDialog(context,
                message: 'are you sure to delete task',
                posButtonTitle: 'cancel',
                posButtonAction: () {},
                negButtonTitle: 'delete', negButtonAction: () {
              onDeleteClick(task);
            });
          },
          icon: Icons.delete,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          label: "delete",
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15), topLeft: Radius.circular(15)),
        )
      ]),
      child: Card(
        child: SizedBox(
          height: 115,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyTheme.lightSecondary,
                ),
                width: 4,
                height: 62,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 23,
                  ),
                  Text(
                    "${task.title}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.watch_later_outlined),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${task.time?.formatTime()}",
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  )
                ],
              ),
              Container(
                width: 69,
                height: 34,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyTheme.lightSecondary,
                ),
                child: Image.asset("assets/images/Icon awesome-check.png"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
