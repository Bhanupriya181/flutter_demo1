import 'package:assesment_flutter/screens/miPInLoginScreen/mi_pin_login_controller.dart';
import 'package:get/get.dart';

class MiPinLoginBinding extends Bindings {
  @override
  void dependencies() {
 Get.lazyPut(() => MiPinLoginController(),);
  }

}