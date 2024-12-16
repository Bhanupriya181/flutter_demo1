import 'package:assesment_flutter/common/common_widgets.dart';
import 'package:assesment_flutter/screens/draft/draft_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class Draftscreen extends GetView<DraftController> {
  final DraftController draftController = Get.put(DraftController()) ;

   Draftscreen({super.key});
  @override
  Widget build(BuildContext context) {
   return GetBuilder(
     init: draftController,
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
         title: const Text("Draft Screen",style: TextStyle(color: Colors.white,fontSize: 22),),
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
       body: draftController.isLoading.value ?
       Center(child: MyWidgets.showLoaderWithText("Please Wait"),)
           : draftController.draftEntityList.isNotEmpty ?
       ListView.builder(
         itemCount: draftController.draftEntityList.length,
         itemBuilder: (context, index) {
           var item = draftController.draftEntityList[index];
           return GestureDetector(
             onTap: (){
               draftController.onClickedCard(item);
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
                               draftController.onDeleteClicked(item.id, index);
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
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Container(),
                           GestureDetector(
                             onTap: (){
                               draftController.syncDraftData(index,item);
                             },
                               child: Container(
                                 padding: const EdgeInsets.symmetric(horizontal: 19,vertical: 5),
                                 decoration: BoxDecoration(
                                   color: colorPrimary.withOpacity(0.8),
                                   borderRadius: const BorderRadius.only(
                                     topLeft: Radius.circular(25)
                                   )
                                 ),
                                 child: Center(child: MyWidgets.showText("Sync", Colors.white, 12, FontWeight.w500)),
                               ))
                         ],
                       )
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