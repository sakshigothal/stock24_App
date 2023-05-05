import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/Pages/Dealers/Controller/dealer_controller.dart';
import 'package:stock24/utility.dart';

import '../MarketingPersonals/Controller/marketingPersonal_controller.dart';
import 'dealer_droplist.dart';

class AddDealerScreen extends StatefulWidget {
  final check;
  const AddDealerScreen({Key? key, this.check}) : super(key: key);

  @override
  State<AddDealerScreen> createState() => _AddDealerScreenState();
}

class _AddDealerScreenState extends State<AddDealerScreen> {
  final controller = Get.find<DealerController>();
  final marketingController = Get.put(GetMarketingPersonalsController());
  var id;
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  int _currentStep = 0;
  List countryList = [];
  List stateList = [];
  List cityList = [];
  String? selectedAccountType;

  //update
  String? updateCountry;
  @override
  void initState() {
    super.initState();
    callCountry();

    if (!widget.check) {
      id = Get.arguments['id'];
      controller.firmName.value.text = Get.arguments['firm'];
      controller.contactPerson.value.text = Get.arguments['contact_person'];
      controller.mobileNumber.value.text = Get.arguments['mobile_number'];
      controller.whatsAppNumber.value.text = Get.arguments['whatsapp_number'];
      controller.email.value.text = Get.arguments['email'];
      marketingController.selectedMarketingPerson.value=Get.arguments['marketing_person'];
      controller.gstNumber.value.text = Get.arguments['gst_no'];
      controller.panNumber.value.text = Get.arguments['pan_no'];
      controller.address.value.text = Get.arguments['address'];
      controller.pincode.value.text = Get.arguments['pincode'];
      controller.bankName.value.text = Get.arguments['bank_name'];
      controller.branchName.value.text = Get.arguments['branch'];
      selectedAccountType = Get.arguments['account_type'];
      controller.accoountNumber.value.text = Get.arguments['account_no'];
      controller.ifscCode.value.text = Get.arguments['ifsc_code'];
      controller.pincode.value.text = Get.arguments['pincode'];
      controller.pickedImage1.value = Get.arguments['upload_1'];
      controller.pickedImage2.value = Get.arguments['upload_2'];
      selectedCountry = Get.arguments['country'];
      print('selectedCountry-----> $selectedCountry');
      selectedState = Get.arguments['state'];
      selectedCity = Get.arguments['city'];
      print(
          'user id -----> $selectedState ---> $selectedCountry-----> $selectedCity');
    }
  }

