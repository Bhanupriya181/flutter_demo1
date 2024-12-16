import 'package:assesment_flutter/screens/splash/splash_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
   SplashScreen({super.key});
  final SplashController splashController = Get.put(SplashController()) ;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: splashController,
        builder: (_){
      return  SafeArea(child: Scaffold(body: Center(
        child: Center(child: Image.asset("assets/images/welcome.png"))
      ),)) ;
    }) ;
  }

}