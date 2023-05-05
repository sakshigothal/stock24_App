
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/Pages/Dealers/Controller/dealer_controller.dart';
import 'package:stock24/utility.dart';

class DealerDetailsScreen extends StatefulWidget {
  const DealerDetailsScreen({Key? key}) : super(key: key);

  @override
  State<DealerDetailsScreen> createState() => _DealerDetailsScreenState();
}

class _DealerDetailsScreenState extends State<DealerDetailsScreen> {
  final dealerController = Get.put(DealerController());
  String? country;
  List countryList = [];
  String? state;
  List stateList = [];
  String? city;
  List cityList = [];
  @override
  void initState() {
    super.initState();
    country = dealerController.dealerData['country'];
    countryList = country!.split(':');
    state=dealerController.dealerData['state'];
    stateList= state!.split(':');
    city=dealerController.dealerData['city'];
    cityList= city!.split(':');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: whiteColor,
      appBar: customAppBar(context, 'Dealer Details'),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(children: [
                customText(
                    'Personal Details', 16, primaryColor, 'Roboto-Regular'),
                Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 35),
                    child: showDottedDash()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText(
                          'Firm Name', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                          padding: const EdgeInsets.only(right: 15,left: 70),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      Obx(() => customText(dealerController.dealerData['firm'], 16,
                          primaryColor, 'Roboto-Regular'))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText(
                          'Contact Person', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 37),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      Obx(() => customText(dealerController.dealerData['contact_person'],
                          16, primaryColor, 'Roboto-Regular'))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText(
                          'Mobile Number ', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 32),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      Obx(() => customText(dealerController.dealerData['mobile_number'],
                          16, primaryColor, 'Roboto-Regular'))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText('WhatsApp Number ', 16, primaryColor,
                          'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 8),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      Obx(() => customText(dealerController.dealerData['whatsapp_number'],
                          16, primaryColor, 'Roboto-Regular'))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText(
                          'Email ID', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 90),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      Flexible(
                          flex: 2,
                          child: Obx(() =>  customText(dealerController.dealerData['email'],16, primaryColor, 'Roboto-Regular'))
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText('Marketing Personal', 16, primaryColor,
                          'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 12),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      customText(
                          'Rohit Jain', 16, primaryColor, 'Roboto-Regular')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText(
                          'Visiting Card', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 58),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      customText(
                          'Front Side', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                        padding: EdgeInsets.only(left: 60),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      insetPadding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      elevation: 0.0,
                                      backgroundColor: Colors.transparent,
                                      child: Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          Container(
                                            height: getHeight(context) * 0.35,
                                            width: getWidth(context),
                                            color: whiteColor,
                                            child: Obx(() => Image.file(dealerController
                                                .dealerData['upload_2'])),
                                          ),
                                          Positioned(
                                              // right: 5.0,
                                              child: Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: primaryColor,
                                                )),
                                          )),
                                        ],
                                      ));
                                });
                          },
                          child: customText(
                              'View', 16, checkBoxColor, 'Roboto-Regular'),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText(
                          'Visiting Card', 16, whiteColor, 'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 58),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      customText(
                          'Back Side', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                        padding: EdgeInsets.only(left: 60),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      insetPadding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      elevation: 0.0,
                                      backgroundColor: Colors.transparent,
                                      child: Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          Container(
                                            height: getHeight(context) * 0.35,
                                            width: getWidth(context),
                                            color: whiteColor,
                                            child: Obx(() => Image.file(dealerController
                                                .dealerData['upload_1'])),
                                          ),
                                          Positioned(
                                              // right: 5.0,
                                              child: Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: primaryColor,
                                                )),
                                          )),
                                        ],
                                      ));
                                });
                          },
                          child: customText(
                              'View', 16, checkBoxColor, 'Roboto-Regular'),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: showDottedDash()),
                customText(
                    'Billing Details', 16, primaryColor, 'Roboto-Regular'),
                Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: showDottedDash()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText(
                          'GST Number', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(
                            right: 15,
                            left: 58,
                          ),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      Obx(() => customText(dealerController.dealerData['gst_no'], 16,
                          primaryColor, 'Roboto-Regular'))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText(
                          'PAN Number', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 55),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      Obx(() => customText(dealerController.dealerData['pan_no'], 16,
                          primaryColor, 'Roboto-Regular'))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText('Billing Address', 16, primaryColor,
                          'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 44),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      Expanded(
                          child: Obx(() =>  Text(
                            dealerController.dealerData['address'],
                            maxLines: 1,
                            style: TextStyle(fontSize: 16, color: primaryColor),
                          ))
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText(
                          'PIN number', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 63),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      Obx(() => customText(dealerController.dealerData['pincode'], 16,
                          primaryColor, 'Roboto-Regular'))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText('City', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 121),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      Flexible(
                          flex: 2,
                          child: customText(cityList.last,
                              16, primaryColor, 'Roboto-Regular'))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText('State', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 113),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      customText(stateList.last, 16,
                          primaryColor, 'Roboto-Regular')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText('Country', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 92),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      customText(
                          countryList.last, 16, primaryColor, 'Roboto-Regular')
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: showDottedDash()),
                customText(
                    'Billing Details', 16, primaryColor, 'Roboto-Regular'),
                Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: showDottedDash()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText(
                          'Bank Name', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(
                            right: 15,
                            left: 67,
                          ),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      Obx(() => customText(dealerController.dealerData['bank_name'], 16,
                          primaryColor, 'Roboto-Regular'))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText(
                          'Branch Name', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 53),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      Obx(() => customText(dealerController.dealerData['branch'], 16,
                          primaryColor, 'Roboto-Regular'))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText(
                          'Account Type', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 53),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      Expanded(
                          child: Obx(() => Text(
                            dealerController.dealerData['account_type'],
                            maxLines: 1,
                            style: TextStyle(fontSize: 16, color: primaryColor),
                          )))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText(
                          'Account Number', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 27),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      Obx(() => customText(dealerController.dealerData['account_no'], 16,
                          primaryColor, 'Roboto-Regular'))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      customText(
                          'IFSC Code', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                          padding: EdgeInsets.only(right: 15, left: 76),
                          child: customText(
                              ':', 16, primaryColor, 'Roboto-Regular')),
                      Flexible(
                          flex: 2,
                          child: Obx(() => customText(dealerController.dealerData['ifsc_code'], 16, primaryColor, 'Roboto-Regular'))
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 38, bottom: 26),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 55,
                          width: getWidth(context) * 0.42,
                          decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(10),
                              color: whiteColor),
                          child: Center(
                              child: customText('View Product', 22,
                                  primaryColor, 'Skia-Regular')),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 55,
                          width: getWidth(context) * 0.42,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor),
                          child: Center(
                              child: customText(
                                  'Edit', 22, whiteColor, 'Skia-Regular')),
                        ),
                      )
                    ],
                  ),
                )
              ])),
      ),
    ));
  }
}
