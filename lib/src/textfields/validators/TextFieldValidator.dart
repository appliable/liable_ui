typedef OnErrorFunction<T> = T Function(T value);

abstract class TextFieldValidator<T> {
  /// the errorText to display when the validation fails
  final String? errorText;
  final OnErrorFunction? onErrorFunction;

  TextFieldValidator(this.errorText, {this.onErrorFunction});

  /// checks the input against the given conditions
  bool isValid(T? value);

  /// call is a special function that makes a class callable
  /// returns null if the input is valid otherwise it returns the provided error errorText
  String? call(T value) {
    return isValid(value) ? null : errorText;
  }
}

abstract class TextFormFieldValidator extends TextFieldValidator<String> {
  TextFormFieldValidator(String? errorText, {OnErrorFunction? onErrorFunction}) : super(errorText, onErrorFunction: onErrorFunction);

  // return false if you want the validator to return error
  // message when the value is empty.
  bool get ignoreEmptyValues => true;

  @override
  String? call(String value) {
    return (ignoreEmptyValues && value.isEmpty) ? null : super.call(value);
  }

  /// helper function to check if an input matches a given pattern
  bool hasMatch(String pattern, String input) => RegExp(pattern).hasMatch(input);
}

/// Validates min length of a String
class MinLengthValidator extends TextFormFieldValidator {
  final int? minLength;

  MinLengthValidator({required this.minLength, String? errorText, OnErrorFunction? onErrorFunction}) : super(errorText, onErrorFunction: onErrorFunction);

  @override
  bool isValid(String? value) {
    if (value == null) return false;
    if (minLength == null) return true;

    bool isMinLength = value.length >= minLength!;

    return isMinLength;
  }
}

/// Validates max length of a String
class MaxLengthValidator extends TextFormFieldValidator {
  final int? maxLength;

  MaxLengthValidator({required this.maxLength, String? errorText, OnErrorFunction? onErrorFunction}) : super(errorText, onErrorFunction: onErrorFunction);

  @override
  bool isValid(String? value) {
    if (value == null) return false;
    if (maxLength == null) return true;

    bool isMaxLength = value.length <= maxLength!;

    return isMaxLength;
  }
}

/// Validates lower and upper case in a String
class UpperLowerCaseValidator extends TextFormFieldValidator {
  final bool? validateUpperLowerCase;

  UpperLowerCaseValidator({this.validateUpperLowerCase, String? errorText, OnErrorFunction? onErrorFunction})
      : super(errorText, onErrorFunction: onErrorFunction);

  @override
  bool isValid(String? value) {
    if (value == null) return false;
    if (validateUpperLowerCase != true) return true;

    bool hasUppercase = value.contains(new RegExp(r'[A-Z]'));
    bool hasLowercase = value.contains(new RegExp(r'[a-z]'));

    return hasLowercase && hasUppercase;
  }
}

/// Validates lower and upper case in a String
class SpecialCharacterValidator extends TextFormFieldValidator {
  final bool? validateSpecialCharacter;

  SpecialCharacterValidator({this.validateSpecialCharacter, String? errorText, OnErrorFunction? onErrorFunction})
      : super(errorText, onErrorFunction: onErrorFunction);

  @override
  bool isValid(String? value) {
    if (value == null) return false;
    if (validateSpecialCharacter != true) return true;

    bool hasSpecialCharacter = value.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return hasSpecialCharacter;
  }
}

/// Validates digit character in a String
class DigitCharacterValidator extends TextFormFieldValidator {
  final bool? validateDigit;
  DigitCharacterValidator({this.validateDigit, String? errorText, OnErrorFunction? onErrorFunction}) : super(errorText, onErrorFunction: onErrorFunction);

  @override
  bool isValid(String? value) {
    if (value == null) return false;
    if (validateDigit != true) return true;

    bool hasSpecialCharacter = value.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return hasSpecialCharacter;
  }
}