import 'package:flutter/material.dart';

void showMessageDialog(BuildContext context,
    {required String message,
      String? posButtonTitle,
      VoidCallback? posButtonAction,
      String? negButtonTitle,
      VoidCallback? negButtonAction,
      bool isCancelable =true}) {
  List<Widget> actions = [];
  if (posButtonTitle != null) {
    actions.add(
      TextButton(
          onPressed: () {
            Navigator.pop(context);
            posButtonAction?.call();
          },
          child: Text(posButtonTitle)),
    );
  }
  if (negButtonTitle != null) {
    actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          negButtonAction?.call();
        },
        child: Text(negButtonTitle)));
  }
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: actions,
        );
      },
      barrierDismissible: isCancelable
  );
}

void showLoadingDialog(BuildContext context,
    {required String message, bool isCancelable = true}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              width: 12,
            ),
            Text(message)
          ],
        ),
      );
    },
    barrierDismissible: isCancelable,
  );
}