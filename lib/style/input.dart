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
        labelText: 'Entrer votre nombre',
        // The MaterialStateProperty's value is a text style that is orange
        // by default, but the theme's error color if the input decorator
        // is in its error state.
        labelStyle: MaterialStateTextStyle.resolveWith(
          (Set<MaterialState> states) {
            final Color color = states.contains(MaterialState.error)
                ? Theme.of(context).colorScheme.error
                : Colors.orange;
            return TextStyle(color: color, letterSpacing: 1.3);
          },
        ),
      ),
      keyboardType: TextInputType.number, // Only allows numeric input
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly // Only allows digits
      ],
      autovalidateMode: AutovalidateMode.always,
    );
    // 
  }
}