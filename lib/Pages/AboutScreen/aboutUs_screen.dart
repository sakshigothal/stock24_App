import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/utility.dart';

import '../MarketingPersonals/Controller/marketingPersonal_controller.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  final marketingController=Get.find<GetMarketingPersonalsController>();
  @override
  void initState() {
    super.initState();
    marketingController.getAreaList(context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: customAppBar(context, 'About Us'),
      body: Obx(() {
        return marketingController.areaLoding.value ? Center(
          child: Center(
            child: customText(marketingController.aboutUS?.data?.aboutUs, 25, primaryColor, 'Roboto-Regular'),
          )
        ) : const Center(
          child:  CircularProgressIndicator(),
        );
      })
    ));
  }
}
