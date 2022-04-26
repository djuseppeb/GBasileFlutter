import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final TextEditingController controller;
  final bool hidden;
  final String fieldName;
  const LoginField({Key? key, required this.controller, required this.fieldName, this.hidden = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hidden,
      controller: controller,
      validator: (value){
        if(value == null || value.isEmpty){
          return 'Campo obbligatorio';
        }
        return null;
      },
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.black87),
        errorStyle: const TextStyle(color: Colors.black87),
        hintText: fieldName,

      ),
    );
  }
}
