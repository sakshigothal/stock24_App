import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:stock24/Pages/ContactUs/Controller/contactus_controller.dart';
import 'package:stock24/utility.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final contactUs= Get.put(ContactUsController());
  @override
  void initState() {
    contactUs.contactUSApi(context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: customAppBar(context, 'Contact Us'),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 30,bottom: 30),
        child: Container(
          height: getHeight(context),
          width: getWidth(context),
          child: Obx((){
            return contactUs.isLoading.value ?  SingleChildScrollView(
                child: Html(data: contactUs.contactUsModel!.value),
            ):const Center(
              child: CircularProgressIndicator(),
            );
          })
        ),
      ),
    ));
  }
}
