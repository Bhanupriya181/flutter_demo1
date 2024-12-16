
import 'package:assesment_flutter/common/common_widgets.dart';
import 'package:assesment_flutter/database/entity/block_entity.dart';
import 'package:assesment_flutter/database/entity/completedBlockEntity.dart';
import 'package:assesment_flutter/database/entity/draftBlockEntity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../app_routes.dart';
import '../../constants/colors.dart';
import '../../database/database.dart';
import '../../database/entity/village_entity.dart';

class PendingDetailsController extends GetxController {

  var entity;
  var isLoading = true.obs;
  var isDraftEntity = false.obs;
  var isCompletedEntity = false.obs;
  late MyDatabase database ;
  RxList<VillageEntity> villageList = <VillageEntity>[].obs ;
  var type = "".obs;

  //form
  final TextEditingController villageController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  RxString selectedImagePath = ''.obs;
  final ImagePicker picker = ImagePicker();


  @override
  void onInit() async{
    super.onInit();
    final arguments = Get.arguments;
    await initializeDb();
    if (arguments != null  && arguments is BlockEntity) {
      entity = arguments;
      loadVillageList();
    } else if(arguments != null && arguments is Draftblockentity){
      entity = arguments ;
      loadVillageList();
      isDraftEntity(true) ;
    } else if(arguments != null && arguments is Completedblockentity){
      entity = arguments ;
      loadVillageList();
      isCompletedEntity(true) ;
    } else {
      isLoading(false);
      debugPrint('Invalid argument passed!');
    }
  }

  Future<void> initializeDb() async {
    database = await $FloorMyDatabase
        .databaseBuilder('my_database.db')
        .build();
  }



  Future<void> loadVillageList() async {
    try {
      var blockId = entity.blockId ;
      var villageLists = await database.villageDao.getVillageById(blockId);
      villageList(villageLists) ;
      isLoading(false);
      update();
        } catch (e) {
      isLoading(false);
      debugPrint("Error loading village list: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> onSave() async {
    isLoading(true);
    // Show the loader for at least 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    try {
      Draftblockentity draftBlockEntity = Draftblockentity(
          blockName: entity.blockName, blockId: entity.blockId, villageList: entity.villageList);

      // Perform your database operations
      await database.draftDao.insertDraftBlock(draftBlockEntity);
      await database.blockDao.deleteBlocksById(entity.id!);

      // Show success message
      Get.snackbar(
        "Saved",
        "Data Saved in Draft Successfully",
        backgroundColor: colorPrimary,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Update loading state and go back
      isLoading(false);
      Get.offNamed(AppRoutes.pending_screen);
    } catch (e) {
      isLoading(false);
      debugPrint("ERROR::::::::::${e.toString()}");
    }
  }
  Future<void> onSubmit() async{
    isLoading(true);
    try{
      await Future.delayed(const Duration(seconds: 3));
      Completedblockentity completedblockentity = Completedblockentity(blockName: entity.blockName,
          blockId: entity.blockId, villageList: entity.villageList);
      await database.completedDao.insertCompletedBlock(completedblockentity);
      await database.blockDao.deleteBlocksById(entity.id!);
      // Show success message
      Get.snackbar(
        "Submitted",
        "Data Submit Successfully",
        backgroundColor: colorPrimary,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      isLoading(false);
      Get.offNamed(AppRoutes.pending_screen);
    } catch(e) {
      isLoading(false);
      debugPrint("ERROR::::::::::${e.toString()}");
    }
  }

  Future<void> addNewVillage() async {
    Get.back();
    // Show loading indicator
    isLoading(true);

    // Form validation logic
    String villageName = villageController.text.toString();
    String remark = remarkController.text.toString();
    String selectedImage = selectedImagePath.value;
    DateTime currentDate = DateTime.now();

    // Format the date to something more readable if necessary (optional)
    String formattedDate = "${currentDate.day}-${currentDate.month}-${currentDate.year}";

    if (villageName.isNotEmpty && remark.isNotEmpty) {
      try {
        VillageEntity newVillage = VillageEntity(
          blockId: entity.blockId,  // Assuming you're linking this to a block
          villageName: villageName,
          remark: remark,
          image: selectedImage,
          date: formattedDate, // Add the formatted date here
        );

        // Insert the new village into the database
        await database.villageDao.insertVillage(newVillage);

        // Load the updated village list
        loadVillageList();

        // Show success message
        Get.snackbar(
          "Village Added",
          "New village added successfully on $formattedDate!",  // Include the date in the success message
          backgroundColor: colorPrimary,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

      } catch (e) {
        debugPrint(e.toString());
        MyWidgets.showValidationMessage("Something went wrong", Get.context!);
      } finally {
        isLoading(false);
      }
    } else {
      isLoading(false);
      MyWidgets.showValidationMessage("Invalid Input, Please fill all the fields", Get.context!);
      Get.snackbar(
        "Invalid Input",
        "Please fill all the fields and choose an image",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }


  Future<void> updateVillage(int index, int? id) async {
    Get.back();
    // Show loading indicator
    isLoading(true);

    try {
      // Fetch the village by ID from the database
      VillageEntity? existingVillage = await database.villageDao.getVillagesByVillageId(id!);

      if (existingVillage != null) {
        // Get updated data from the form
        String updatedVillageName = villageController.text.toString();
        String updatedRemark = remarkController.text.toString();
        String updatedImage = selectedImagePath.value;
        DateTime currentDate = DateTime.now();
        // Format the date to something more readable if necessary (optional)
        String formattedDate = "${currentDate.day}-${currentDate.month}-${currentDate.year}";

        // Update the village fields
        existingVillage.villageName = updatedVillageName;
        existingVillage.remark = updatedRemark;
        existingVillage.image = updatedImage;
              existingVillage.date = formattedDate.toString() ;
        existingVillage.blockId = entity.blockId ;

        // Update the village in the database
        await database.villageDao.updateVillage(existingVillage);

        // Reload the village list
        loadVillageList();

        // Show success message
        Get.snackbar(
          "Village Updated",
          "Village details updated successfully",
          backgroundColor: colorPrimary,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        debugPrint("Village not found for ID: $id");
      }
    } catch (e) {
      debugPrint("Error updating village: $e");
      Get.snackbar(
        "Error",
        "Failed to update village. Try again later.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    } finally {
      isLoading(false);
    }
  }


  Future<bool?> wiiPopDialog(int index, int? id) async {
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
                  await deleteVillage(index, id!);
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


  Future<void> deleteVillage(int index, int? id) async{
    isLoading(true) ;
    try{
      Get.back();
      if(id != null){
        await database.villageDao.deleteVillagesById(id);
        villageList.removeAt(index);
        update();
      } else {
        Get.snackbar(
          "Error",
          "Failed to delete village. Try again later.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }

    }catch(e){
      debugPrint("Error Deleting village: $e");
      Get.snackbar(
        "Error",
        "Failed to delete village. Try again later.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }finally {
      isLoading(false);
    }
  }


  updateForm( VillageEntity item){
    villageController.text = item.villageName;
    remarkController.text = item.remark ;
    selectedImagePath.value = item.image ;
  }

  // Method to choose an image
  Future<void> chooseImage() async {
    // Logic to choose image using any package like image_picker
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path; // Update observable variable
    }
  }

}
