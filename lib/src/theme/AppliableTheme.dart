
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppliableTheme extends InheritedWidget {
  static AppliableTheme of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppliableTheme>() as AppliableTheme;

  AppliableTheme({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  /// icon used on password field when password is hidden. Click on this icon will lead to showing password
  Widget passwordTrailingIconShow() => Icon(Icons.remove_red_eye_outlined);

  /// icon used on password field when password is shown. Click on this icon will lead to hide password
  Widget passwordTrailingIconHide() => Icon(Icons.remove_red_eye);

}