export 'form_validator.dart';

class FormValidator {
  static String? validateField(String? val) {
    if (val == null || val.isEmpty) {
      return 'This field can\'t be empty';
    }
    return null;
  }
}
