import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/Pages/Sub%20Dealers/Controller/subdealer_controller.dart';
import 'package:stock24/utility.dart';

class SubDealersDetailsScreen extends StatefulWidget {
  const SubDealersDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SubDealersDetailsScreen> createState() =>
      _SubDealersDetailsScreenState();
}

class _SubDealersDetailsScreenState extends State<SubDealersDetailsScreen> {
  final subDealercontroller = Get.put(SubDealerController());
  var firmname;
  var contactPerson;
  var mobileNumber;
  var whatsAppNumber;
  var area;
  var pincode;
  var frontside;
  var backside;
  var dealers;
  @override
  void initState() {
    super.initState();
    firmname=Get.arguments['firmname'];
    contactPerson=Get.arguments['contactPerson'];
    mobileNumber=Get.arguments['mobileNumber'];
    whatsAppNumber=Get.arguments['whatsAppNumber'];
    area=Get.arguments['area'];
    pincode=Get.arguments['pincode'];
    frontside=Get.arguments['frontSide'];
    backside=Get.arguments['backSide'];
    dealers= GetStorage().read('role')=='dealer' ? GetStorage().read('dealer')['id'] : Get.arguments['dealers'];
    print(dealers.toString());
    print(dealers.runtimeType);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: whiteColor,
      appBar: customAppBar(context, 'Sub Dealer Details'),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                customText('Firm Name', 16, primaryColor, 'Roboto-Regular'),
                Padding(
                  padding: EdgeInsets.only(left: 70, right: 10),
                  child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                ),
                customText(firmname, 16, primaryColor, 'Roboto-Regular')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                customText(
                    'Contact Person', 16, primaryColor, 'Roboto-Regular'),
                Padding(
                  padding: EdgeInsets.only(left: 37, right: 10),
                  child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                ),
                customText(contactPerson, 16, primaryColor, 'Roboto-Regular')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                customText(
                    'Mobile Number ', 16, primaryColor, 'Roboto-Regular'),
                Padding(
                  padding: EdgeInsets.only(left: 32, right: 10),
                  child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                ),
                customText(mobileNumber, 16, primaryColor, 'Roboto-Regular')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                customText(
                    'WhatsApp Number ', 16, primaryColor, 'Roboto-Regular'),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 10),
                  child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                ),
                customText(whatsAppNumber, 16, primaryColor, 'Roboto-Regular')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                customText('Area', 16, primaryColor, 'Roboto-Regular'),
                Padding(
                  padding: EdgeInsets.only(left: 116, right: 10),
                  child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                ),
                customText(area, 16, primaryColor, 'Roboto-Regular')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                customText('Pincode ', 16, primaryColor, 'Roboto-Regular'),
                Padding(
                  padding:const EdgeInsets.only(left: 87, right: 10),
                  child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                ),
                customText(pincode, 16, primaryColor, 'Roboto-Regular')
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                customText('Visiting Card', 16, primaryColor, 'Roboto-Regular'),
                Padding(
                  padding: EdgeInsets.only(left: 58, right: 10),
                  child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                ),
                customText('Front Side', 16, primaryColor, 'Roboto-Regular'),
                Padding(padding:  EdgeInsets.only(left:getWidth(context)*0.17 ),
                  child: InkWell(
                    onTap: ()async{
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                              contentPadding: const EdgeInsets.fromLTRB(0,0,0,0),
                              content: Container(
                                height: getHeight(context)*0.40,
                                width: getWidth(context)*0.80,
                                child: Stack(
                                    children:
                                [
                                  Align(
                                      child: Image.file(File(frontside))),
                                  Align(
                                    alignment:Alignment.topRight,
                                    child: InkWell(onTap: ()async{
                                      Get.back();
                                    },
                                    child: Icon(Icons.cancel),),
                                  ),

                                ]),
                              )
                          );
                        },
                      );
                    },
                    child: customText('View', 16, checkBoxColor, 'Roboto-Regular'),
                  ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                customText('Visiting Card', 16, whiteColor, 'Roboto-Regular'),
                Padding(
                  padding: EdgeInsets.only(left: 58, right: 10),
                  child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                ),
                customText('Back Side', 16, primaryColor, 'Roboto-Regular'),
                Padding(padding:  EdgeInsets.only(left:getWidth(context)*0.17 ),
                    child: InkWell(
                      onTap: ()async{
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              contentPadding: const EdgeInsets.fromLTRB(0,0,0,0),
                              content: Container(
                                height: getHeight(context)*0.40,
                                width: getWidth(context)*0.80,
                                child: Stack(
                                    children:
                                    [
                                      Align(
                                          child: Image.file(File(backside))),
                                      Align(
                                        alignment:Alignment.topRight,
                                        child: InkWell(onTap: ()async{
                                          Get.back();
                                        },
                                          child: Icon(Icons.cancel),),
                                      ),

                                    ]),
                              )
                            );
                          },
                        );
                      },
                      child: customText('View', 16, checkBoxColor, 'Roboto-Regular'),
                    ))
              ],
            ),
          ),
          customText('Dealers associated with :', 16, primaryColor, 'Roboto-Regular'),
             Padding(padding: const EdgeInsets.only(top: 0),
                 child: GetStorage().read('role')!='dealer' ? Expanded(child: subDealerDetails()) : subDealerDetails()),
             Padding(
               padding: const EdgeInsets.only(bottom: 25),
               child: Center(
                 child: InkWell(onTap: (){},
                   child: Container(
                        height: 55,
                        width: getWidth(context) * 0.40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryColor),
                        child: Center(
                          child: customText('Edit', 22, whiteColor, 'Skia-Regular')
                        ),
                      ),
                 ),
               ),
             ),
        ]),
      )),
    ));
  }

  Widget subDealerDetails() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GetStorage().read('role')!='dealer' ? Obx(() =>  ListView.builder(
          shrinkWrap: true,
          itemCount: dealers.length,
          itemBuilder: (ctx,index){
            return Padding(
              padding: const EdgeInsets.only(top: 15),
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
                          offset: const Offset(
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
                            child: customText(dealers[index]['dealerName'], 20, primaryColor, 'Roboto-Medium'),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, left: 20),
                        child: Row(
                          children: [
                            customText('Contact Person', 16, primaryColor, 'Roboto-Regular'),
                            Padding(padding: const EdgeInsets.only(left: 9, right: 13),
                                child: customText(':', 16, primaryColor, 'Roboto-Regular')),
                            customText(contactPerson, 16, primaryColor, 'Roboto-Regular')
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 83, left: 20),
                        child: Row(
                          children: [
                            customText('Mobile Number', 16, primaryColor, 'Roboto-Regular'),
                            Padding(
                                padding: const EdgeInsets.only(left: 9, right: 13),
                                child: customText(':', 16, primaryColor, 'Roboto-Regular')),
                            customText(mobileNumber, 16, primaryColor, 'Roboto-Regular')
                          ],
                        ),
                      ),
                      const Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 35, left: 20, right: 20),
                            child: Divider(),
                          )),
                      Align(alignment: Alignment.bottomCenter,
                        child: TextButton(
                            onPressed: () {},
                            child: customText('View Product', 16, checkBoxColor, 'Roboto-Regular')),
                      ),

                      Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 55, right: 20),
                            child: SvgPicture.asset('assets/Common/call_icon.svg'),
                          ))
                    ],
                  )),
            );
          })
     ) :
      Container(
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
                  offset: const Offset(
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
                    child: customText(
                        GetStorage().read('dealer')['name'], 20, primaryColor, 'Roboto-Medium'),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: Row(
                  children: [
                    customText('Contact Person', 16, primaryColor, 'Roboto-Regular'),
                    Padding(
                        padding: const EdgeInsets.only(left: 9, right: 13),
                        child: customText(':', 16, primaryColor, 'Roboto-Regular')),
                    customText(contactPerson, 16, primaryColor, 'Roboto-Regular')
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 83, left: 20),
                child: Row(
                  children: [
                    customText('Mobile Number', 16, primaryColor, 'Roboto-Regular'),
                    Padding(
                        padding: const EdgeInsets.only(left: 9, right: 13),
                        child: customText(':', 16, primaryColor, 'Roboto-Regular')),
                  customText(mobileNumber, 16, primaryColor, 'Roboto-Regular')
                  ],
                ),
              ),
              const Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 35, left: 20, right: 20),
                    child: Divider(),
                  )),
              Align(alignment: Alignment.bottomCenter,
                child: TextButton(
                    onPressed: () {},
                    child: customText('View Product', 16, checkBoxColor, 'Roboto-Regular')),
              ),

              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 55, right: 20),
                    child: SvgPicture.asset('assets/Common/call_icon.svg'),
                  ))
            ],
          )),
          );
  }
}