  Future<void> callCountry() async {
    await marketingController.getAreaList(context);
    controller.getStateList(context, '1');
    // print('selectedCountry-----> ${marketingController.countryMap}');
    updateCountry = marketingController.countryMap.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(context, 'Add Dealer'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Column(
              children: [
                stepper(),
                Padding(
                  padding: const EdgeInsets.only(top: 17, bottom: 20),
                  child: showDottedDash(),
                ),
                _currentStep == 0
                    ? step1()
                    : _currentStep == 1
                        ? step2()
                        : step3(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget stepper() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  height: 22,
                  width: 22,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _currentStep >= 0 ? whiteColor : primaryColor,
                      ),
                      height: 10,
                      width: 10,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  height: 3,
                  width: getWidth(context) * 0.30,
                  color: primaryColor,
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                      color: _currentStep >= 1 ? primaryColor : whiteColor,
                      borderRadius: BorderRadius.circular(20)),
                  height: 22,
                  width: 22,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: whiteColor),
                      height: 10,
                      width: 10,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Container(
                  height: 3,
                  width: getWidth(context) * 0.30,
                  color: primaryColor,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: _currentStep >= 2 ? primaryColor : whiteColor,
                    borderRadius: BorderRadius.circular(20)),
                height: 22,
                width: 22,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: whiteColor),
                    height: 10,
                    width: 10,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Personal\n Details',
                  style: TextStyle(
                      fontFamily: 'Roboto-Medium',
                      fontSize: 16,
                      color: primaryColor),
                ),
                Text(' Billing\nDetails',
                    style: TextStyle(
                        fontFamily: 'Roboto-Medium',
                        fontSize: 16,
                        color: primaryColor)),
                Text(' Bank\nDetails',
                    style: TextStyle(
                        fontFamily: 'Roboto-Medium',
                        fontSize: 16,
                        color: primaryColor))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget step1() {
    return Container(
      // color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textField('Enter Firm Name *', controller.firmName.value,TextInputType.text),
          textField('Contact Person *', controller.contactPerson.value,TextInputType.text),
          textField('Mobile Number *', controller.mobileNumber.value,TextInputType.number),
          textField('WhatsApp Number *', controller.whatsAppNumber.value,TextInputType.number),
          textField('Email ID *', controller.email.value,TextInputType.text),
          GetStorage().read('role')=='marketing person' ?
          Container(
              height: 60,
              width: getWidth(context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.5, color: primaryColor)),
              child: Align(alignment: Alignment.centerLeft,child: Padding(padding: EdgeInsets.only(left: 10),child:
              GetStorage().read('role')== 'marketing person'  ?
              customText('${GetStorage().read('marketing person')['name']}', 18, primaryColor, 'Roboto-Regular')  :
              Obx((){
                return

                  customText(marketingController.selectedMarketingPerson.value.isNotEmpty ? marketingController.selectedMarketingPerson.value : 'Select Marketing Personal', 18,
                      marketingController.selectedMarketingPerson.value.isNotEmpty ? primaryColor : const Color(0xff312D2D).withOpacity(0.2), 'Roboto-Regular');
              }),),)
          ):
          InkWell(onTap: ()async{
               Get.to(MarketingPersonDropList());
            },
            child: Container(
              height: 60,
              width: getWidth(context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 0.5, color: primaryColor)),
              child: Align(alignment: Alignment.centerLeft,child: Padding(padding: EdgeInsets.only(left: 10),child:
                   GetStorage().read('role')== 'marketing person'  ?
                   customText('${GetStorage().read('marketing person')['name']}', 18, primaryColor, 'Roboto-Regular')  :
                   Obx((){
               return

               customText(marketingController.selectedMarketingPerson.value.isNotEmpty ? marketingController.selectedMarketingPerson.value : 'Select Marketing Personal', 18,
                   marketingController.selectedMarketingPerson.value.isNotEmpty ? primaryColor : const Color(0xff312D2D).withOpacity(0.2), 'Roboto-Regular');
             }),),)
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
          Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: customText('Upload Visiting Card *', 18, primaryColor,
                  'Roboto-Regular')),
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
                                SvgPicture.asset('assets/Form/front_side.svg'),
                                SizedBox(height: 10),
                                customText('Front side', 18, primaryColor,
                                    'Roboto-Regular'),
                              ],
                            ))
                          : widget.check == false &&
                                  controller.pickedImage1.value.contains('http')
                              ? Image.network(controller.pickedImage1.value)
                              : Image.file(
                                  File(controller.pickedImage1.value))),
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
                                SvgPicture.asset('assets/Form/back_side.svg'),
                                SizedBox(height: 10),
                                customText('Back side', 18, primaryColor,
                                    'Roboto-Regular'),
                              ],
                            ))
                          : widget.check == false &&
                                  controller.pickedImage2.value.contains('http')
                              ? Image.network(controller.pickedImage2.value)
                              : Image.file(
                                  File(controller.pickedImage2.value))),
                );
              })
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35, bottom: 30),
            child: Center(
              child: InkWell(
                onTap: ()async {
                  if (controller.firmName.value.text.isNotEmpty &&
                      controller.contactPerson.value.text.isNotEmpty &&
                      controller.mobileNumber.value.text.isNotEmpty &&
                      controller.whatsAppNumber.value.text.isNotEmpty &&
                      controller.pickedImage1.value.isNotEmpty &&
                      controller.pickedImage2.value.isNotEmpty
                  // &&
                      // GetStorage().read('marketing person')['name'] != null ||
                      // marketingController.selectedMarketingPerson.value.isNotEmpty
                  ) {
                    setState(() {
                      _currentStep++;
                    });
                    controller.dealerData.addAll({
                      'firm': controller.firmName.value.text,
                      'contact_person': controller.contactPerson.value.text,
                      'mobile_number': controller.mobileNumber.value.text,
                      'whatsapp_number': controller.whatsAppNumber.value.text,
                      'email': controller.email.value.text,
                      'marketing_person':
                      GetStorage().read('role')== 'marketing person' ? GetStorage().read('marketing person')['id'].toString() :
                      marketingController.selectedMarketingPersonId,
                      'upload_1': File(controller.pickedImage1.value),
                      'upload_2': File(controller.pickedImage2.value),
                    });
                    print(
                        'dealer data----> ${controller.dealerData.toString()}');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please enter valid Details!!!'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: Container(
                  height: 55,
                  width: getWidth(context) * 0.40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor),
                  child: Center(
                      child: customText('Next', 22, whiteColor, 'Skia-Regular')),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textField(hintText, TextEditingController con,TextInputType type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: con,
        keyboardType:type ,
        decoration: InputDecoration(
          hintText: hintText,
          enabled: true,
          // filled: true,
          hintStyle: TextStyle(
              fontSize: 18.0,
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

  Widget step2() {
    return Column(
      children: [
        textField('GST Number *', controller.gstNumber.value,TextInputType.text),
        textField('PAN Number *', controller.panNumber.value,TextInputType.text),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextFormField(
            controller: controller.address.value,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Billing Address *',
              enabled: true,
              hintStyle: TextStyle(
                  fontSize: 16.0, color: Color(0xff312D2D).withOpacity(0.2)),
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
        ),
        textField('Pincode *', controller.pincode.value,TextInputType.number),
        Container(
          height: 60,
          width: getWidth(context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: primaryColor, width: 0.5)),
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(right: 10, left: 10, top: 10),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
            focusColor: Colors.white,
            value: selectedCountry,
            icon: SvgPicture.asset('assets/Common/downArrow.svg'),
            style: TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: marketingController.countryMap
                .map((key, value) {
                  return MapEntry(
                      key,
                      DropdownMenuItem(
                          value: '$key:$value',
                          child: customText('$value', 14, primaryColor, 'Roboto-Regular')));
                })
                .values
                .toList(),
            hint: customText('Country', 15, Color(0xff312D2D).withOpacity(0.2),
                'Roboto-Regular'),
            onChanged: (value) {
              controller.getStateList(context, value);
              String country = value.toString();
              countryList = country.split(':');
              print('value----> ${countryList.last}');
              setState(() {
                selectedCountry = value.toString();
              });
            },
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //  selectedState != ''?
            Container(
              height: 60,
              width: getWidth(context) * 0.43,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: primaryColor, width: 0.5)),
              child: DropdownButtonFormField(
                value: selectedState,
                isExpanded: true,
                isDense: true,
                icon: SvgPicture.asset('assets/Common/downArrow.svg'),
                focusColor: Colors.white,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
                style: TextStyle(color: Colors.white),
                iconEnabledColor: Colors.black,
                items: controller.stateMap
                    .map((key, value) {
                      return MapEntry(
                          key,
                          DropdownMenuItem(
                              value: '$key:$value',
                              child: customText('$value', 14, primaryColor,
                                  'Roboto-Regular')));
                    })
                    .values
                    .toList(),
                hint: customText('State', 15,
                    Color(0xff312D2D).withOpacity(0.2), 'Roboto-Regular'),
                onChanged: (value) {
                  controller.getCityList(context, value);
                  String state = value.toString();
                  stateList = state.split(':');
                  print('value----> ${stateList.last}');
                  print('value-----> $value');
                  setState(() {
                    selectedState = value.toString();
                  });
                },
              ),
            ),
            Container(
              height: 60,
              width: getWidth(context) * 0.43,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: primaryColor, width: 0.5)),
              child: DropdownButtonFormField(
                value: selectedCity,
                isDense: false,
                isExpanded: true,
                icon: SvgPicture.asset('assets/Common/downArrow.svg'),
                focusColor: Colors.white,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
                style: TextStyle(color: Colors.white),
                iconEnabledColor: Colors.black,
                items: controller.cityMap
                    .map((key, value) {
                      return MapEntry(
                          key,
                          DropdownMenuItem(
                              value: '$key:$value',
                              child: customText('$value', 14, primaryColor, 'Roboto-Regular')));
                    })
                    .values
                    .toList(),
                hint: customText('City', 15, primaryColor, 'Roboto-Regular'),
                onChanged: (value) {
                  if (!widget.check) {
                    setState(() {
                      selectedCity = value.toString();
                    });
                  } else {
                    String city = value.toString();
                    cityList = city.split(':');
                    print('value----> ${cityList.last}');
                    setState(() {
                      selectedCity = value.toString();
                    });
                  }
                },
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _currentStep--;
                  });
                },
                child: Container(
                  height: 55,
                  width: getWidth(context) * 0.42,
                  decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor),
                  child: Center(
                      child: customText(
                          'Previous', 22, primaryColor, 'Skia-Regular')),
                ),
              ),
              InkWell(
                onTap: () {
                  if (controller.gstNumber.value.text.isNotEmpty &&
                      controller.panNumber.value.text.isNotEmpty &&
                      controller.address.value.text.isNotEmpty &&
                      controller.pincode.value.text.isNotEmpty &&
                      selectedCountry!.isNotEmpty &&
                      selectedState!.isNotEmpty &&
                      selectedCity!.isNotEmpty) {
                    setState(() {
                      _currentStep++;
                    });

                    controller.dealerData.addAll({
                      'gst_no': controller.gstNumber.value.text,
                      'pan_no': controller.panNumber.value.text,
                      'address': controller.address.value.text,
                      'pincode': controller.pincode.value.text,
                      'country': selectedCountry,
                      'state': selectedState,
                      'city': selectedCity
                    });
                    print(
                        'dealer data----> ${controller.dealerData.toString()}');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please enter valid Details!!!'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                child: Container(
                  height: 55,
                  width: getWidth(context) * 0.42,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor),
                  child: Center(
                      child:
                          customText('Next', 22, whiteColor, 'Skia-Regular')),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget step3() {
    return Column(
      children: [
        textField('Bank Name *', controller.bankName.value,TextInputType.text),
        textField('Branch Name *', controller.branchName.value,TextInputType.text),
        Container(
          height: 60,
          width: getWidth(context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: primaryColor, width: 0.5)),
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(right: 10, left: 10, top: 10),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                disabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
                errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
            focusColor: Colors.white,
            value: selectedAccountType,
            icon: SvgPicture.asset('assets/Common/downArrow.svg'),
            style: TextStyle(color: Colors.white),
            iconEnabledColor: Colors.black,
            items: ['Saving Account', 'Current Account'].map((item) {
              return DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: customText(item, 15, primaryColor, 'Roboto-Regular'),
                  ));
            }).toList(),
            hint: customText('Account Type', 15,
                Color(0xff312D2D).withOpacity(0.2), 'Roboto-Regular'),
            onChanged: (value) {
              setState(() {
                selectedAccountType = value.toString();
              });
            },
          ),
        ),
        SizedBox(height: 20),
        textField('Account Number *', controller.accoountNumber.value,TextInputType.number),
        textField('IFSC Code *', controller.ifscCode.value,TextInputType.number),
        Padding(
          padding: EdgeInsets.only(top: getHeight(context) * 0.06),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _currentStep--;
                  });
                },
                child: Container(
                  height: 55,
                  width: getWidth(context) * 0.42,
                  decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor),
                  child: Center(
                      child: customText('Previous', 22, primaryColor, 'Skia-Regular')),
                ),
              ),
              InkWell(
                onTap: ()async {
                  if (!widget.check) {
                    if (controller.bankName.value.text.isNotEmpty &&
                        controller.branchName.value.text.isNotEmpty &&
                        selectedAccountType!.isNotEmpty &&
                        controller.accoountNumber.value.text.isNotEmpty &&
                        controller.ifscCode.value.text.isNotEmpty) {
                      setState(() {
                        _currentStep++;
                      });
                      controller.dealerData.addAll({
                        'bank_name': controller.bankName.value.text,
                        'branch': controller.branchName.value.text,
                        'account_type': selectedAccountType,
                        'account_no': controller.accoountNumber.value.text,
                        'ifsc_code': controller.ifscCode.value.text,
                      });

                      controller.updateDealerData(
                          context,
                          id.toString(),
                          controller.dealerData['firm'],
                          controller.dealerData['contact_person'],
                          controller.dealerData['mobile_number'],
                          controller.dealerData['whatsapp_number'],
                          controller.dealerData['email'],
                          controller.dealerData['marketing_person'],
                          controller.dealerData['gst_no'],
                          controller.dealerData['pan_no'],
                          controller.dealerData['address'],
                          controller.dealerData['pincode'],
                          controller.dealerData['bank_name'],
                          controller.dealerData['branch'],
                          controller.dealerData['account_type'],
                          controller.dealerData['account_no'],
                          controller.dealerData['ifsc_code'],
                          controller.dealerData['upload_1'],
                          controller.dealerData['upload_2'],
                          controller.dealerData['country'],
                          controller.dealerData['state'],
                          controller.dealerData['city'],
                          );
                    }
                  } else if (widget.check) {
                    if (controller.bankName.value.text.isNotEmpty &&
                        controller.branchName.value.text.isNotEmpty &&
                        selectedAccountType!.isNotEmpty &&
                        controller.accoountNumber.value.text.isNotEmpty &&
                        controller.ifscCode.value.text.isNotEmpty) {
                      setState(() {
                        _currentStep++;
                      });
                      controller.dealerData.addAll({
                        'bank_name': controller.bankName.value.text,
                        'branch': controller.branchName.value.text,
                        'account_type': selectedAccountType,
                        'account_no': controller.accoountNumber.value.text,
                        'ifsc_code': controller.ifscCode.value.text,
                      });

                          controller.addNewDealerData(
                          context,
                          controller.dealerData['firm'],
                          controller.dealerData['contact_person'],
                          controller.dealerData['mobile_number'],
                          controller.dealerData['whatsapp_number'],
                          controller.dealerData['email'],
                          controller.dealerData['marketing_person'],
                          controller.dealerData['upload_1'],
                          controller.dealerData['upload_2'],
                          controller.dealerData['gst_no'],
                          controller.dealerData['pan_no'],
                          controller.dealerData['address'],
                          controller.dealerData['pincode'],
                          controller.dealerData['country'],
                          controller.dealerData['state'],
                          controller.dealerData['city'],
                          controller.dealerData['bank_name'],
                          controller.dealerData['branch'],
                          controller.dealerData['account_type'],
                          controller.dealerData['account_no'],
                          controller.dealerData['ifsc_code']);
                      print(
                          'dealer data----> ${controller.dealerData.toString()}');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please enter valid Details!!!'),
                        backgroundColor: Colors.red,
                      ));
                    }
                  } else {
                    null;
                  }
                },
                child: Container(
                  height: 55,
                  width: getWidth(context) * 0.42,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor),
                  child: Center(
                      child:
                          customText('Save', 22, whiteColor, 'Skia-Regular')),
                ),
              )
            ],
          ),
        )
      ],
    );
  }


  @override
  void dispose() {
    super.dispose();
    // controller.dealerLoading.value = false;
    controller.firmName.value.clear();
    controller.contactPerson.value.clear();
    controller.mobileNumber.value.clear();
    controller.whatsAppNumber.value.clear();
    controller.email.value.clear();
    controller.gstNumber.value.clear();
    controller.panNumber.value.clear();
    controller.address.value.clear();
    controller.pincode.value.clear();
    controller.bankName.value.clear();
    controller.branchName.value.clear();
    selectedAccountType = '';
    controller.accoountNumber.value.clear();
    controller.ifscCode.value.clear();
    controller.pincode.value.clear();
    controller.pickedImage1.value = '';
    controller.pickedImage2.value = '';
    selectedCountry = '';
    selectedState = '';
    selectedCity = '';
    marketingController.selectedMarketingPerson.value='';
    marketingController.selectedMarketingPersonId.value='';
  }
}
