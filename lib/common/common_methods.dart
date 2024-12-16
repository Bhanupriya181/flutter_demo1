import 'package:flutter/cupertino.dart';

class CommonMethods {

  CommonMethods._privateConstructor();
  static final CommonMethods instance = CommonMethods._privateConstructor();


  bool isValidEmail(String value) {
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }

  bool isValidPassword(String value) {
    RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*]).{8,}$');
    return passwordRegex.hasMatch(value);
  }

  String? isValidMobNumber(String value) {
    Pattern pattern = r'^(?:(?:\+|0{0,2})91(\s*|[\-])?|[0]?)?([6789]\d{2}([ -]?)\d{3}([ -]?)\d{4})$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return 'Invalid mobile number';
    } else {
      return null;
    }
  }

  String? validateEmail(value) {
    if (value!.isEmpty) {
      return 'Please enter your email';
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    if (value.split('@').length != 2) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length != 10) {
      return 'Please enter a 10-digit phone number';
    }
    if (!RegExp(r'^[6-9]').hasMatch(value)) {
      return 'Phone number should start with a digit from 6 to 9';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Phone number should contain only digits';
    }
    return null;
  }

  String? validateAadharNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Aadhar number';
    }
    if (value.length != 12) {
      return 'Aadhar number should be 12 digits long';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Aadhar number should contain only digits';
    }
    return null;
  }

  String? validatePermanentAddress(value){
    if (value!.isEmpty) {
      return 'Please enter your permanent address';
    }
    return null;
  }

  String? validatePinCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Pincode';
    }
    if (value.length != 6) {
      return 'Pincode must be exactly 6 digits';
    }
    if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
      return 'Pincode must contain only digits';
    }
    return null;
  }

  String? subjectValidator(value) {
    if (value!.isEmpty) {
      return 'Please enter your subject';
    }
    return null ;
  }

  String? descriptionValidator(value) {
    if (value!.isEmpty) {
      return 'Please enter Description';
    }
    return null ;
  }

  String? checkNullValue(String value) {
    if (value != "null") {
      return value;
    }
    return null;
  }




}