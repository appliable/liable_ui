import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:liable_ui/liable_ui.dart';
import 'package:liable_ui/src/textfields/TextInputFieldWidget.dart';
import 'package:liable_ui/src/textfields/utils/TextConstants.dart';

class ComponentFactory extends InheritedWidget {
  static ComponentFactory of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ComponentFactory>() as ComponentFactory;

  ComponentFactory({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  Widget createTextField(
      {Key? key,
      String? label,
      String? hint,
      required TextEditingController controller,
      required FocusNode focusNode,
      TextCapitalization? textCapitalization = TextCapitalization.sentences,
      TextInputType? textInputType = TextInputType.text,
      TextInputAction? textInputAction,
      List<TextFormFieldValidator> validators = TextConstants.NO_VALIDATORS,
      Widget? leadingIcon,
      Widget? trailingIcon,
      VoidCallback? onTrailingIconPressed,
      FocusNode? nextFocus,
      bool horizontallyExpanded = true,
      Function(String)? onFieldSubmitted,
      bool enabled = true,
      bool readOnly = false,
      List<TextInputFormatter> inputFormatters = TextConstants.formatters,
      int maxLines = 1,
      bool obscured = false,
      Function(String text)? onChange,
      bool autoFocus = false}) {
    return TextInputFieldWidget(
      label: 'label',
      hint: 'hint',
      focusNode: FocusNode(),
      controller: TextEditingController(),
      type: TextInputType.text,
      onChange: onChange,
      textInputAction: textInputAction,
      validators: validators,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      onTrailingIconPressed: onTrailingIconPressed,
      nextFocus: nextFocus,
      horizontallyExpanded: horizontallyExpanded,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      readOnly: readOnly,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      obscured: obscured,
      autoFocus: autoFocus,
    );
  }
}
