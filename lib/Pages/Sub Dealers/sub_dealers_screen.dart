import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/Pages/Sub%20Dealers/Controller/subdealer_controller.dart';
import 'package:stock24/Pages/Sub%20Dealers/add_sub_dealer_screen.dart';
import 'package:stock24/utility.dart';

class SubDealersScreen extends StatefulWidget {
  const SubDealersScreen({Key? key}) : super(key: key);

  @override
  State<SubDealersScreen> createState() => _SubDealersScreenState();
}

class _SubDealersScreenState extends State<SubDealersScreen> {
  final controller = Get.put(SubDealerController());
  var firmName;
  var contactPerson;
  var mobileNumber;
  var whatsAppNumber;
  var area;
  var pincode;
  var frontSide;
  var backSide;
  @override
  void initState() {
    super.initState();
    controller.loadMoreSubDealer(context);
    // firmName=Get.arguments['firmname'];
    // contactPerson=Get.arguments['contactPerson'];
    // mobileNumber=Get.arguments['mobileNumber'];

    // controller.getSubDealerData(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: customAppBar(context, 'Sub Dealers'),
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
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: TextFormField(
                                  cursorColor: primaryColor,
                                  decoration: InputDecoration(
                                    hintText: 'Search here',
                                    enabled: true,
                                    filled: true,
                                    fillColor: whiteColor /*Colors.red*/,
                                    hintStyle: TextStyle(
                                        fontSize: 16.0,
                                        color: const Color(0xff1B285C).withOpacity(0.1),
                                        fontFamily: 'Roboto-Regular'),
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
                                    errorBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        borderSide: BorderSide(color: whiteColor, width: 0.1)),
                                    focusedErrorBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                            borderSide: BorderSide(color: whiteColor, width: 0.1)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: ()async {
                            Get.to(const AddSubDealerScreen(check: true,));
                          },
                          child: Container(
                            height: 56,
                            width: getWidth(context) * 0.21,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: primaryColor),
                            child: Center(
                                child: customText('ADD', 20, whiteColor, 'Skia-Regular')),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    return controller.subDealerDataLoading.value
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, bottom: 20, left: 20, right: 20),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      customText(
                                          'Total Sub Dealers  : ${controller.totalSubDealer}', 18, primaryColor, 'Roboto-Regular'),
                                      Row(
                                        children: [
                                          customText('Filter', 18, primaryColor, 'Roboto-Regular'),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: SvgPicture.asset('assets/Common/filter_data.svg'),
                                          )
                                        ],
                                      )
                                    ]),
                              ),
                              Container(
                                  height: getHeight(context) * 0.65,
                                  width: getWidth(context),
                                  child: subDealersData())
                            ],
                          )
                        : Container(
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

  Widget subDealersData() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: LazyLoadScrollView(
          isLoading: controller.isLoadingData.value,
          onEndOfPage: () async {
            await controller.loadMoreSubDealer(context);
          },
          child: Scrollbar(
            child: ListView(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: controller.subDealerList.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                            width: getWidth(context),
                            height: 163,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: whiteColor,
                                shape: BoxShape.rectangle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff6C62A3).withOpacity(0.4),
                                    blurRadius: 4.0, // soften the shadow
                                    spreadRadius: 0.2, //extend the shadow
                                    offset:const Offset(
                                      0.0, // Move to right 10  horizontally
                                      4.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                                border: Border.all(color: whiteColor)),
                            child: Stack(children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:const EdgeInsets.only(top: 19, left: 20),
                                    child: customText(
                                        controller.subDealerList[index].firm, 20, primaryColor, 'Roboto-Medium'),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 50, left: 20),
                                child: Row(
                                  children: [
                                    customText('Contact Person', 16, primaryColor, 'Roboto-Regular'),
                                    Padding(padding: const EdgeInsets.only(left: 9, right: 13),
                                        child: customText(':', 16, primaryColor, 'Roboto-Regular')),
                                    customText(controller.subDealerList[index].contactPerson, 16, primaryColor, 'Roboto-Regular')
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 83, left: 20),
                                child: Row(
                                  children: [
                                    customText('Mobile Number', 16, primaryColor, 'Roboto-Regular'),
                                    Padding(padding: const EdgeInsets.only(left: 9, right: 13),
                                        child: customText(':', 16, primaryColor, 'Roboto-Regular')),
                                    customText(controller.subDealerList[index].mobileNumber, 16, primaryColor, 'Roboto-Regular')
                                  ],
                                ),
                              ),
                              const Align(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 35, left: 20, right: 20),
                                    child: Divider(),
                                  )),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: GetStorage().read('role') =='company admin' ? MainAxisAlignment.spaceEvenly :
                                  MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: () async{
                                          Get.to(
                                              const AddSubDealerScreen(check: false),
                                              arguments: {
                                                'id': controller.subDealerList[index].id,
                                                'firm': controller.subDealerList[index].firm,
                                                'contact_person': controller.subDealerList[index].contactPerson,
                                                'area': controller.subDealerList[index].area,
                                                'mobile_number': controller.subDealerList[index].mobileNumber,
                                                'whatsapp_number': controller.subDealerList[index].whatsappNumber,
                                                'pincode': controller.subDealerList[index].pincode,
                                                'dealer[0]': 165,
                                                'upload_1': controller.subDealerList[index].frontSidePath,
                                                'upload_2': controller.subDealerList[index].backSidePath
                                              });
                                        },
                                        child: customText('Edit', 16, checkBoxColor, 'Roboto-Regular')),
                                    GetStorage().read('role') =='company admin' ? TextButton(
                                        onPressed: () async {
                                          deleteAlert(controller.subDealerList[index].id.toString());
                                        },
                                        child: customText('Delete', 16, checkBoxColor, 'Roboto-Regular')) : SizedBox(),
                                  ],
                                ),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                      padding: const EdgeInsets.only(bottom: 55, right: 20),
                                      child: InkWell(
                                        onTap: () {
                                          userCall(controller.subDealerList[index].mobileNumber);
                                        },
                                        child: SvgPicture.asset('assets/Common/call_icon.svg'),
                                      )))
                            ])),
                      );
                    }),
                controller.totalSubDealer.value == controller.subDealerList.length ? const SizedBox() :
                controller.isLoadingData.value
                    ? Container(
                        height: getHeight(context) * 0.05,
                        child:const Center(child: CircularProgressIndicator()))
                    :const SizedBox()
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
            contentPadding:const EdgeInsets.only(left: 20, right: 20),
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

  @override
  void dispose() {
    super.dispose();
    controller.subDealerList.clear();
    controller.page_no.value = 1;
  }
}
