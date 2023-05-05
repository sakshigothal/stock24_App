import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/utility.dart';
import '../MarketingPersonals/Controller/marketingPersonal_controller.dart';

class AddStockData extends StatefulWidget {
  final add;
  const AddStockData({Key? key, this.add}) : super(key: key);

  @override
  State<AddStockData> createState() => _AddStockDataState();
}

class _AddStockDataState extends State<AddStockData> {
  final controller = Get.put(GetMarketingPersonalsController());
  var id;
  String? _chosenValue;
  @override
  void initState() {
    super.initState();
    print(widget.add);
    // controller.getAreaList(context);
    if (!widget.add) {
      id = Get.arguments['id'];
      controller.name.text = Get.arguments['name'];
      controller.mobileNo.text = Get.arguments['mobile_number'];
      controller.whatsAppNo.text = Get.arguments['whatsapp_number'];
      controller.designation.text = Get.arguments['designation'];
      _chosenValue = Get.arguments['area'];
      print(_chosenValue);
      print(Get.arguments['area']);
    }

    // setState(() {
    controller.uId = id;
    // });
    print('user id value----> ${controller.uId}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: customAppBar(context, 'Add Marketing Personals'),
            floatingActionButton: InkWell(
              onTap: () async {
                
                // print(object)
                if (widget.add == false) {
                  controller.uPdateMarketingPersonal(context, _chosenValue);

                  print('if----> $_chosenValue');
                } else {
                  showDialog(
                      context: context,
                      builder: (ctx) {
                        return const Center(
                            child: CircularProgressIndicator(color: Colors.green,));
                      });
                  Get.back();
                  controller.aDDMarketingPersonal(context,_chosenValue);
                  print('else----> $_chosenValue');
                }
              },
              child: Container(
                height: 55,
                width: getWidth(context) * 0.40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryColor),
                child: Center(
                    child: customText('Save', 22, whiteColor, 'Skia-Regular')),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    textField('Enter Name *', controller.name,TextInputType.text),
                    textField('Designation *', controller.designation,TextInputType.text),
                    textField('Mobile Number *', controller.mobileNo,TextInputType.number),
                    textField('WhatsApp Number *', controller.whatsAppNo,TextInputType.number),
                    Obx(() {
                      return controller.areaLoding.value
                          ? Container(
                              height: 60,
                              width: getWidth(context),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: primaryColor, width: 0.5)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    style: const TextStyle(color: primaryColor),
                                    value: _chosenValue,
                                    hint: customText('Area *', 18, const Color(0xff312D2D).withOpacity(0.2), 'Roboto-Regular'),
                                    icon: SvgPicture.asset('assets/Common/downArrow.svg'),
                                    items: controller.getArea.map((item) {
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
                                  border: Border.all(
                                      color: primaryColor, width: 0.5)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    customText('Area *', 18, const Color(0xff312D2D).withOpacity(0.2), 'Roboto-Regular'),
                                    SvgPicture.asset('assets/Common/downArrow.svg'),
                                  ],
                                ),
                              ),
                            );
                    }),
                  ],
                ),
              ),
            )));
  }

  Widget textField(hintText, TextEditingController con,TextInputType type) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType:type ,
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
    controller.name.clear();
    controller.designation.clear();
    controller.mobileNo.clear();
    controller.whatsAppNo.clear();
    controller.mySelection.value = '';
    controller.getArea.clear();
    _chosenValue = '';
  }
}
