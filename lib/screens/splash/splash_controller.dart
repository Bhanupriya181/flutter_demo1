import 'package:assesment_flutter/app_routes.dart';
import 'package:assesment_flutter/constants/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Show splash screen for 2 seconds and then navigate
    Future.delayed(const Duration(seconds: 3), () {
      checkLoginStatus();
    });
  }

  // Method to check login status and navigate accordingly
  void checkLoginStatus() async {

    //check if save login with mail
    bool? isLoginWithMail = await Constants.instance.getBooleanValue(IS_LOGIN_WITH_MAIL);

    //check if save or generate mpin
    bool? ishMpinSaved = await Constants.instance.getBooleanValue(ISMPINSAVED);

    bool? isLoginWithMpin = await Constants.instance.getBooleanValue(IS_LOGIN_WITH_MPIN);

    bool? isBlockDataDownloded = await Constants.instance.getBooleanValue(IS_BLOCK_DATA_DOWNLOADED);

    //if not login
    if(!isLoginWithMail!){
      Get.offAllNamed(AppRoutes.loginScreen);
    }
    //if login with mail but not saved  mpin then go to mpinscreen
    else if(isLoginWithMail! && !ishMpinSaved!) {
      Get.offAllNamed(AppRoutes.mpinScreen);
    }
    //if login with mail and also saved mpin but not saved mpinLogin  then go to mpinLogin
    else if(ishMpinSaved! && isLoginWithMail! && !isLoginWithMpin!){
      Get.offAllNamed(AppRoutes.miPinLoginScreen);
    }
    //if loginwith mpin then move to download or dashboard page
    else if(ishMpinSaved! && isLoginWithMail! &&  isLoginWithMpin!){
      // check if its already download the block data
      if(isBlockDataDownloded!) {
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        Get.offAllNamed(AppRoutes.downloadBlockData);
      }
    }
  }
}
