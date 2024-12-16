import 'dart:io';
import 'package:assesment_flutter/app_routes.dart';
import 'package:assesment_flutter/common/common_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Controllers for TextFields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Observable for password visibility
  RxBool obscureText = true.obs;

  FocusNode userFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  // Example login method
  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;

      // Save email, password, and isLoginWithEmail to shared preferences
      await Constants.instance.saveStringValue(USER_EMAIL, email);
      await Constants.instance.saveStringValue(USER_PASSWORD, password);
      await Constants.instance.saveBooleanValue(IS_LOGIN_WITH_MAIL, true);

      //login successFull
      Get.snackbar("Login", "Logged in SuccessFully",backgroundColor: colorPrimary,
      colorText: Colors.white,duration: Duration(seconds: 1));

      Get.toNamed(AppRoutes.mpinScreen);
    } else {
      MyWidgets.showValidationMessage("Something went wrong", Get.context!);
    }

  }

  Future<bool?> wiiPopDialog() async {
    return (await Get.dialog(
        barrierDismissible: true,
        AlertDialog(
          icon: const Icon(
            CupertinoIcons.exclamationmark_shield,
            color: Color(0xffe34234),
            size: 60,
          ),
          elevation: 50,
          actionsPadding: const EdgeInsets.all(15),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Column(
            children: [
              Text(
                "Are you sure, you want to Exit !",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade600,
                    fontSize: 15),
              )
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                    width: MediaQuery.of(Get.context!).size.width * 0.3,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      border: Border.all(
                        width: 1.0,
                        color: colorPrimary,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text(
                          "No",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 15),
                        )))),
            GestureDetector(
                onTap: () async {
                  exit(0);
                },
                child: Container(
                    width: MediaQuery.of(Get.context!).size.width * 0.3,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xffe34234),
                      border: Border.all(
                        width: 1.0,
                        color: colorPrimary.withOpacity(0.3),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text(
                          "Yes",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontSize: 15),
                        ))))
          ],
        )));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
