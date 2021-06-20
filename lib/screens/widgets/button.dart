import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final Function()? onPressed;
  final String text;

  const ButtonWidget({required this.onPressed, required this.text});

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 18.0,
            ),
          )),
      style: ElevatedButton.styleFrom(
        primary: Color(0xff282B24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
    );
  }
}
