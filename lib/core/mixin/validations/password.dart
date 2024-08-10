mixin PasswordValidation {
  static const String _passPattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  String? validatePassword(context, String? value) {
    final regExp = RegExp(_passPattern);
    if (value!.isEmpty) {
      return "This field is required";
    } else if (!regExp.hasMatch(value)) {
      return "Password not vaild";
    }
    return null;
  }

  String? validateConfirmPassword(context, String value, String? password) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (value != password) {
      return "Not Match Password";
    }
    return null;
  }
}
