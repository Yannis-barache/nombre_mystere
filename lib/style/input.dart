import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputNombre extends StatelessWidget {
  const InputNombre({Key? key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      validator: (String? value) {
        // If the value is not a number, return an error message
        if (value != null && double.tryParse(value) == null) {
          return 'The input must be a number';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.always,
    );
    // 
  }
}