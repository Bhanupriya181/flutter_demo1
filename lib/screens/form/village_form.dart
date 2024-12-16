import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class VillageFormBottomSheet extends StatefulWidget {
  @override
  _VillageFormBottomSheetState createState() => _VillageFormBottomSheetState();
}

class _VillageFormBottomSheetState extends State<VillageFormBottomSheet> {
  final TextEditingController villageController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _chooseImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Village Name Field
            TextField(
              controller: villageController,
              decoration: InputDecoration(
                labelText: "Village Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Remark Field
            TextFormField(
              controller: remarkController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Remark",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Image Container and Choose Image Button
            Row(
              children: [
                // Image Container
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _selectedImage != null
                      ? Image.file(
                    File(_selectedImage!.path),
                    fit: BoxFit.cover,
                  )
                      : Center(child: Text("No Image")),
                ),
                SizedBox(width: 16),

                // Choose Image Button
                ElevatedButton(
                  onPressed: _chooseImage,
                  child: Text("Choose Image"),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                String villageName = villageController.text;
                String remark = remarkController.text;
                if (villageName.isNotEmpty && remark.isNotEmpty && _selectedImage != null) {
                  // Perform form submission logic here
                  Get.snackbar(
                    "Form Submitted",
                    "Village: $villageName\nRemark: $remark",
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                } else {
                  Get.snackbar(
                    "Invalid Input",
                    "Please fill all fields and choose an image.",
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showVillageFormBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,  // Fullscreen bottom sheet
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return VillageFormBottomSheet();
    },
  );
}
