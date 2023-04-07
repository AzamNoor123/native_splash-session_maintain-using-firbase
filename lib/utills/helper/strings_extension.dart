import '../constants_resource.dart';

extension stringvalidation on String {
  bool isValidEmail() {
    if (isEmpty) return false;
    final regex = ConstatntStrings.regex;
    return regex.hasMatch(this);
  }

  String get captilize {
    return this[0].toUpperCase() + substring(1);
  }
}
