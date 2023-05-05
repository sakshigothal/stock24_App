
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/utility.dart';

import '../MarketingPersonals/Controller/marketingPersonal_controller.dart';

class MarketingPersonDropList extends StatefulWidget {
  const MarketingPersonDropList({Key? key}) : super(key: key);

  @override
  State<MarketingPersonDropList> createState() => _MarketingPersonDropListState();
}

class _MarketingPersonDropListState extends State<MarketingPersonDropList> {
  final marketingController = Get.find<GetMarketingPersonalsController>();
  @override
  void initState() {
    super.initState();
    marketingController.loadMoreHorizontal(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){
        return  marketingController.loading.value ?
        Container(
          height: getHeight(context),
          width: getWidth(context),
          child: Padding(padding: EdgeInsets.only(top: 30,bottom: 30,left: 20,right: 20),
          child: loadDropList()),
        ) :const Center(child: CircularProgressIndicator());
      })
    );
  }

  Widget loadDropList(){
    return Obx((){
      return LazyLoadScrollView(
        isLoading: marketingController.isLoadingData.value,
        onEndOfPage:()async{
          marketingController.loadMoreHorizontal(context);
        },
        child: Scrollbar(
          child: ListView(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: marketingController.getMarketingList.length,
                  itemBuilder: (ctx,index){
                    return Padding(padding: EdgeInsets.only(top: 15),
                      child: InkWell(
                        onTap: ()async{
                          print(marketingController.getMarketingList[index].id);
                          marketingController.selectedMarketingPersonId.value=marketingController.getMarketingList[index].id.toString();
                          marketingController.selectedMarketingPerson.value=marketingController.getMarketingList[index].name!;
                          Get.back();
                        /*  Get.to(AddDealerScreen(),arguments: {
                            'id': marketingController.getMarketingList[index].id,
                            'name': marketingController.getMarketingList[index].name
                          });*/
                          // Get.back(result: marketingController.getMarketingList[index].name);
                        },
                        child: Container(
                            height: 50,width: getWidth(context),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: primaryColor),
                                color: whiteColor
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15,bottom: 15,left: 15),
                              child: customText(marketingController.getMarketingList[index].name, 18, primaryColor, 'Roboto-Regular'),
                            )
                        ),
                      )
                    );
                  }),
              marketingController.isLoadingData.value
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
