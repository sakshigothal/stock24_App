import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock24/Models/ContactUsModel/contactus_mode.dart';
import 'package:stock24/Services/ContactUsService/contactus_service.dart';
import 'package:http/http.dart' as http;

class ContactUsController extends GetxController{
  ContactUsService contactUsService=ContactUsService();
  RxBool isLoading=false.obs;
  ContactUsModel? contactUsModel;
  Future<void> contactUSApi(context) async {
    final response = await contactUsService.getContactUS();
    if (response == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed!!!!'),
        backgroundColor: Colors.red,
      ));
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
         contactUsModel = contactUsModelFromJson(response.body.toString());
        isLoading.value = true;
      }
    }
  }
}