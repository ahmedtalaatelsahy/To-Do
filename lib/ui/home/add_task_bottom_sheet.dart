import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/dataBase/model/task.dart';
import 'package:to_do_app/date_utils.dart';
import 'package:to_do_app/firebase/firebase_auth.dart';
import 'package:to_do_app/providers/auth_provider.dart';
import 'package:to_do_app/providers/tasks_provider.dart';
import 'package:to_do_app/providers/theme_provider.dart';
import 'package:to_do_app/ui/common/date_time_field.dart';
import 'package:to_do_app/ui/common/material_text_form_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 18,
            ),
            Text(
              'Add new Task',
              style: themeProvider.isDarkEnabled()
                  ? Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.white)
                  : Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.black),
            ),
            MaterialTextFormField(
              hint: 'Task title',
              controller: titleController,
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return 'Task title is required';
                }
                return null;
              },
            ),
            MaterialTextFormField(
                hint: 'Task description',
                lines: 2,
                controller: descriptionController,
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'Task description is required';
                  }
                  return null;
                }),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                    child: DateTimeField(
                  readable: true,
                  title: 'Task date',
                  hint: selectedDate == null
                      ? 'select date'
                      : '${selectedDate?.formatDate()}',
                  onClick: () {
                    showDatePickerDialog();
                  },
                )),
                Expanded(
                    child: DateTimeField(
                  readable: true,
                  title: 'Task time',
                  hint: selectedTime == null
                      ? 'select time'
                      : '  ${selectedTime?.formatTime()}',
                  onClick: () {
                    showTimePickerDialog();
                  },
                ))
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  addTask();
                },
                child: const Text("Add Task")),
          ],
        ),
      ),
    );
  }

  DateTime? selectedDate;

  void showDatePickerDialog() async {
    var date = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (date == null) return;

    setState(() {
      selectedDate = date;
    });
  }

  TimeOfDay? selectedTime;

  void showTimePickerDialog() async {
    var time = await showTimePicker(
        context: context, initialTime: selectedTime ?? TimeOfDay.now());
    if (time == null) return;

    setState(() {
      selectedTime = time;
    });
  }

  bool isValidTask() {
    bool isValid = true;
    if (formKey.currentState?.validate() == false) {
      isValid = false;
    }

    if (selectedDate == null) {
      showMessageDialog(context,
          message: "please select date of task", posButtonTitle: 'ok');
      isValid = false;
    }
    if (selectedTime == null) {
      showMessageDialog(context,
          message: "please select time of task", posButtonTitle: 'ok');
      isValid = false;
    }
    return isValid;
  }

  void addTask() async {
    if (isValidTask() == false) return;
    AppAuthProvider provider =
        Provider.of<AppAuthProvider>(context, listen: false);

    TasksProvider tasksProvider =
        TasksProvider.getInstance(context, listen: false);
    Task task = Task(
        title: titleController.text,
        description: descriptionController.text,
        date: selectedDate?.dateOnly(),
        time: selectedTime?.timeOnly());
    try {
      showLoadingDialog(context, message: 'adding task pls wait');
      var result =
          await tasksProvider.addTask(provider.appUser?.authId ?? '', task);
      Navigator.pop(context);
      showMessageDialog(
        context,
        message: 'task added successfully',
        posButtonTitle: 'ok',
        posButtonAction: () {
          Navigator.pop(context);
        },
      );
    } catch (e) {
      Navigator.pop(context);
      showMessageDialog(context, message: e.toString(), posButtonTitle: 'ok');
    }
  }
}
