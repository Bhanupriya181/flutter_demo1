import 'package:assesment_flutter/common/common_widgets.dart';
import 'package:assesment_flutter/screens/completed/complete_contrller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class CompleteScreen extends GetView<CompleteContrller> {
  final CompleteContrller completedController = Get.put(CompleteContrller()) ;

   CompleteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: completedController,
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
          title: const Text("Completed Screen",style: TextStyle(color: Colors.white,fontSize: 22),),
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
        body: completedController.isLoading.value ?
        Center(child: MyWidgets.showLoaderWithText("Please Wait"),)
            : completedController.completeEntityList.isNotEmpty ?
        ListView.builder(
          itemCount: completedController.completeEntityList.length,
          itemBuilder: (context, index) {
            var item = completedController.completeEntityList[index];
            return GestureDetector(
              onTap: (){
                completedController.onClickedCard(item);
              },
              child: Container(
                margin: const EdgeInsets.only(
                    top: 8, left: 8, right: 8),
                child: Card(
                  elevation: 2,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            GestureDetector(
                              onTap: () {
                                completedController.onDeleteClicked(item.id, index);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    bottom: 9,
                                    left: 9,
                                    top: 4,
                                    right: 4),
                                decoration: const BoxDecoration(
                                    color: Color(0xFFdc3545),
                                    borderRadius:
                                    BorderRadius.only(
                                        bottomLeft: Radius
                                            .circular(25),
                                        topRight:
                                        Radius.circular(
                                            8))),
                                child: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
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
                                    child: Text(item.blockId,
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
                                        item.blockName,
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
                      ],
                    ),
                  ),
                ),
              ),
            );
          },) :
        Center(child: Image.asset("assets/images/no_image.png"),),
      ),);
    });
  }

}