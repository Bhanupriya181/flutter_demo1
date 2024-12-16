import 'package:assesment_flutter/common/common_methods.dart';
import 'package:assesment_flutter/common/common_widgets.dart';
import 'package:assesment_flutter/screens/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class LoginScreen extends GetView<LoginController> {
   LoginScreen({super.key});

   Future<bool> _onWillPop() async {
     return (await loginController.wiiPopDialog() ?? false);
   }

  final LoginController loginController = Get.put(LoginController()) ;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: loginController,
        builder:(_){
      return  SafeArea(child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16,top: 120),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Image.asset("assets/images/login1.png",height: 200,),
                      const Text(
                        "Login to your account",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22,color: colorPrimary),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: loginController.emailController,
                        focusNode: loginController.userFocusNode,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email,size: 18,color: Colors.grey[600]),
                          hintStyle: TextStyle(color: Colors.grey[600],fontSize: 13),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                              color: loginController.userFocusNode.hasFocus ? colorPrimary : Colors.grey,
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator:  (value) {
                          return CommonMethods.instance.validateEmail(value);
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Obx(() => TextFormField(
                        controller: loginController.passwordController,
                        obscureText: loginController.obscureText.value,
                        focusNode: loginController.passwordFocusNode,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock,size: 18,color: Colors.grey[600]),
                          hintStyle: TextStyle(color: Colors.grey[600],fontSize: 13),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                              color: loginController.passwordFocusNode.hasFocus ? colorPrimary : Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          suffixIcon: InkWell(
                            onTap: loginController.togglePasswordVisibility,
                            child: Icon(loginController.obscureText.value ? Icons.visibility : Icons.visibility_off,color: colorPrimary,),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (!CommonMethods.instance.isValidPassword(value)) {
                            return 'Password must be at least 8 characters, include uppercase, lowercase, number, and special character';
                          }
                          return null;
                        },
                      )),
                      const SizedBox(height: 30.0),
                      GestureDetector(
                        onTap: loginController.login,
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      );
    });
  }

}