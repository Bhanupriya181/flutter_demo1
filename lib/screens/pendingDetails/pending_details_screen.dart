import 'dart:io';

import 'package:assesment_flutter/common/common_widgets.dart';
import 'package:assesment_flutter/screens/pendingDetails/pending_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class PendingDetailsScreen extends GetView<PendingDetailsController> {
   PendingDetailsScreen({super.key});
   final PendingDetailsController pendingDetailsController = Get.put(PendingDetailsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: pendingDetailsController,
        builder: (_){
      return Obx(() => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: colorPrimary,
          shape: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
            borderSide: BorderSide.none,
          ),
          title: const Text("Details Screen",style: TextStyle(color: Colors.white,fontSize: 22),),
          leading: GestureDetector(
            onTap: (){
              Get.back();
            },child: Container(
            width: 40,
            padding: const EdgeInsets.all(18.0),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 22,
            ),
          ),),

        ),
        body: pendingDetailsController.isLoading.value ?
            Center(child: MyWidgets.showLoader(),)
            :Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.zero,
                margin: const EdgeInsets.only(top: 15),
                child: Card(
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(
                      color: pendingDetailsController.isCompletedEntity.value ? Colors.green.shade800 :colorPrimary,
                      width: 2
                    )
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 4),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(
                                              context)
                                              .size
                                              .width *
                                              0.35,
                                          child: const Text(
                                              "District Id",
                                              textAlign:
                                              TextAlign
                                                  .left,
                                              style: TextStyle(
                                                  fontFamily:
                                                  'Nunito',
                                                  fontSize:
                                                  14.0,
                                                  color: Colors
                                                      .black,
                                                  fontWeight:
                                                  FontWeight
                                                      .w600)),
                                        ),
                                        const Text(":",
                                            textAlign:
                                            TextAlign.left,
                                            style: TextStyle(
                                                fontFamily:
                                                'Nunito',
                                                fontSize: 14.0,
                                                color:
                                                colorPrimary,
                                                fontWeight:
                                                FontWeight
                                                    .w600))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(pendingDetailsController.entity.blockId,
                                        textAlign:
                                        TextAlign.end,
                                        style: const TextStyle(
                                            fontFamily:
                                            'Nunito',
                                            fontSize: 15.0,
                                            color: colorPrimary,
                                            fontWeight:
                                            FontWeight
                                                .bold)),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(
                                              context)
                                              .size
                                              .width *
                                              0.35,
                                          child: const Text(
                                              "Block Name",
                                              textAlign:
                                              TextAlign
                                                  .left,
                                              style: TextStyle(
                                                  fontFamily:
                                                  'Nunito',
                                                  fontSize:
                                                  14.0,
                                                  color: Colors
                                                      .black,
                                                  fontWeight:
                                                  FontWeight
                                                      .w600)),
                                        ),
                                        const Text(":",
                                            textAlign:
                                            TextAlign.left,
                                            style: TextStyle(
                                                fontFamily:
                                                'Nunito',
                                                fontSize: 14.0,
                                                color:
                                                colorPrimary,
                                                fontWeight:
                                                FontWeight
                                                    .w600))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        pendingDetailsController.entity.blockName,
                                        textAlign:
                                        TextAlign.end,
                                        style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        )),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(
                                              context)
                                              .size
                                              .width *
                                              0.35,
                                          child: const Text(
                                              "No of Village",
                                              textAlign:
                                              TextAlign
                                                  .left,
                                              style: TextStyle(
                                                  fontFamily:
                                                  'Nunito',
                                                  fontSize:
                                                  14.0,
                                                  color: Colors
                                                      .black,
                                                  fontWeight:
                                                  FontWeight
                                                      .w600)),
                                        ),
                                        const Text(":",
                                            textAlign:
                                            TextAlign.left,
                                            style: TextStyle(
                                                fontFamily:
                                                'Nunito',
                                                fontSize: 14.0,
                                                color:
                                                colorPrimary,
                                                fontWeight:
                                                FontWeight
                                                    .w600))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                        pendingDetailsController.villageList.length.toString(),
                                        textAlign:
                                        TextAlign.end,
                                        style: const TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        )),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(
                                              context)
                                              .size
                                              .width *
                                              0.35,
                                          child: const Text(
                                              "Status",
                                              textAlign:
                                              TextAlign
                                                  .left,
                                              style: TextStyle(
                                                  fontFamily:
                                                  'Nunito',
                                                  fontSize:
                                                  14.0,
                                                  color: Colors
                                                      .black,
                                                  fontWeight:
                                                  FontWeight
                                                      .w600)),
                                        ),
                                        const Text(":",
                                            textAlign:
                                            TextAlign.left,
                                            style: TextStyle(
                                                fontFamily:
                                                'Nunito',
                                                fontSize: 14.0,
                                                color:
                                                colorPrimary,
                                                fontWeight:
                                                FontWeight
                                                    .w600))
                                      ],
                                    ),
                                  ),
                                  const Expanded(
                                    child: Text(
                                        "Pending",
                                        textAlign:
                                        TextAlign.end,
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 15.0,
                                          color: Colors.black,
                                        )),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              MyWidgets.showText("VILLAGE LIST", Colors.black, 20, FontWeight.w600),
              const SizedBox(height: 20,),
              pendingDetailsController.isCompletedEntity.value ?
              Container() :Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    GestureDetector(
                      onTap: (){
                        showAddVillageForm(context,0,index: 0,id: 1);
                      },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          child: Row(
                              children: [
                            MyWidgets.showText("ADD NEW VILLAGE", Colors.green, 18, FontWeight.w600),
                            const Icon(Icons.add,color: Colors.green,size: 27,)
                              ]),
                        )),
                  ]),
              Expanded(
                  child: ListView.builder(
                    itemCount: pendingDetailsController.villageList.length,
                      itemBuilder: (context, index) {
                      var item = pendingDetailsController.villageList[index] ;
                        return Container(
                          margin: const EdgeInsets.only(
                              top: 8, left: 8, right: 8),
                          width: double.infinity,
                          child: Card(
                            elevation: 2,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                pendingDetailsController.isCompletedEntity.value ?
                                Container() :Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap:()async{
                                        pendingDetailsController.updateForm(item);
                                        showAddVillageForm(context, 1, index: index, id: item.id);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                                        decoration: const BoxDecoration(
                                          color: Colors.blueGrey,
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20))
                                        ),
                                        child: Center(child: MyWidgets.showText("edit", Colors.white, 13, FontWeight.w500)),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        pendingDetailsController.wiiPopDialog(index, item.id);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                                        decoration: const BoxDecoration(
                                            color: Colors.redAccent,
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20))
                                        ),
                                        child: Center(child: MyWidgets.showText("delete", Colors.white, 13, FontWeight.w500)),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap:(){

                                      },
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        padding: const EdgeInsets.all(8.0),
                                        child: item.image.isNotEmpty ?
                                            Image.file(File(item.image),fit: BoxFit.cover,)
                                            :Image.asset("assets/images/no_image.png"),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.25,
                                                        child: const Text(
                                                            "Village Name",
                                                            textAlign:
                                                            TextAlign
                                                                .left,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'Nunito',
                                                                fontSize:
                                                                14.0,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                      ),
                                                      const Text(":",
                                                          textAlign:
                                                          TextAlign.left,
                                                          style: TextStyle(
                                                              fontFamily:
                                                              'Nunito',
                                                              fontSize: 14.0,
                                                              color:
                                                              colorPrimary,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(item.villageName,
                                                      textAlign:
                                                      TextAlign.end,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                          'Nunito',
                                                          fontSize: 15.0,
                                                          color: colorPrimary,
                                                          fontWeight:
                                                          FontWeight
                                                              .bold)),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 3,),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.25,
                                                        child: const Text(
                                                            "Block Name",
                                                            textAlign:
                                                            TextAlign
                                                                .left,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'Nunito',
                                                                fontSize:
                                                                14.0,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                      ),
                                                      const Text(":",
                                                          textAlign:
                                                          TextAlign.left,
                                                          style: TextStyle(
                                                              fontFamily:
                                                              'Nunito',
                                                              fontSize: 14.0,
                                                              color:
                                                              colorPrimary,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      pendingDetailsController.entity.blockName,
                                                      textAlign:
                                                      TextAlign.end,
                                                      style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 15.0,
                                                        color: Colors.black,
                                                      )),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 3,),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.25,
                                                        child: const Text(
                                                            "Date",
                                                            textAlign:
                                                            TextAlign
                                                                .left,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'Nunito',
                                                                fontSize:
                                                                14.0,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                      ),
                                                      const Text(":",
                                                          textAlign:
                                                          TextAlign.left,
                                                          style: TextStyle(
                                                              fontFamily:
                                                              'Nunito',
                                                              fontSize: 14.0,
                                                              color:
                                                              colorPrimary,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      item.date,
                                                      textAlign:
                                                      TextAlign.end,
                                                      style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 15.0,
                                                        color: Colors.black,
                                                      )),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 3,),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width *
                                                            0.25,
                                                        child: const Text(
                                                            "Remark",
                                                            textAlign:
                                                            TextAlign
                                                                .left,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                'Nunito',
                                                                fontSize:
                                                                14.0,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                                      ),
                                                      const Text(":",
                                                          textAlign:
                                                          TextAlign.left,
                                                          style: TextStyle(
                                                              fontFamily:
                                                              'Nunito',
                                                              fontSize: 14.0,
                                                              color:
                                                              colorPrimary,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                      item.remark,
                                                      textAlign:
                                                      TextAlign.end,
                                                      style: const TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 15.0,
                                                        color: Colors.black,
                                                      )),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                  )),
              pendingDetailsController.isCompletedEntity.value ? Container() :Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      pendingDetailsController.onSubmit();
                    },
                    child: Container(
                      width: Get.width*0.8,
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                      decoration:  BoxDecoration(
                        color: Colors.green.shade700,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Center(child: MyWidgets.showText("Submit", Colors.white, 17, FontWeight.w500)),
                    ),
                  ),
                  pendingDetailsController.isDraftEntity.value? Container() :GestureDetector(
                    onTap: ()async{
                      await pendingDetailsController.onSave();
                    },
                    child: Container(
                      width: Get.width*0.8,
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                      decoration:  BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Center(child: MyWidgets.showText("Save", Colors.white, 17, FontWeight.w500)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),);
    });
  }

   Future<void> showAddVillageForm(BuildContext context, int type,{ required int index, required int? id }) async{
     showModalBottomSheet(
       context: context,
       isScrollControlled: true, // Allow the sheet to take full height if necessary
       shape: const RoundedRectangleBorder(
         borderRadius: BorderRadius.only(
           topLeft: Radius.circular(20),
           topRight: Radius.circular(20),
         ),
       ),
       builder: (context) {
         return GestureDetector(
           onTap: (){
             FocusScope.of(context).unfocus();
           },
           child: Padding(
             padding: EdgeInsets.only(
               bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for the keyboard
             ),
             child: Container(
               padding: const EdgeInsets.all(16),
               decoration: const BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(20),
                   topRight: Radius.circular(20),
                 ),
               ),
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   // Village Name Field
                   TextFormField(
                     keyboardType: TextInputType.text,
                     controller: pendingDetailsController.villageController,
                     decoration: InputDecoration(
                       border: const OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(8))
                       ),
                       hintText: "Add Village",
                       hintStyle: TextStyle(color: Colors.grey[600],fontSize: 13),
                       focusedBorder: const OutlineInputBorder(
                         borderRadius: BorderRadius.all(Radius.circular(8)),
                         borderSide: BorderSide(
                           color:  colorPrimary,
                           width: 2.0,
                         ),
                       ),
                     ),
                   ),
                   const SizedBox(height: 16),
                   // Remark Field
                   TextFormField(
                     keyboardType: TextInputType.text,
                     controller: pendingDetailsController.remarkController,
                     decoration: InputDecoration(
                       border: const OutlineInputBorder(
                           borderRadius: BorderRadius.all(Radius.circular(8))
                       ),
                       hintText: "Remark",
                       hintStyle: TextStyle(color: Colors.grey[600],fontSize: 13),
                       focusedBorder: const OutlineInputBorder(
                         borderRadius: BorderRadius.all(Radius.circular(8)),
                         borderSide: BorderSide(
                           color:  colorPrimary,
                           width: 2.0,
                         ),
                       ),
                     ),
                   ),
                   const SizedBox(height: 16),
                   // Image Container and Choose Image Button
                   Row(
                     children: [
                       // Image Container
                       Obx(() => Container(
                         width: 200,
                         height: 200,
                         decoration: BoxDecoration(
                           border: Border.all(color: Colors.grey),
                           borderRadius: BorderRadius.circular(8),
                         ),
                         child: pendingDetailsController.selectedImagePath.value.isNotEmpty
                             ? Image.file(
                           File(pendingDetailsController.selectedImagePath.value),
                           fit: BoxFit.cover,
                         )
                             :const Center(child: Text("No Image")), // Placeholder image
                       ),),
                       const SizedBox(width: 16),
                       // Choose Image Button
                       GestureDetector(
                         onTap: (){
                           pendingDetailsController.chooseImage();
                         },
                         child: Container(
                           padding: const EdgeInsets.all(13),
                           decoration: BoxDecoration(
                             color: Colors.green.shade800,
                             borderRadius: const BorderRadius.all(Radius.circular(8)),
                           ),
                           child: MyWidgets.showText("Choose Image", Colors.white, 13, FontWeight.w500),
                         ),
                       )
                     ],
                   ),
                   const SizedBox(height: 16),

                   // Submit Button
                   GestureDetector(
                     onTap: (){
                       if(type == 0){
                         pendingDetailsController.addNewVillage();
                       } else {
                         pendingDetailsController.updateVillage(index, id) ;
                       }
                     },
                     child: Container(
                       padding: const EdgeInsets.all(10),
                       width: double.infinity,
                       decoration: const BoxDecoration(
                         color: colorPrimary,
                         borderRadius: BorderRadius.all(Radius.circular(8)),
                       ),
                       child: Center(child: MyWidgets.showText("Submit", Colors.white, 13, FontWeight.w500)),
                     ),
                   )
                 ],
               ),
             ),
           ),
         );
       },
     );
   }


}