import 'package:flutter/material.dart';

class LogField extends StatelessWidget {
  final TextEditingController controller;
  final String fieldText;
  final String fieldHint;
  final IconData fieldIcon;
  final bool hidden;
  const LogField({Key? key, required this.controller, required this.fieldText, required this.fieldHint, required this.fieldIcon, this.hidden = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        obscureText: hidden,
        controller: controller,
        decoration:  InputDecoration(
            icon: Icon(
              fieldIcon,
              color: Colors.blueAccent,
            ),
            labelStyle: const TextStyle(color: Colors.black87),
            errorStyle: const TextStyle(color: Colors.redAccent),
            labelText: fieldText,
            hintText: fieldHint,
            border: const OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(32)),
                borderSide: BorderSide(
                  color: Colors.black26,
                  width: 1,
                )),
            focusedBorder: const OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(32)),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 3,
                )),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
                borderRadius:
                BorderRadius.all(Radius.circular(32)),
                borderSide: BorderSide(
                    color: Colors.redAccent, width: 3))),
      ),
    );
  }
}
