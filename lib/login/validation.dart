void checkValidity(
    String email, String password, String confirmPassword, bool isSignIn) {
  String emailText = email;
  bool validEmail = RegExp(r"^[a-zA-Z0-9.!#$%*+/=?^_{|}~-]+@iiitkalyani.ac.in")
      .hasMatch(emailText);
  if (!validEmail) {
    throw Exception("Please enter valid college appointed email!");
  }

  bool validPassword =
      RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])(?=.{8,})")
              .hasMatch(password) &&
          password.indexOf(" ") == -1;

  if (!validPassword) {
    throw Exception("Please enter a valid password!\n"
        "Rules: Password should-\n"
        "-Be at-least 8 characters long\n"
        "-Contain at-least 1 numeric character\n"
        "-Contain at-least 1 lowercase and uppercase character\n"
        "-Contain at-least 1 special character from !@#\$%^&*");
  }
  if (!isSignIn) {
    if (password != confirmPassword) {
      throw Exception("Both passwords don't match!");
    }
  }
}
