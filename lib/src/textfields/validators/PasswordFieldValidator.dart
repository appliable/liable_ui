import '../../../liable_ui.dart';
import 'TextFieldValidator.dart';

// todo consider adding description
class PasswordFieldValidator {
  final MinLengthValidator _minLengthValidator;
  final MaxLengthValidator _maxLengthValidator;
  final UpperLowerCaseValidator _upperLowerCaseValidator;
  final DigitCharacterValidator _digitCharacterValidator;
  final SpecialCharacterValidator _specialCharacterValidator;

  /// The simplest validator. Fine for prototype / wireframes
  /// Set showLoremIpsum attribute if real or localized texts are expected to be provided later
  PasswordFieldValidator.sample(
      {int? minLength,
      int? maxLength,
      bool? upperAndLowerCase,
      bool? specialCharacter,
      bool? digitCharacter,
      required bool showLoremIpsum,
      OnErrorFunction? onErrorFunction})
      : _minLengthValidator = MinLengthValidator(
            minLength: minLength,
            errorText: 'Minimum length is $minLength' + (showLoremIpsum ? ' ${LoremIpsum.just()}' : ''),
            onErrorFunction: onErrorFunction),
        _maxLengthValidator = MaxLengthValidator(
            maxLength: maxLength,
            errorText: 'Maximum length is $maxLength' + (showLoremIpsum ? ' ${LoremIpsum.just()}' : ''),
            onErrorFunction: onErrorFunction),
        _upperLowerCaseValidator = UpperLowerCaseValidator(
            validateUpperLowerCase: upperAndLowerCase,
            errorText: 'Upper and lower case character is required' + (showLoremIpsum ? '${LoremIpsum.just()}' : ''),
            onErrorFunction: onErrorFunction),
        _specialCharacterValidator = SpecialCharacterValidator(
            validateSpecialCharacter: specialCharacter,
            errorText: 'Special character is required' + (showLoremIpsum ? '${LoremIpsum.just()}' : ''),
            onErrorFunction: onErrorFunction),
        _digitCharacterValidator = DigitCharacterValidator(
            validateDigit: digitCharacter,
            errorText: 'Digit character is required' + (showLoremIpsum ? '${LoremIpsum.just()}' : ''),
            onErrorFunction: onErrorFunction);

  /// Standard validations with an option to define custom error messages
  PasswordFieldValidator.standard(
      {required MinLengthValidator minLengthValidator,
      required MaxLengthValidator maxLengthValidator,
      required UpperLowerCaseValidator upperLowerCaseValidator,
      required SpecialCharacterValidator specialCharacterValidator,
      required DigitCharacterValidator digitCharacterValidator})
      : _minLengthValidator = minLengthValidator,
        _maxLengthValidator = maxLengthValidator,
        _upperLowerCaseValidator = upperLowerCaseValidator,
        _specialCharacterValidator = specialCharacterValidator,
        _digitCharacterValidator = digitCharacterValidator;

  /// Used when password field shouldn't be applied - login / entering old password
  PasswordFieldValidator.none({OnErrorFunction? onErrorFunction})
      : _minLengthValidator = MinLengthValidator(minLength: 0, errorText: '', onErrorFunction: onErrorFunction),
        _maxLengthValidator = MaxLengthValidator(maxLength: 100, errorText: '', onErrorFunction: onErrorFunction),
        _upperLowerCaseValidator = UpperLowerCaseValidator(validateUpperLowerCase: false, errorText: '', onErrorFunction: onErrorFunction),
        _specialCharacterValidator = SpecialCharacterValidator(validateSpecialCharacter: false, errorText: '', onErrorFunction: onErrorFunction),
        _digitCharacterValidator = DigitCharacterValidator(validateDigit: false, errorText: '', onErrorFunction: onErrorFunction);

  List<TextFormFieldValidator> get validators =>
      [_minLengthValidator, _maxLengthValidator, _upperLowerCaseValidator, _specialCharacterValidator, _digitCharacterValidator];
}
