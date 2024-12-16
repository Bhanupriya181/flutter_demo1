import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

import '../constants/colors.dart';

class MyWidgets {

  static Widget showText(String text, Color color, double size, FontWeight value) {
    return Text(text, style: TextStyle(color: color, fontSize: size, fontWeight: value));
  }

  static Widget noDataFound(BuildContext context, String text) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Lottie.asset(
                'assets/lotties/lottie_no_data.json',
                height: 100,
                width: 100,
              )),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ],
      ),
    );
  }

  //please wait loader
  static showLoader() {
    return  Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoadingAnimationWidget.inkDrop(
                  color: colorPrimary, size: 45),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Please Wait ...",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              )
            ],
          ),
        ));
  }

  //loader with dynamic text
  static showLoaderWithText(String text) {
    return Container(
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LoadingAnimationWidget.inkDrop(
                    color: colorPrimary, size: 45),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  text,
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                )
              ],
            ),
          )),
    );
  }

  //error message
  static showValidationMessage(String validationMessage, BuildContext context) {
    Flushbar(
      message: validationMessage,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      duration: const Duration(seconds: 3),
      leftBarIndicatorColor: Colors.blue[300],
    ).show(context);
  }

  //// use to show the snack-bar
  static SnackbarController showSnackBar(String title, String message, Color textColor, Color backgroundColor) {
    return Get.snackbar(
      title,
      message,
      colorText: textColor,
      backgroundColor: backgroundColor,
    );
  }
}

