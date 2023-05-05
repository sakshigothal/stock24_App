import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/Pages/Sub%20Dealers/Controller/subdealer_controller.dart';
import 'package:stock24/Pages/Sub%20Dealers/subdealer_droplist.dart';
import 'package:stock24/utility.dart';

import '../MarketingPersonals/Controller/marketingPersonal_controller.dart';

class AddSubDealerScreen extends StatefulWidget {
  final check;
  const AddSubDealerScreen({Key? key, this.check}) : super(key: key);

  @override
  State<AddSubDealerScreen> createState() => _AddSubDealerScreenState();
}

class _AddSubDealerScreenState extends State<AddSubDealerScreen> {
  final controller = Get.put(SubDealerController());
  final marketingController = Get.put(GetMarketingPersonalsController());
  String? _chosenValue;
  var id;
  List lst=[];
  @override
  void initState() {
    super.initState();
    marketingController.getAreaList(context);
    if (!widget.check) {
      id = Get.arguments['id'];
      controller.firmName.value.text = Get.arguments['firm'];
      controller.contactPerson.value.text = Get.arguments['contact_person'];
      controller.mobileNumber.value.text = Get.arguments['mobile_number'];
      controller.whatsAppNumber.value.text = Get.arguments['whatsapp_number'];
      controller.pincode.value.text = Get.arguments['pincode'];
      _chosenValue = Get.arguments['area'];
      controller.pickedImage1.value = Get.arguments['upload_1'];
      controller.pickedImage2.value = Get.arguments['upload_2'];
      print('user id -----> ${id.runtimeType}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: customAppBar(context, 'Add Sub Dealer'),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textField('Enter Firm Name *', controller.firmName.value,TextInputType.text),
            textField('Contact Person *', controller.contactPerson.value,TextInputType.text),
            textField('Mobile Number *', controller.mobileNumber.value,TextInputType.number),
            textField('WhatsApp Number *', controller.whatsAppNumber.value,TextInputType.number),
            Obx(() {
              return marketingController.areaLoding.value
                  ? Container(
                      height: 60,
                      width: getWidth(context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor, width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            style: const TextStyle(color: primaryColor),
                            value: _chosenValue,
                            hint: customText('Area *', 18,Color(0xff312D2D).withOpacity(0.2),'Roboto-Regular'),
                            icon: SvgPicture.asset('assets/Common/downArrow.svg'),
                            items: marketingController.getArea.map((item) {
                              return DropdownMenuItem<String>(
                                  value: item.value,
                                  child: customText(item.value, 15,
                                      primaryColor, 'Roboto-Regular'));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _chosenValue = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 60,
                      width: getWidth(context),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor, width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customText('Area *', 18, const Color(0xff312D2D).withOpacity(0.2), 'Roboto-Regular'),
                            SvgPicture.asset('assets/Common/downArrow.svg'),
                          ],
                        ),
                      ),
                    );
            }),
            const SizedBox(height: 20),
            textField('Pin Code *', controller.pincode.value,TextInputType.number),
            GetStorage().read('role')=='dealer' ?
            Container(
                height: 60,
                width: getWidth(context),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0.5, color: primaryColor)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 20),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText('${GetStorage().read('dealer')['name']}', 18, primaryColor, 'Roboto-Regular'),
                        SvgPicture.asset('assets/Common/downArrow.svg'),
                      ],
                    ),
                  ),
                )
            ) :

            InkWell(onTap: ()async{
              Get.to(const DealerDropList());
            },
                child: Container(
                    height: 60,
                    width: getWidth(context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.5, color: primaryColor)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,right: 20),
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           GetStorage().read('role') == 'dealer' ?
                           customText('${GetStorage().read('dealer')['name']}', 18, primaryColor, 'Roboto-Regular') :
                           customText('Select Dealer(Multiselect)', 18, const Color(0xff312D2D).withOpacity(0.2), 'Roboto-Regular'),
                            SvgPicture.asset('assets/Common/downArrow.svg'),
                          ],
                        ),
                      ),
                    )
                  /* child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  style: const TextStyle(color: primaryColor),
                  value: selectedMarketingPerson,
                  hint: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: customText(
                          'Select Marketing Personal',
                          18,
                          Color(0xff312D2D).withOpacity(0.2),
                          'Roboto-Regular')),
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SvgPicture.asset('assets/Common/downArrow.svg'),
                  ),
                  items: marketingController.getMarketingList.map((item) {
                    return DropdownMenuItem<String>(
                        value: item.id.toString(),
                        child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: customText(item.name, 15, primaryColor,
                                'Roboto-Regular')));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMarketingPerson = value!;
                      controller.getCityList(context, value);
                    });
                  },
                ),
              ),*/
                )),
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Upload Visiting Card *',
                style: TextStyle(fontSize: 18, color: primaryColor),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return InkWell(
                    onTap: () async {
                      controller.imagePicker();
                    },
                    child: Container(
                        height: 126,
                        width: getWidth(context) * 0.43,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: primaryColor)),
                        child: controller.pickedImage1.value == ''
                            ? Center(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      'assets/Form/front_side.svg'),
                                  const SizedBox(height: 10),
                                  customText('Front side', 18, primaryColor,
                                      'Roboto-Regular'),
                                ],
                              ))
                            : widget.check == false && controller.pickedImage1.value.contains('http')
                                ? Image.network(controller.pickedImage1.value)
                                : Image.file(File(controller.pickedImage1.value))),
                  );
                }),
                Obx(() {
                  return InkWell(
                    onTap: () async {
                      controller.imagePicker2();
                    },
                    child: Container(
                        height: 126,
                        width: getWidth(context) * 0.43,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: primaryColor)),
                        child: controller.pickedImage2.value == ''
                            ? Center(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/Form/front_side.svg'),
                                  const SizedBox(height: 10),
                                  customText('Back side', 18, primaryColor, 'Roboto-Regular'),
                                ],
                              ))
                            : widget.check == false && controller.pickedImage2.value.contains('http')
                                ? Image.network(controller.pickedImage2.value)
                                : Image.file(File(controller.pickedImage2.value))),
                  );
                })
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48, bottom: 30),
              child: Center(
                child: InkWell(
                  onTap: () async{
                    if (widget.check == false) {
                      controller.updateSubDealerData(context,id.toString(), _chosenValue,
                          File(controller.pickedImage1.value), File(controller.pickedImage2.value));
                    } else {
                      controller.addNewSubDealer(context,
                          File(controller.pickedImage1.value), File(controller.pickedImage2.value),
                           _chosenValue);

                      // Get.to(const SubDealersDetailsScreen());
                    }
                  },
                  child: Container(
                    height: 55,
                    width: getWidth(context) * 0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor),
                    child: Center(
                        child: customText('Save', 22, whiteColor, 'Roboto-Regular')),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    ));
  }

  Widget textField(hintText, TextEditingController con,TextInputType type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType: type,
        controller: con,
        decoration: InputDecoration(
          hintText: hintText,
          enabled: true,
          // filled: true,
          hintStyle: TextStyle(
              fontSize: 16.0,
              color: Color(0xff312D2D).withOpacity(0.2),
              fontFamily: 'Roboto-Regular'),
          // contentPadding:
          //     EdgeInsets.symmetric(vertical: 10.0),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: primaryColor, width: 0.5)),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: primaryColor, width: 0.5),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: primaryColor, width: 0.5),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: primaryColor, width: 0.5),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: primaryColor, width: 0.5),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.firmName.value.clear();
    controller.contactPerson.value.clear();
    controller.mobileNumber.value.clear();
    controller.whatsAppNumber.value.clear();
    controller.pincode.value.clear();
    marketingController.mySelection.value = 'Area *';
    controller.pickedImage1.value = '';
    controller.pickedImage2.value = '';
    _chosenValue = '';
  }
}
