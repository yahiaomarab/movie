mixin EmailValidation {
  static const String _emailPattern =
      "[a-zA-Z0-9\\+\\._%\\-\\+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";

  String? validateEmail(context, String? value) {
    final regExp = RegExp(_emailPattern);
    if (value!.isEmpty) {
      return "This field is required";
    } else if (!regExp.hasMatch(value)) {
      return "Enter a Vaild Email";
    } else {
      return null;
    }
  }
}
