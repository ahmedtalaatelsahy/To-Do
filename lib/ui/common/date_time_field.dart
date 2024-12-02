import 'package:flutter/material.dart';
import 'package:to_do_app/ui/common/material_text_form_field.dart';

class DateTimeField extends StatelessWidget {
  String title;
  String hint;
  bool readable;
  VoidCallback onClick;
  DateTimeField(
      {super.key,
      this.readable = false,
      required this.title,
      required this.hint,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontSize: 18, color: Colors.blue),
        ),
        MaterialTextFormField(
          readable: readable,
          onClick: onClick,
          hint: hint,
        )
      ],
    );
  }
}
