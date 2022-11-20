import 'package:flutter/material.dart';
import 'package:flutter_todolist_firebase/utils/style.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.3,
      child: Checkbox(
        side: const BorderSide(
          color: primaryColor,
          width: 1.5,
        ),
        value: value,
        onChanged: onChanged,
        checkColor: Colors.white,
        activeColor: primaryColor,
        focusColor: errorColor,
        hoverColor: warningColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
