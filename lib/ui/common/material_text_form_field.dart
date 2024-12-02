import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/providers/theme_provider.dart';

typedef Validator = String? Function(String? text);

class MaterialTextFormField extends StatefulWidget {
  String hint;
  TextInputType keyboardType;
  Validator? validator;
  int lines;
  bool readable;
  VoidCallback? onClick;
  TextEditingController? controller;
  bool editable;
  MaterialTextFormField(
      {super.key,
      required this.hint,
      this.readable = false,
      this.keyboardType = TextInputType.text,
      this.validator,
      this.lines = 1,
      this.onClick,
      this.editable = true,
      this.controller});

  @override
  State<MaterialTextFormField> createState() => _MaterialTextFormFieldState();
}

class _MaterialTextFormFieldState extends State<MaterialTextFormField> {
  @override
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          onTap: () {
            widget.onClick?.call();
          },
          readOnly: widget.readable,
          enabled: widget.editable,
          enableInteractiveSelection: widget.editable,
          focusNode: FocusNode(),
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          style: themeProvider.isDarkEnabled()
              ? Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white)
              : Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 15, color: Colors.red),
            hintText: widget.hint,
            hintStyle: themeProvider.isDarkEnabled()
                ? Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white)
                : Theme.of(context).textTheme.bodyMedium,
          ),
          minLines: widget.lines,
          maxLines: widget.lines,
        )
      ],
    );
  }
}
