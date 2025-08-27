import 'package:flutter/material.dart';

class FieldValidator {
  BuildContext context;
  FieldValidator(this.context);

  String? firmValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter firm name';
    } else {
      return null;
    }
  }

  String? designationValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Designation';
    } else {
      return null;
    }
  }

  String? emailValidate(String? value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value.toString());
    if (value == null || value.isEmpty) {
      return 'Please enter email address';
    } else if (!emailValid) {
      return 'Please enter valid email address';
    } else {
      return null;
    }
  }

  String? loginEmailMobileValidate(String? value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value.toString());
    bool isNumeric = RegExp(r'^-?[0-9]+$').hasMatch(value.toString());

    if (value == null || value.isEmpty) {
      return 'Please enter email address or mobile number';
    } else {
      if (isNumeric) {
        if (value.length < 10) {
          return 'Please enter valid mobile number';
        } else {
          return null;
        }
      } else {
        if (!emailValid) {
          return 'Please enter valid email address';
        } else {
          return null;
        }
      }
    }
  }

  String? addressValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter address';
    } else {
      return null;
    }
  }

  String? pincodeValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter postal code';
    } else {
      return null;
    }
  }

  String? cityValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter city';
    } else {
      return null;
    }
  }

  String? areaValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter area';
    } else {
      return null;
    }
  }

  String? stateValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter State';
    } else {
      return null;
    }
  }

  String? countryValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter country';
    } else {
      return null;
    }
  }

  String? nameValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter name';
    } else {
      return null;
    }
  }

  String? firstNameValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter first name';
    } else {
      return null;
    }
  }

  String? lastNameValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter last name';
    } else {
      return null;
    }
  }

  String? mobileValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter mobile number';
    } else if (value.length < 10) {
      return 'The mobile no must be at least 10 numbers.';
    } else {
      return null;
    }
  }

  String? passwordValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else if (value.length < 6) {
      return 'The password must be at least 6 characters.';
    } else {
      return null;
    }
  }
}
