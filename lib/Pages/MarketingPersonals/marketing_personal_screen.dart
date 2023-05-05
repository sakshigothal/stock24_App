import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/Pages/MarketingPersonals/Controller/marketingPersonal_controller.dart';
import 'package:stock24/Pages/MarketingPersonals/add_marketing_personal_screen.dart';
import 'package:stock24/utility.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final controller = Get.find<GetMarketingPersonalsController>();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    controller.loadMoreHorizontal(context);
    // controller.getMarketingPersonal(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: customAppBar(context, 'Marketing Personals'),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                                height: 56,
                                width: getWidth(context) * 0.65,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: whiteColor,
                                    shape: BoxShape.rectangle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xff6C62A3).withOpacity(0.4),
                                        blurRadius: 4.0, // soften the shadow
                                        spreadRadius: 0.2, //extend the shadow
                                        offset: const Offset(
                                          0.0, // Move to right 10  horizontally
                                          3.0, // Move to bottom 10 Vertically
                                        ),
                                      )
                                    ],
                                    border: Border.all(
                                      color: whiteColor,
                                    )),
                                child: Center(
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: TextFormField(
                                            cursorColor: primaryColor,
                                            decoration: InputDecoration(
                                                hintText: 'Search here',
                                                enabled: true,
                                                filled: true,
                                                fillColor: whiteColor,
                                                hintStyle: TextStyle(
                                                    fontSize: 16.0,
                                                    color:const Color(0xff1B285C).withOpacity(0.1),
                                                    fontFamily: 'Poppins Regular'),
                                                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                                                border: const OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                    borderSide: BorderSide(color: whiteColor, width: 0.1)),
                                                enabledBorder: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                  borderSide: BorderSide(color: whiteColor, width: 0.1)),
                                                focusedBorder: const OutlineInputBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                  borderSide: BorderSide(color: whiteColor, width: 0.1)),
                                                errorBorder:
                                                    const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                  borderSide: BorderSide(color: whiteColor, width: 0.1)),
                                                focusedErrorBorder: const OutlineInputBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                    borderSide: BorderSide(color: whiteColor, width: 0.1)))))))),
                        InkWell(
                          onTap: () async{
                            // setState(() {
                            controller.updateData.value = false;
                            // });
                             controller.getAreaList(context);
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) => const AddStockData(add: true,)));
                          },
                          child: Container(
                            height: 56,
                            width: getWidth(context) * 0.21,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: primaryColor),
                            child: Center(
                                child: customText('ADD', 20, whiteColor, 'Roboto-Regular')),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    return controller.loading.value
                        ? Column(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 20, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  customText('Total Personals  : ${controller.total_records}', 18, primaryColor, 'Roboto-Regular'),
                                  Row(
                                    children: [
                                      customText('Filter', 18, primaryColor, 'Roboto-Regular'),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: SvgPicture.asset('assets/Common/filter_data.svg'),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                                height: getHeight(context) * 0.65,
                                width: getWidth(context),
                                child: details())
                          ])
                        :Container(
                            height: getHeight(context) * 0.65,
                            width: getWidth(context),
                              child: const Center(
                                child: CircularProgressIndicator(),
                            ),
                        );
                  })
                ],
              ),
            )));
  }

  Widget details() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: LazyLoadScrollView(
          isLoading: controller.isLoadingData.value,
          onEndOfPage: () async {
            await controller.loadMoreHorizontal(context);
          },
          child: Scrollbar(
            child: ListView(
              children: [
                ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: controller.getMarketingList.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: whiteColor,
                              shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(
                                  color:const Color(0xff6C62A3).withOpacity(0.4),
                                  blurRadius: 4.0, // soften the shadow
                                  spreadRadius: 0.2, //extend the shadow
                                  offset:const Offset(
                                    0.0, // Move to right 10  horizontally
                                    3.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                              border: Border.all(color: whiteColor,)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 18, left: 15, right: 15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customText(controller.getMarketingList[index].name, 20, primaryColor, 'Roboto-Medium'),
                                  Padding(padding: const EdgeInsets.only(top: 8, bottom: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        customText(controller.getMarketingList[index].designation, 16, primaryColor, 'Roboto-Regular'),
                                        Row(
                                          children: [
                                            SvgPicture.asset('assets/Common/mobile_icon.svg'),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 10),
                                              child: customText(controller.getMarketingList[index].mobileNumber, 16, primaryColor, 'Roboto-Regular'),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      customText(controller.getMarketingList[index].area, 16, primaryColor, 'Roboto-Regular'),
                                      Row(
                                        children: [
                                          SvgPicture.asset('assets/Common/whatsapp_icon.svg'),
                                          Padding(padding:const EdgeInsets.only(left: 10),
                                            child: customText(controller.getMarketingList[index].whatsappNumber, 16, primaryColor, 'Roboto-Regular'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 15, left: 20, right: 20),
                                    child: Divider(),
                                  ),
                                  Row(
                                    mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            // setState(() {
                                            controller.updateData.value = true;
                                            // });
                                            controller.getAreaList(context);

                                            Get.to(const AddStockData(add: false,),
                                                arguments: {
                                                  'id': controller.getMarketingList[index].id.toString(),
                                                  'name': controller.getMarketingList[index].name,
                                                  'mobile_number': controller.getMarketingList[index].mobileNumber,
                                                  'whatsapp_number': controller.getMarketingList[index].whatsappNumber,
                                                  'designation': controller.getMarketingList[index].designation,
                                                  'area': controller.getMarketingList[index].area
                                                });
                                          },
                                          child: customText('Edit', 16, checkBoxColor, 'Roboto-Regular')),
                                     GetStorage().read('role') =='company admin' ? TextButton(
                                          onPressed: () async {
                                            deleteAlert(controller.getMarketingList.first.id.toString());
                                            // controller.deleteUser(
                                            //     context,
                                            //     controller.maketingPersonalData.first
                                            //         .data!.result![index].id!
                                            //         .toString());
                                          },
                                          child: customText('Delete', 16, checkBoxColor, 'Roboto-Regular')) : SizedBox(),
                                    ],
                                  )
                                ]),
                          ),
                        ),
                      );
                    }),
                controller.getMarketingList.length == controller.total_records.value ? const SizedBox() :
              controller.isLoadingData.value ?
              Container(height: getHeight(context)*0.05,
                  child:const Center(
                      child: CircularProgressIndicator()))
                  : const SizedBox(),
                /*controller.isLoadingData.value == false ?
                Center(
                  child: customText('No more data', 15, Colors.grey, 'Roboto-Regular'),
                ) : const SizedBox()*/
                // controller.isLoadingData.value ? CircularProgressIndicator() : SizedBox()
              ],
            ),
          ),
        ),
      );
    });
  }

  deleteAlert(id) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            contentPadding: const EdgeInsets.only(left: 20, right: 20),
            content: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customText('Are you sure you want to Delete?', 18, primaryColor, 'Roboto-Regular'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            controller.deleteUser(context, id);
                            //  showLoading(context);
                            Get.back();
                          },
                          child: customText('Ok', 18, primaryColor, 'Roboto-Regular')),
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: customText('Cancel', 18, primaryColor, 'Roboto-Regular'))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
