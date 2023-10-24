import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required this.label,
    required this.inputController,
  });

  final String label;
  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: label, labelText: label),
      controller: inputController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "{$label} inválido";
        }

        return null;
      },
    );
  }
}
