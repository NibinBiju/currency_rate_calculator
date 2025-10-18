class Validation {
  //validate email
  static String? validateEmail({required String email}) {
    final bool emailValid = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
    ).hasMatch(email);

    if (email.isEmpty) {
      return 'Email is required';
    } else if (!emailValid) {
      return 'Email is not correct';
    } else {
      return null;
    }
  }

  //validate password
  static String? validatePassword({required String password}) {
    if (password.isEmpty) {
      return 'Password is required';
    } else if (password.length < 6) {
      return 'Password must be at least 6 characters';
    } else {
      return null;
    }
  }
}
