import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/ui/style/theme.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane:
          ActionPane(motion: BehindMotion(), extentRatio: 0.3, children: [
        SlidableAction(
          onPressed: (_) {},
          icon: Icons.delete,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          label: "delete",
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15), topLeft: Radius.circular(15)),
        )
      ]),
      child: Card(
        child: Container(
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
                  SizedBox(
                    height: 23,
                  ),
                  Text(
                    "play basket ball",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(Icons.watch_later_outlined),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "time",
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
