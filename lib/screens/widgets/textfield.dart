import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool autofocus;
  final TextEditingController controller;
  final bool isEnabled;
  final TextInputAction actionKeyboard;
  final String hintText;
  // final FocusNode focusNode;
  // final Widget prefixIcon;
  // final String defaultText;
  // final bool obscureText;
  // final String parametersValidate;
  // final Function onSubmitField;
  // final Function onFieldTap;

  const TextFormFieldWidget(
      {required this.validator,
      this.keyboardType = TextInputType.text,
      this.autofocus = false,
      required this.controller,
      this.isEnabled = true,
      this.actionKeyboard = TextInputAction.next,
      // required this.focusNode,
      // required this.prefixIcon,
      // required this.focusNode,
      // required this.defaultText,
      // this.obscureText = false,
      // required this.parametersValidate,
      // required this.onSubmitField,
      // required this.onFieldTap,
      required this.hintText});

  @override
  _TextFormFieldWidgetState createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      autofocus: widget.autofocus,
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: Color(0xffC4C4C4)),
        ),
        fillColor: Color(0xffC4C4C4),
        filled: true,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        enabled: widget.isEnabled,
      ),
    );
  }
}

