

class MyValidation {
  static String? emailValidation(String s) {
    RegExp pattern = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
    if (s.isEmpty) {
      return 'Email cannot be empty';
    }
    else if (!pattern.hasMatch(s)) {
      return 'Enter valid email';
    }
    return null;
  }


  static String? passwordValidation(String s) {
    if (s.isEmpty || s == "") {
      return "Password cannot be empty";
    }
    else if (s.length < 6) {
      return "Password must not be less then 6 digits";
    }
    return null;
  }

  static String? newPasswordValidation(String s){
    if(s.isEmpty || s=="")
    {
      return "Password cannot be empty";
    }
    else if(s.length<6)
    {
      return "Password must not be less then 6 character";
    }
    return null;
  }

  static String? reEnterPasswordValidation(String s,{String? validate}){
    if(s.isEmpty || s=="")
    {
      return "Re-Enter Password cannot be empty";
    }
    else if(s != validate)
    {
      return "Password doesn't match";
    }
    return null;
  }


  static String? phoneValidation(String s) {
    if (s.isEmpty || s == "") {
      return "Number cannot be empty";
    }
    else if (s.length < 10) {
      return "Number must not be less then 10 digits";
    }
    return null;
  }

  static String? noteValidation(String s) {
    if (s.isEmpty || s == "") {
      return "Note cannot be empty";
    }
    return null;
  }


  static String? addressValidation(String s) {
    if (s.isEmpty || s == "") {
      return "Address cannot be empty";
    }
    else if (s.length < 3) {
      return "Address must not be less then 3 character";
    }

    return null;
  }

  static String? desValidation(String s) {
    if (s.isEmpty || s == "") {
      return "Description Cannot be Empty";
    }
    else if (s.length < 5) {
      return "Description must not be less then 5 character";
    }
    return null;
  }


  static String? fullNameValidation(String? s) {
    if (s!.isEmpty || s == "") {
      return "Full name cannot be empty";
    }
    return null;
  }

  static String? lastNameValidation(String? s) {
    if (s!.isEmpty || s == "") {
      return "Last name cannot be empty";
    }
    return null;
  }

}
