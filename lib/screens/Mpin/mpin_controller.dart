import 'package:assesment_flutter/app_routes.dart';
import 'package:assesment_flutter/common/common_widgets.dart';
import 'package:assesment_flutter/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';

class MpinController extends GetxController {
  var pin = ''.obs;
  var confirmedPin = ''.obs;
  var isConfirming = false.obs;
  var totalPin = ''.obs;

  // Function to save the PIN in shared preferences
  Future<void> savePin(String pin) async {
    //save the mpin value and save is mpin saved to true
    await Constants.instance.saveStringValue(MPIN, pin);
    await Constants.instance.saveBooleanValue(ISMPINSAVED, true);
  }

  // Function to handle button press
  Future<void> onKeyPressed(String value) async {
    totalPin.value+=value ;
    if (pin.value.length < 4) {
      pin.value += value;
    }

    // When PIN length is 4, either confirm it or save it
    if (pin.value.length == 4 && isConfirming.value) {
      confirmedPin.value = pin.value;
      if (pin.value == confirmedPin.value) {
        savePin(pin.value);
        clearPin(); // Clear PIN after saving
      } else {
        clearPin();
        isConfirming.value = false;
      }
    } else if (pin.value.length == 4 && !isConfirming.value) {
      confirmedPin.value = pin.value;
      isConfirming.value = true;
      pin.value = ""; // Clear for confirmation step
    }

    if (totalPin.value.length == 8) {
      debugPrint("First 4 digits: $totalPin.value");
      // Extract the first 4 digits and the second 4 digits
      String firstFourDigits = totalPin.value.substring(0, 4);
      String secondFourDigits = totalPin.value.substring(4, 8);

      debugPrint("First 4 digits: $firstFourDigits");
      debugPrint("Second 4 digits: $secondFourDigits");

      if(firstFourDigits == secondFourDigits) {
         await savePin(secondFourDigits) ;
         Get.toNamed(AppRoutes.miPinLoginScreen);
         //login successFull
         Get.snackbar("MPin", "Mpin generated SuccessFully",backgroundColor: colorPrimary,
             colorText: Colors.white,duration: Duration(seconds: 1));
      } else {
        MyWidgets.showValidationMessage("Pins Not Matched,Enter the pin again.", Get.context!);
        isConfirming(false);
        pin.value = "";
        confirmedPin.value = "";
        totalPin.value = "" ;
      }
    }
  }

  // Function to handle clear button
  void onClearPressed() {
    if (pin.value.isNotEmpty) {
      pin.value = pin.value.substring(0, pin.value.length - 1); // Clear last digit
    }
    if(totalPin.value.isNotEmpty) {
      totalPin.value = totalPin.value.substring(0, totalPin.value.length-1);
    }
  }

  // Clear the PIN
  void clearPin() {
    pin.value = "";
    confirmedPin.value = "";
  }
}
