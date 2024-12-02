import 'package:flutter/material.dart';

typedef Validator = String? Function(String? text);

class AppFormField extends StatefulWidget {
  String title;
  TextInputAction textInputAction;
  String hint;
  TextInputType keyboardType;
  bool isPasswordSecure;
  Validator? validator;
  TextEditingController? controller;
  VoidCallback? onClick;
  bool editable;
  AppFormField(
      {super.key,
      this.editable = true,
      required this.title,
      required this.hint,
      this.keyboardType = TextInputType.text,
      this.isPasswordSecure = false,
      this.validator,
      this.textInputAction = TextInputAction.next,
      this.controller});

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  bool isVisible = true;
  @override
  void initState() {
    super.initState();
    isVisible = widget.isPasswordSecure;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          onTap: () {
            widget.onClick?.call();
          },

          enableInteractiveSelection: widget.editable,
          focusNode: FocusNode(),
          controller: widget.controller,
          validator: widget.validator,
          obscureText: isVisible,
          keyboardType: widget.keyboardType,
          style: Theme.of(context).textTheme.bodyMedium,
          decoration: InputDecoration(
              errorStyle: const TextStyle(fontSize: 15, color: Colors.red),
              suffixIcon: widget.isPasswordSecure
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: Icon(isVisible
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined))
                  : null,
              hintText: widget.hint,
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              filled: true,
              fillColor: Colors.white,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        )
      ],
    );
  }
}
