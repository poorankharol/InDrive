import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.textInputType,
    required this.validator,
    required this.textInputAction,
  });

  final TextEditingController controller;
  final String labelText;
  final TextInputType textInputType;
  final String? Function(String?) validator;
  final TextInputAction textInputAction;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      decoration: InputDecoration(
          isDense: true,
          labelText: widget.labelText,
          suffixIcon: widget.textInputType == TextInputType.visiblePassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null),
      validator: widget.validator,
      keyboardType: widget.textInputType,
      textInputAction: widget.textInputAction,
      obscureText: widget.textInputType == TextInputType.visiblePassword
          ? !_passwordVisible
          : false,
    );
  }
}
