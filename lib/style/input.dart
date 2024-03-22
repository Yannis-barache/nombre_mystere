
import 'package:flutter/material.dart';
import 'package:nombre_mystere/style/input.dart';
class InputNombre extends StatelessWidget {
  const InputNombre({super.key});

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
      validator: (String? value) {
        // Si la veleur est un nombre, on retourne null
        if (value != null && double.tryParse(value) != null) {
          return 'The name must be a string';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.always,
    );
  }
}
