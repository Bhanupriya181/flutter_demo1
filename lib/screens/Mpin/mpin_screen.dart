import 'package:assesment_flutter/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'mpin_controller.dart'; // Import your controller

class MpinScreen extends GetView<MpinController> {
  final MpinController mPinController = Get.put(MpinController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MpinController>(
      init: mPinController,
      builder: (_) {
        return SafeArea(
          child: Obx(() => Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/otp.png', // Add your bank logo here
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    mPinController.isConfirming.value ? 'Confirm MPIN' : 'Enter MPIN',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  buildPinDots(mPinController.pin.value),
                  const SizedBox(height: 40),
                  buildNumberPad(mPinController),
                ],
              ),
            ),
          ),),
        );
      },
    );
  }

  // Build PIN input fields
  Widget buildPinDots(String currentPin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < currentPin.length ? colorPrimary : Colors.grey[300],
          ),
        );
      }),
    );
  }

  // Build custom number pad
  Widget buildNumberPad(MpinController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (j) {
              int number = i * 3 + j + 1;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () => controller.onKeyPressed(number.toString()),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: colorPrimary.withOpacity(0.5),
                    padding: const EdgeInsets.all(20),
                  ),
                  child: Text(
                    number.toString(),
                    style: const TextStyle(fontSize: 24,color: Colors.white),
                  ),
                ),
              );
            }),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0,vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => controller.onKeyPressed("0"),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: colorPrimary.withOpacity(0.5),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text(
                  "0",
                  style: TextStyle(fontSize: 24,color: Colors.white),
                ),
              ),
              const SizedBox(width: 25,),
              ElevatedButton(
                onPressed: controller.onClearPressed,
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: colorPrimary.withOpacity(0.5),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Icon(Icons.clear, size: 24,color: Colors.white,),
              ),
            ],
          ),
        ),
      ],
    );
  }
}