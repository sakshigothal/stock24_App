import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/Pages/Dealers/Controller/dealer_controller.dart';
import 'package:stock24/Pages/Dealers/add_dealer_screen.dart';
import 'package:stock24/utility.dart';

class DealersScreen extends StatefulWidget {
  const DealersScreen({Key? key}) : super(key: key);

  @override
  State<DealersScreen> createState() => _DealersScreenState();
}

class _DealersScreenState extends State<DealersScreen> {
  final dealerController = Get.put(DealerController());
  @override
  void initState() {
    super.initState();
    // controller.getDealerData(context);
    dealerController.loadMoreDealer(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: customAppBar(context, 'Dealers'),
          body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          height: 56,
                          width:  getWidth(context) * 0.65,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: whiteColor,
                              shape: BoxShape.rectangle,
                              boxShadow: [
                                BoxShadow(
                                  color:const Color(0xff6C62A3).withOpacity(0.4),
                                  blurRadius: 4.0, // soften the shadow
                                  spreadRadius: 0.2, //extend the shadow
                                  offset: const Offset(
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
                                      fontSize: 18,
                                      color:const Color(0xff1B285C).withOpacity(0.1),
                                      fontFamily: 'Roboto-Regular'),
                                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0,)),
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
                      GetStorage().read('role') == 'dealer' ? SizedBox() : InkWell(
                        onTap: ()async {
                         Get.to(const AddDealerScreen(check: true,));
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
                  return dealerController.dealerLoading.value
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 20, left: 20, right: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  customText('Total Personals : ${dealerController.totalDealer}', 16, primaryColor, 'Roboto-Regular'),
                                  Row(
                                    children: [
                                      customText('Filter', 18, primaryColor, 'Roboto-Regular'),
                                      Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: SvgPicture.asset('assets/Common/filter_data.svg'))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                                height: getHeight(context) * 0.65,
                                width: getWidth(context),
                                child: dealersData())
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
          )),
    );
  }

  Widget dealersData() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: LazyLoadScrollView(
          isLoading: dealerController.isLoadingData.value,
          onEndOfPage: () async {
            dealerController.loadMoreDealer(context);
          },
          child: Scrollbar(
            child: ListView(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: dealerController.dealerList.length,
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
                                border: Border.all(color: whiteColor,)),
                            child: Stack(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding:const EdgeInsets.only(top: 19, left: 20),
                                      child: customText(dealerController.dealerList[index].firm,20,primaryColor,'Roboto-Medium'),
                                    )),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 50, left: 20),
                                  child: Row(
                                    children: [
                                      customText('Contact Person', 16,primaryColor, 'Roboto-Regular'),
                                      Padding(
                                          padding:const EdgeInsets.only(left: 9, right: 13),
                                          child: customText(':', 16, primaryColor, 'Roboto-Regular')),
                                      customText(dealerController.dealerList[index].contactPerson,16,primaryColor,'Roboto-Regular')
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 83, left: 20),
                                  child: Row(
                                    children: [
                                      customText('Mobile Number', 16,primaryColor, 'Roboto-Regular'),
                                      Padding(
                                          padding: const EdgeInsets.only(left: 9, right: 13),
                                          child: customText(':', 16, primaryColor, 'Roboto-Regular')),
                                      customText(dealerController.dealerList[index].mobileNumber, 16, primaryColor, 'Roboto-Regular')
                                    ],
                                  ),
                                ),
                                const Align(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 35, left: 20, right: 20),
                                      child: Divider(),
                                    )),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: GetStorage().read('role') =='company admin' ? MainAxisAlignment.spaceEvenly :
                                    MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          onPressed: ()async {
                                            Get.to(const AddDealerScreen(check: false),arguments: {
                                              'id': dealerController.dealerList[index].id,
                                              'firm':dealerController.dealerList[index].firm,
                                              'contact_person':dealerController.dealerList[index].contactPerson,
                                              'mobile_number':dealerController.dealerList[index].mobileNumber,
                                              'whatsapp_number':dealerController.dealerList[index].whatsappNumber,
                                              'email':dealerController.dealerList[index].email,
                                              'marketing_person': GetStorage().read('role')=='marketing person' ? GetStorage().read('marketing person')['name'] :
                                              dealerController.dealerList[index].marketingPersonName,
                                              'gst_no':dealerController.dealerList[index].gstNo,
                                              'pan_no':dealerController.dealerList[index].panNo,
                                              'address':dealerController.dealerList[index].address,
                                              'pincode':dealerController.dealerList[index].pincode,
                                              'bank_name':dealerController.dealerList[index].bankName,
                                              'branch':dealerController.dealerList[index].branch,
                                              'account_type':dealerController.dealerList[index].accountType,
                                              'account_no':dealerController.dealerList[index].accountNo,
                                              'ifsc_code':dealerController.dealerList[index].ifscCode,
                                              'upload_1':dealerController.dealerList[index].frontSidePath,
                                              'upload_2':dealerController.dealerList[index].backSidePath,
                                              'country':dealerController.dealerList[index].country,
                                              'state':dealerController.dealerList[index].state,
                                              'city':dealerController.dealerList[index].city
                                            });
                                          },
                                          child: customText('Edit', 16, checkBoxColor, 'Roboto-Regular')),
                                      GetStorage().read('role') =='company admin' ? TextButton(
                                          onPressed: () async {
                                            deleteAlert(dealerController.dealerList[index].id.toString());
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
                                        onTap: () async {
                                          userCall(dealerController.dealerList[index].mobileNumber);
                                        },
                                        child: SvgPicture.asset('assets/Common/call_icon.svg'),
                                      ),
                                    ))
                              ],
                            )),
                      );
                    }),
                dealerController.totalDealer.value == dealerController.dealerList.length ? const SizedBox()  :
                dealerController.isLoadingData.value
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
                            dealerController.deleteUser(context, id);
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
    dealerController.dealerList.clear();
    dealerController.page_no.value = 1;
    // dealerController.dealerLoading.value=false;
  }
}
