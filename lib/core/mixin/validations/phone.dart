mixin PhoneValidation {
  static const String _phonePattern = r'^\+(?:[0-9] ?){6,14}[0-9]$';
  final phoneRegExp = RegExp(_phonePattern);

  String? validatePhone(context, String? value) {
    if (value!.isEmpty) {
      return "This field is required";
    } else if (!phoneRegExp.hasMatch(value)) {
      return "Enter a valid phone number";
    }
    return null;
  }
}
