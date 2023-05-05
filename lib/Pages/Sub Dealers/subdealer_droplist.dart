import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:stock24/Pages/Dealers/Controller/dealer_controller.dart';
import 'package:stock24/Pages/Sub%20Dealers/Controller/subdealer_controller.dart';

import '../../Colors/colors.dart';
import '../../utility.dart';
class DealerDropList extends StatefulWidget {
  const DealerDropList({Key? key}) : super(key: key);

  @override
  State<DealerDropList> createState() => _DealerDropListState();
}

class _DealerDropListState extends State<DealerDropList> {
  final dealerController=Get.put(DealerController());
  final subDealerController=Get.put(SubDealerController());
  List dealers=[];
  @override
  void initState() {
    super.initState();
    dealerController.loadMoreDealer(context);
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
          body: Obx((){
            return  dealerController.dealerLoading.value ?
            Container(
              height: getHeight(context),
              width: getWidth(context),
              child: Padding(padding: EdgeInsets.only(top: 20,bottom: 30,left: 20,right: 20),
                  child: Column(
                    children: [
                      Container(
                        height: getHeight(context)*0.80,
                        width: getWidth(context),
                        child: loadDropList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: ()async{
                                print(subDealerController.selectedDealerList.toString());
                                Get.back();
                                // subDealerController.selectedDealerList.add({'id':});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(padding:const EdgeInsets.only(top: 15,bottom: 15,left: 25,right: 25),
                                  child: customText('Apply', 18, whiteColor, 'Roboto-Regular'),),
                              ),
                            ),
                            InkWell(
                              onTap: ()async{
                                print(subDealerController.selectedDealerList.toString());
                                Get.back();
                                // subDealerController.selectedDealerList.add({'id':});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(padding:const EdgeInsets.only(top: 15,bottom: 15,left: 25,right: 25),
                                  child: customText('Cancel', 18, whiteColor, 'Roboto-Regular'),),
                              ),
                            ),
                          ],
                        )
                      )
                    ],
                  )
              ),
            ) :const Center(child: CircularProgressIndicator());
          })
      ),
    );
  }

  Widget loadDropList(){
    return Obx((){
      return LazyLoadScrollView(
        isLoading: dealerController.isLoadingData.value,
        onEndOfPage:()async{
          dealerController.loadMoreDealer(context);
        },
        child: Scrollbar(
          child: ListView(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dealerController.dealerList.length,
                  itemBuilder: (ctx,index){
                    return Padding(padding: EdgeInsets.only(top: 15),
                        child: Container(
                              height: 50,width: getWidth(context),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: primaryColor),
                                  color: whiteColor
                              ),
                              child: Obx(() => Padding(
                                padding: const EdgeInsets.only(top: 15,bottom: 15,left: 15),
                                child: Row(
                                  children: [
                                    Padding(padding: const EdgeInsets.only(right: 30),
                                        child: Checkbox(
                                            value: dealerController.booleanList[index], onChanged: (val){
                                          dealerController.booleanList[index]=true;
                                          dealerController.booleanList[index]=val;
                                          if(dealerController.booleanList[index]==true){
                                            subDealerController.selectedDealerList.add({'id': dealerController.dealerList[index].id.toString(),
                                            'dealerName':dealerController.dealerList[index].firm});
                                          }

                                        })),
                                    customText(dealerController.dealerList[index].firm, 18, primaryColor, 'Roboto-Regular')
                                  ],
                                ),
                              ))
                          ),

                    );
                  }),
              dealerController.isLoadingData.value
                  ? Container(
                  height: getHeight(context) * 0.05,
                  child: Center(child: CircularProgressIndicator()))
                  : SizedBox()
            ],
          ),
        ),
      );
    });
  }
}
