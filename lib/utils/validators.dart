abstract class FieldValidator {
  final String value;
  String get message;
  FieldValidator(this.value);
  String? validate();
}

class RequiredValidator extends FieldValidator {
  RequiredValidator({required String value}) : super(value);

  @override
  String get message => 'field_required';

  @override
  String? validate() => value.isEmpty ? message : null;
}

class EmailValidator extends FieldValidator {
  EmailValidator({required String value}) : super(value);

  @override
  String get message => 'invalid_email';

  @override
  String? validate() {
    final regex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$");
    return regex.hasMatch(value) ? null : message;
  }
}

class PasswordMatchValidator extends FieldValidator {
  final String value2;

  PasswordMatchValidator({required String value, required this.value2}) : super(value);

  @override
  String get message => 'passwords_unmatch';

  @override
  String? validate() => value == value2 ? null : message;
}

class SanitizerValidator extends FieldValidator {
  SanitizerValidator({required String value}) : super(value);

  @override
  String get message => 'invalid_input';

  @override
  String? validate() {
    final regex = RegExp(
      r"(<[^>]*>)|(script|on\w+\s*=|javascript:|alert\s*\(|eval\s*\()",
      caseSensitive: false,
      multiLine: true,
    );
    return regex.hasMatch(value) ? message : null;
  }
}

class MultiValidator {
  List<FieldValidator> validators;
  MultiValidator({required this.validators});

  String? validate() {
    if (validators.isNotEmpty) {
      String value = validators.elementAt(0).value;
      validators.add(SanitizerValidator(value: value));
      for (FieldValidator validator in validators) {
        final result = validator.validate();
        if (result != null) return result;
      }
    }
    return null;
  }
}
