import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liable_ui/src/textfields/utils/TextConstants.dart';
import 'package:liable_ui/src/textfields/validators/TextFieldValidator.dart';

class TextInputFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? label;
  final String? hint;
  final TextCapitalization textCapitalization;
  final TextInputType type;
  final Function(String text)? onChange;
  final bool? autoCorrect;
  final int maxLines;
  final TextInputAction? textInputAction;
  final List<TextFormFieldValidator> validators;
  final bool horizontallyExpanded;
  final bool isPassword;
  final bool autoFocus;
  final Widget? trailingIcon;
  final VoidCallback? onTrailingIconPressed;
  final Widget? leadingIcon;
  final FocusNode? nextFocus;
  final Function(String)? onFieldSubmitted;
  final bool obscured;
  final bool readOnly;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;

  TextInputFieldWidget({
    Key? key,
    required this.label,
    required this.hint,
    this.textCapitalization = TextCapitalization.none,
    required this.focusNode,
    required this.controller,
    required this.type,
    this.onChange,
    this.autoCorrect, // iOS support is weak
    this.textInputAction,
    this.validators = TextConstants.NO_VALIDATORS,
    this.horizontallyExpanded = false,
    this.isPassword = false,
    this.trailingIcon,
    this.onTrailingIconPressed,
    this.leadingIcon,
    this.onFieldSubmitted,
    this.nextFocus,
    this.autoFocus = false,
    this.maxLines = 1,
    this.obscured = false,
    this.readOnly = false,
    this.inputFormatters = const [],
    this.enabled = true,
  }) : super(key: key);

  @override
  _TextInputFieldWidgetState createState() => _TextInputFieldWidgetState();
}

class _TextInputFieldWidgetState extends State<TextInputFieldWidget> {
  Color grey9c = Color(0xff9C9C9C);
  bool obscured = false;
  Widget? _trailingIcon;

  @override
  void initState() {
    obscured = widget.isPassword;
    _trailingIcon = widget.trailingIcon;
    if (!widget.isPassword) {
      widget.focusNode.addListener(_handleFocusChange);
    }
    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_handleFocusChange);
    super.dispose();
  }

  _handleFocusChange() {
    if (!widget.focusNode.hasFocus) {
      widget.controller.text = widget.controller.text.trimRight();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.horizontallyExpanded ? double.infinity : 240,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.label != null) _LabelText(widget.label),
          TextFormField(
            keyboardType: widget.type,
            inputFormatters: widget.inputFormatters,
            maxLines: widget.maxLines,
            autofocus: widget.autoFocus,
            onFieldSubmitted: (text) {
              if (widget.onFieldSubmitted != null) {
                widget.onFieldSubmitted!(text);
              } else if (widget.nextFocus != null) {
                _fieldFocusChange(context, widget.focusNode, widget.nextFocus!);
              }
            },
            textCapitalization: widget.textCapitalization,
            validator: (String? entry) {
              String? error;
              for (int i = 0; i <= widget.validators.length; i++) {
                final validator = widget.validators[i];
                if (!validator.isValid(entry)) {
                  error = validator.errorText;
                  break;
                }
              }
              if (widget.label != null) {
                setState(() {});
              }

              return error;
            },
            autocorrect: widget.autoCorrect ?? !Platform.isIOS,
            //TODO there is issue with iOS, disable until there is a solution
            controller: widget.controller,
            focusNode: widget.focusNode,
            textInputAction: widget.textInputAction ?? (widget.nextFocus != null ? TextInputAction.next : null),
            readOnly: widget.readOnly,
            onChanged: (String text) {
              if (widget.onChange != null) {
                widget.onChange!(text);
              }
            },
            decoration: InputDecoration(
              hintText: widget.hint == null ? '' : widget.hint,
              hintStyle: Theme.of(context).textTheme.bodyText2,
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(6)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey), borderRadius: BorderRadius.circular(6)),
              errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.red), borderRadius: BorderRadius.circular(6)),
              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.red), borderRadius: BorderRadius.circular(6)),
              suffixIcon: InkWell(
                onTap: widget.onTrailingIconPressed,
                child: _trailingIcon,
              ),
              prefixIcon: widget.leadingIcon,
            ),
            style: Theme.of(context).textTheme.bodyText1,
            obscureText: obscured,
            enabled: widget.enabled,
          ),
        ],
      ),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}

class _LabelText extends StatefulWidget {
  final String? _label;

  _LabelText(this._label);

  @override
  _LabelTextState createState() => _LabelTextState();
}

class _LabelTextState extends State<_LabelText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget._label ?? '', style: Theme.of(context).textTheme.bodyText1);
  }
}
