import 'package:assesment_flutter/common/common_widgets.dart';
import 'package:assesment_flutter/constants/colors.dart';
import 'package:assesment_flutter/screens/miPInLoginScreen/mi_pin_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MiPinLoginScreen extends GetView<MiPinLoginController> {
  final MiPinLoginController miPinLoginController = Get.put( MiPinLoginController());

   MiPinLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(init:miPinLoginController,builder: (_){
      return SafeArea(child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Container(),
          elevation: 0,),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/password.png', // Replace with your asset path
                  height: 150,
                  fit: BoxFit.cover,
                  color: colorPrimary,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter Your MPIN',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: colorPrimary),
              ),
              const SizedBox(height: 10),
              const Text(
                'Pin Verification',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: colorPrimary.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextField(
                      controller: miPinLoginController.otpControllers[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.none,
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                  ),
                  itemCount: miPinLoginController.digits.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => miPinLoginController.onDigitPress(index),
                      child: Container(
                        margin: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: colorPrimary.withOpacity(0.5),
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: Text(
                            miPinLoginController.digits[index],
                            style: const TextStyle(fontSize: 24,color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  GestureDetector(
                    onTap: (){
                      miPinLoginController.forgotPin();
                    },
                    child: Container(
                      child: MyWidgets.showText("Forgot pin? , Generate again.", colorPrimary, 15, FontWeight.w400),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              IgnorePointer(
                ignoring: miPinLoginController.otpControllers.length<4 ? true : false,
                child: GestureDetector(
                  onTap: (){
                    miPinLoginController.onClickLoginWithMpin();
                  },
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
              ),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      ));
    });
  }

}