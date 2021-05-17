import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liable_ui/liable_ui.dart';
import 'package:liable_ui/src/textfields/utils/TextConstants.dart';
import 'package:liable_ui/src/textfields/validators/PasswordFieldValidator.dart';

enum PasswordFieldType {
  // REGISTRATION,
  // LOGIN,
  // WRITE_OLD_PASSWORD,
  // WRITE_NEW_PASSWORD,
  // CONFIRM_NEW_PASSWORD,
  REGISTRATION_OR_SET_NEW_PASSWORD, // during registration and new password, field validations needs to apply
  LOGIN_OR_OLD_PASSWORD // during registration and new password, field validations do not apply because we are not creating a new one
}

class PasswordTextInputFieldWidget extends StatefulWidget {
  final PasswordFieldValidator passwordFieldValidator;
  final String label;
  final String? hint;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Widget? leadingIcon;
  final FocusNode? nextFocus;
  final Function(String)? onFieldSubmitted;
  final PasswordFieldType passwordFieldType;
  final bool enabled;
  final bool autofocus;

  PasswordTextInputFieldWidget(
      {Key? key,
      required this.passwordFieldValidator,
      required this.passwordFieldType,
      this.label = 'Password',
      this.hint,
      required this.controller,
      required this.focusNode,
      required this.textInputAction,
      this.leadingIcon,
      this.nextFocus,
      this.enabled = true,
      this.autofocus = false,
      this.onFieldSubmitted})
      : super(key: key);

  PasswordTextInputFieldWidget.loginOrWriteOldPassword({
    required this.controller,
    required this.focusNode,
    required this.label,
    this.hint,
    required this.textInputAction,
    this.leadingIcon,
    this.nextFocus,
    this.enabled = true,
    this.autofocus = false,
    this.onFieldSubmitted,
  })  : passwordFieldValidator = PasswordFieldValidator.none(),
        passwordFieldType = PasswordFieldType.REGISTRATION_OR_SET_NEW_PASSWORD;

  PasswordTextInputFieldWidget.registrationOrWriteNewPassword(
      {required this.passwordFieldValidator,
      required this.controller,
      required this.focusNode,
      required this.label,
      this.hint,
      required this.textInputAction,
      this.leadingIcon,
      this.nextFocus,
      this.enabled = true,
      this.autofocus = false,
      this.onFieldSubmitted})
      : passwordFieldType = PasswordFieldType.REGISTRATION_OR_SET_NEW_PASSWORD;

  @override
  State<StatefulWidget> createState() => _PasswordTextInputFieldWidgetState();
}

class _PasswordTextInputFieldWidgetState extends State<PasswordTextInputFieldWidget> {
  bool showingPassword = false;

  @override
  Widget build(BuildContext context) {
    return ComponentFactory.of(context).createTextField(
      label: widget.label,
      hint: widget.hint,
      textCapitalization: TextCapitalization.none,
      focusNode: widget.focusNode,
      controller: widget.controller,
      textInputType: TextInputType.text,
      textInputAction: widget.textInputAction,
      validators: widget.passwordFieldValidator.validators,
      horizontallyExpanded: true,
      trailingIcon: showingPassword ? AppliableTheme.of(context).passwordTrailingIconHide() : AppliableTheme.of(context).passwordTrailingIconShow(),
      onTrailingIconPressed: () {
        setState(() {
          showingPassword = !showingPassword;
        });
      },
      leadingIcon: widget.leadingIcon,
      onFieldSubmitted: widget.onFieldSubmitted,
      nextFocus: widget.nextFocus,
      autoFocus: widget.autofocus,
      maxLines: 1,
      readOnly: false,
      inputFormatters: TextConstants.formatters,
      enabled: widget.enabled,
    );
  }
}
