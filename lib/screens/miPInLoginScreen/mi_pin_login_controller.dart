import 'package:assesment_flutter/app_routes.dart';
import 'package:assesment_flutter/common/common_widgets.dart';
import 'package:assesment_flutter/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/colors.dart';
import '../../database/database.dart';

class MiPinLoginController extends GetxController {

  var enteredMpin = ''.obs ;
  final List<TextEditingController> otpControllers = List.generate(4, (index) => TextEditingController());
  final List<String> digits = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', '<'];
  late MyDatabase database ;

  @override
  void onInit() async {
    super.onInit();
    await initializeDb() ;
  }

  Future<void> initializeDb() async {
    database = await $FloorMyDatabase
        .databaseBuilder('my_database.db')
        .build();
  }


  void onDigitPress(int index) {
    String digit = digits[index];
    if (digit == '<') {
      for (int i = 3; i >= 0; i--) {
        if (otpControllers[i].text.isNotEmpty) {
          otpControllers[i].clear();
          break;
        }
      }
    } else if (digit.isNotEmpty) {
      for (int i = 0; i < 4; i++) {
        if (otpControllers[i].text.isEmpty) {
          otpControllers[i].text = digit;
          break;
        }
      }
    }
  }

  bool isMpinComplete() {
    for (var controller in otpControllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  void resetMpin() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    enteredMpin.value = '';
  }

  onClickLoginWithMpin() async{

    if (!isMpinComplete()) {
      MyWidgets.showValidationMessage("Enter MPIN first to log in", Get.context!);
      return;
    }
    //check if block data already downloaded than go to
    var entity = await database.blockDao.getAllBlocks() ;
    var draft = await database.draftDao.getAllDraftBlocks() ;
    var completed = await database.completedDao.getAllCompletedBlocks() ;
    var data = await Constants.instance.getBooleanValue(IS_BLOCK_DATA_DOWNLOADED);

    enteredMpin.value = otpControllers.map((controller) => controller.text).join(); // Joining all inputs
    debugPrint("Entered MPIN: ${enteredMpin.value}");

    String? registeredMpin = await Constants.instance.getStringValue(MPIN);
    if (registeredMpin != null) {
      if (enteredMpin.value == registeredMpin) {
        await Constants.instance.saveBooleanValue(IS_LOGIN_WITH_MPIN, true);
        if(entity.isNotEmpty || draft.isNotEmpty || completed.isNotEmpty) {
          Get.offAllNamed(AppRoutes.dashboard);
        } else {
          Get.offAllNamed(AppRoutes.downloadBlockData);
        }

        Get.snackbar("Login", "Login with Mpin SuccessFull",backgroundColor: colorPrimary,
            colorText: Colors.white,duration: const Duration(seconds: 2));
      } else {
        MyWidgets.showValidationMessage("Unregistered MPIN, please enter the correct MPIN", Get.context!);
        resetMpin();
      }
    }
  }

  void forgotPin() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance() ;
    sharedPreferences.remove(MPIN);
    sharedPreferences.remove(ISMPINSAVED);
    Get.offAllNamed(AppRoutes.mpinScreen);
  }
}