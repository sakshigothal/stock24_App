import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/Pages/Memo/controller/memo_controller.dart';
import 'package:stock24/utility.dart';

import '../Dealers/Controller/dealer_controller.dart';

class SampleMemoViewScreen extends StatefulWidget {
  const SampleMemoViewScreen({Key? key}) : super(key: key);

  @override
  State<SampleMemoViewScreen> createState() => _SampleMemoViewScreenState();
}

class _SampleMemoViewScreenState extends State<SampleMemoViewScreen> {
  final memoController=Get.find<MemoController>();
  final dealerController=Get.find<DealerController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: customAppBar(context, 'Sample Memo'),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      resizeToAvoidBottomInset: false,
      /*floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 55,
              width: getWidth(context) * 0.40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: primaryColor),
              child:const Center(
                child: Text(
                  'Edit',
                  style: TextStyle(fontSize: 22, color: whiteColor),
                ),
              ),
            ),
            Container(
              height: 55,
              width: getWidth(context) * 0.40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: primaryColor),
              child:const Center(
                child: Text(
                  'Delete',
                  style: TextStyle(fontSize: 22, color: whiteColor),
                ),
              ),
            ),
          ],
        ),
      ),*/
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                customText('Advance Trader', 20, primaryColor, 'Roboto-Medium'),customText('26-Oct-2021', 14, primaryColor, 'Roboto-Regular')
              ],),
            ),
            Padding(padding:const EdgeInsets.only(left: 20,top: 25),child: customText('To,', 20, primaryColor, 'Roboto-Medium'),),
            Padding(padding:const EdgeInsets.only(top: 12,left: 20,right: 20),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [customText('Subdealers', 18, primaryColor, 'Roboto-Regular'),
                TextButton(onPressed: ()async{
                  showDialog(context: context, builder: (ctx){
                    return AlertDialog(
                      contentPadding: const EdgeInsets.fromLTRB(0,0,0,0),
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      content: Container(
                        height: getHeight(context)*0.40,
                        width: getWidth(context),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        child: GetStorage().read('role')== 'dealer' ?
                        Padding(padding:const EdgeInsets.only(left: 35,top: 10),
                            child: customText(GetStorage().read('dealer')['name'], 15, primaryColor, 'Roboto-Regular')) :
                        Obx((){
                          return Padding(padding:const EdgeInsets.only(top: 10,bottom: 10),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: dealerController.selectedDealers.length,
                            itemBuilder: (ctx,index){
                              return Padding(padding:const EdgeInsets.only(left: 35),
                                  child: customText(dealerController.selectedDealers[index]['subdealerName'], 15, primaryColor, 'Roboto-Regular'));
                            },
                            separatorBuilder: (ctx,sep){
                              return Padding(padding: const EdgeInsets.only(top: 10,bottom: 10,left: 15,right: 15),
                                  child:showDottedDash());
                            },));
                        })
                      ),
                    );
                  });
                }, child: customText('View', 18, checkBoxColor, 'Roboto-Regular'))

            ])),
            Padding(padding:const EdgeInsets.only(top: 15,bottom: 22),child: showDottedDash(),),
           sampleMemoData(),
            showDottedDash(),Padding(padding:const EdgeInsets.only(right: 20,top: 11,bottom: 11),child: Row(mainAxisAlignment: MainAxisAlignment.end,children: [
              customText('Total', 18, primaryColor, 'Roboto-Regular'),Padding(padding:const
              EdgeInsets.only(left: 77),child: customText('${memoController.totalPcs} Pcs', 18, primaryColor, 'Roboto-Regular'),)
            ],),),
            showDottedDash(),

            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 40,bottom: 30),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 55,
                    width: getWidth(context) * 0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: primaryColor),
                    child:const Center(
                      child: Text(
                        'Edit',
                        style: TextStyle(fontSize: 22, color: whiteColor),
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    width: getWidth(context) * 0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), color: primaryColor),
                    child:const Center(
                      child: Text(
                        'Delete',
                        style: TextStyle(fontSize: 22, color: whiteColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget sampleMemoData(){
    return  Obx((){
      return  ListView.builder(
        physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: memoController.selecredMemoList.length,
          itemBuilder: (ctx,index){
            return Padding(
              padding: const EdgeInsets.only(left: 20,right:20,bottom: 35),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Flexible(child: customText(memoController.selecredMemoList[index]['productName'], 18, primaryColor, 'Roboto-Regular'),),
                Row(children: [
                  customText(memoController.selecredMemoList[index]['size'], 18, primaryColor, 'Roboto-Regular'),
                  Padding(padding:const EdgeInsets.only(left: 34),child:
                  customText('${memoController.selecredMemoList[index]['qty']} Pcs', 18, primaryColor, 'Roboto-Regular'),)],)
              ],),
            );
          });
    });
  }
}
