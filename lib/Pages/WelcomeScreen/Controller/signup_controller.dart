import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:stock24/Models/Sign%20Up/sign_up_model.dart';
import 'package:stock24/Services/SignUp/signup_service.dart';
import '../../MarketingPersonals/home_screen.dart';

class SignupController extends GetxController {
  TextEditingController mobileNo = TextEditingController();
  TextEditingController otp = TextEditingController();
  SignUpServices signUpServices = SignUpServices();
  GetStorage getMobileNo = GetStorage();
  GetStorage getUserName = GetStorage();
  RxBool condition = false.obs;
  RxBool loading = false.obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  var userData = <UserData>{};
  Future<void> checkSignup(context) async {
    final response = await signUpServices.preLogin(mobileNo.text);
    if (response == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed!!!!'),
        backgroundColor: Colors.red,
      ));
    } else if (response is http.Response) {
      Map<String, dynamic> decodeData = jsonDecode(response.body.toString());
      print('${decodeData['message']}');
      if (response.statusCode == 200) {
        if (decodeData['success'] == '0') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${decodeData['message']}'),
            backgroundColor: Colors.red,
          ));
        } else if (decodeData['success'] == '1') {
          condition.value = true;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${decodeData['message']}'),
            backgroundColor: Colors.green,
          ));
        }
      }
    }
  }

  Future<void> checkLogin(context) async {
    final response = await signUpServices.login(otp.text, mobileNo.text);
    if (response == '') {
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('failed!!!'),
        backgroundColor: Colors.red,
      ));
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        loading.value = true;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Success'),
          backgroundColor: Colors.green,
        ));
//  showLoading(context);
        final data = userDataFromJson(response.body.toString());
        userData.addAll({data});
        // if (!loading.value) {
        // showLoading();
        // } else {
        Get.back();
        Get.off(MarketingPersonalsScreen());
        // }
        final box = GetStorage();
        box.write('token', userData.first.data!.first.token);
        box.write('role', userData.first.data!.first.role);
        if(box.read('role')=='marketing person'){
          box.write('marketing person', {'id':userData.first.data!.first.id,
          'name': userData.first.data!.first.name});
          print('login by marketing person ------>  ${box.read('marketing person')}');
        }else if(box.read('role')=='dealer'){
          box.write('dealer', {'id':userData.first.data!.first.id,
            'name': userData.first.data!.first.name});
          print('login by dealer ------>  ${box.read('dealer')}');
        }

        // else if(box.read('role')=='sub dealer'){
        //   box.write('sub dealer', {'id':userData.first.data!.first.id,
        //     'name': userData.first.data!.first.name});
        //   print('login by sub dealer ------>  ${box.read('sub dealer')}');
        // }
        getMobileNo.write('Name', userData.first.data!.first.name);
        getMobileNo.write(
            'MobileNumber', userData.first.data!.first.mobileNumber);
        // controller.getMarketingPersonal(context);
        print('Token is-----> ${box.read('token').toString()}');
        update();
      }
    }
  }

  Future<void> userLogin(context)async{
    final isValid = loginFormKey.currentState!.validate();
    if(!isValid){
      print('not valid form');
      Get.back();
      return ;
    }else{
      loginFormKey.currentState!.save();
      final response = await signUpServices.login(otp.text, mobileNo.text);
      if(response==''){
        Get.back();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please check your Internet Connection'), backgroundColor: Colors.red,));
      }else if(response is http.Response){
        Map<String, dynamic> decodeData = jsonDecode(response.body.toString());
        print('${decodeData['message']}');
          if (response.statusCode == 200) {
            if (decodeData['success'] == '0') {
              Get.back();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('${decodeData['message']}'),
                backgroundColor: Colors.red));
             } else if (decodeData['success'] == '1') {
                loading.value = true;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                 content: Text('${decodeData['message']}'),backgroundColor: Colors.green));
                  final data = userDataFromJson(response.body.toString());
                  userData.addAll({data});

                  Get.offAll(MarketingPersonalsScreen());
                  // }
                  final box = GetStorage();
                  box.write('token', userData.first.data!.first.token);
                  box.write('role', userData.first.data!.first.role);
                  if(box.read('role')=='marketing person'){
                    box.write('marketing person', {'id':userData.first.data!.first.id,
                      'name': userData.first.data!.first.name});
                    print('login by marketing person ------>  ${box.read('marketing person')}');
                  }else if(box.read('role')=='dealer'){
                    box.write('dealer', {'id':userData.first.data!.first.id,
                      'name': userData.first.data!.first.name});
                    print('login by dealer ------>  ${box.read('dealer')}');
                  }

                  // else if(box.read('role')=='sub dealer'){
                  //   box.write('sub dealer', {'id':userData.first.data!.first.id,
                  //     'name': userData.first.data!.first.name});
                  //   print('login by sub dealer ------>  ${box.read('sub dealer')}');
                  // }
                  getMobileNo.write('Name', userData.first.data!.first.name);
                  getMobileNo.write('MobileNumber', userData.first.data!.first.mobileNumber);
                  // controller.getMarketingPersonal(context);
                  print('Token is-----> ${box.read('token').toString()}');
        }
      }
    }
  }
}

  checkMobileNumber(String mobileNumber) {
    if (mobileNumber.length < 10) {
      return 'Enter valid Mobile Number';
    }
    return null;
  }

  Future<void> resendOTP(context) async {
    final response = await signUpServices.preLogin(mobileNo.text);
    try {
      if (response == '') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed!!!!'),
          backgroundColor: Colors.red,
        ));
      } else if (response is http.Response) {
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('OTP send Successfully!!!'),
            backgroundColor: Colors.green,
          ));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.green,
      ));
      print(e.toString());
    }
  }
}
