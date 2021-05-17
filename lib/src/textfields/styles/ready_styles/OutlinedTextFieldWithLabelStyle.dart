import 'package:flutter/material.dart';

import '../TextFieldStyle.dart';

class OutlinedTextFieldWithLableStyle extends TextFieldStyle {
  OutlinedTextFieldWithLableStyle({
    required TextStyle? labelStyle,
    required TextStyle? textStyle, // default would be theme.textTheme.subtitle1
    required TextStyle? hintStyle,
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    Color borderColor = Colors.grey,
    Color errorBorderColor = Colors.red,
    suffixIcon,
    prefixIcon,
  }) : super(
            InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              enabledBorder: _defaultBorder(borderColor),
              focusedBorder: _defaultBorder(borderColor),
              errorBorder: _defaultBorder(errorBorderColor),
              focusedErrorBorder: _defaultBorder(errorBorderColor),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
            ),
            textStyle);

  static OutlineInputBorder _defaultBorder(Color borderColor) =>
      OutlineInputBorder(borderSide: BorderSide(width: 1, color: borderColor), borderRadius: BorderRadius.circular(6));
}
