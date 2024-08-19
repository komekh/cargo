import 'package:easy_localization/easy_localization.dart';

class FormValidator {
  static String? validateField(String? val) {
    if (val == null || val.isEmpty) {
      return 'required_validation'.tr();
    }
    return null;
  }
}
