import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persist_type/commons/constants.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key,
    required this.label,
    required this.inputController,
    this.icon,
    this.textInputType,
    this.inputFormatters,
    this.autoFocus,
    this.focusNode,
    this.onTap,
    this.border,
  });

  final String label;
  final TextEditingController inputController;
  final Icon? icon;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? autoFocus;
  final FocusNode? focusNode;
  final Function()? onTap;
  final OutlineInputBorder? border;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(decorationStyle: TextDecorationStyle.solid);

    return TextFormField(
      autofocus: autoFocus ?? false,
      focusNode: focusNode,
      keyboardType: textInputType ?? TextInputType.text,
      inputFormatters: inputFormatters,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: label,
        labelText: label,
        labelStyle: textStyle,
        icon: icon ?? iconText,
        border: border,
      ),
      controller: inputController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "O campo $label é obrigatório";
        }

        return null;
      },
      onTap: onTap,
    );
  }
}
