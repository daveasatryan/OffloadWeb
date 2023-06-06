import 'package:dart_extensions_methods/dart_extension_methods.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ValidationUtils {
  static bool isValidPassword(String? password) {
    if (password.isNullOrEmpty()) return false;
    final regexp = RegExp('^'
        //'(?=.*\\d)' //at least 1 digit
        //'(?=.*[a-z])' //at least 1 lower case letter
        //'(?=.*[A-Z])' //at least 1 upper case letter
        //'(?=.*\\W)' //at least 1 non word character
        // '(?=\\S+\$)' //no white spaces
        '.{8,}' //at least 8 characters
        '\$');
    return regexp.hasMatch(password ?? '');
  }

  static bool isValidEmail(String? email) => GetUtils.isEmail(email ?? '');
  static var maskPhoneNumber = MaskTextInputFormatter(
    mask: '##################',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
}
