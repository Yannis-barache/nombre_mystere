import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputNombre extends StatelessWidget {
  final TextEditingController controller;
  const InputNombre({Key? key,
   required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: '',
        labelStyle: MaterialStateTextStyle.resolveWith(
          (Set<MaterialState> states) {
            return TextStyle(color: Colors.black, letterSpacing: 1.3);
          },
        ),
      ),
      keyboardType: TextInputType.numberWithOptions(signed: true), // Allows negative numbers
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^-?[0-9]*')) // Allows digits and a leading negative sign
      ],
      autovalidateMode: AutovalidateMode.always,

    );
  }
}