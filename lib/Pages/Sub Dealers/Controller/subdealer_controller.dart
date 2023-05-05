import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:stock24/Models/SubDealerMdel/subdealer_model.dart';
import 'package:stock24/Services/SubDealerService/subdealer_service.dart';

import '../sub_dealers_details_screen.dart';

class SubDealerController extends GetxController {
  SubDealerService subDealerService = SubDealerService();
  var getSubDealer = <SubDealerModel>{}.obs;
  RxList<Result> subDealerList = <Result>[].obs;
  RxBool subDealerDataLoading = false.obs;
  RxInt totalSubDealer = 0.obs;

  //for multiselect dealer list
  RxList selectedDealerList=[].obs;

  //for multiselect subdealers
  RxList subDealerBoolList=[].obs;
  RxList selectedSubDealers=[].obs;

  Rx<TextEditingController> firmName = TextEditingController().obs;
  Rx<TextEditingController> contactPerson = TextEditingController().obs;
  Rx<TextEditingController> mobileNumber = TextEditingController().obs;
  Rx<TextEditingController> whatsAppNumber = TextEditingController().obs;
  Rx<TextEditingController> pincode = TextEditingController().obs;

  //pagination
  RxInt page_no = 1.obs;
  final limit = 10;
  RxBool isLoadingData = false.obs;

  Future<void> loadMoreSubDealer(context) async {
    selectedDealerList.clear();
    // subDealerBoolList.clear();
    isLoadingData.value = true;

    final response = await subDealerService.getSubDealer(page_no.value.toString(), limit.toString());

    print('response');
    if (response == '') {
      print('null response');
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> decodeData = jsonDecode(response.body.toString());
        if (decodeData['success'] == '1') {
          SubDealerModel data =
              subDealerModelFromJson(response.body.toString());
          // await Future.delayed(const Duration(seconds: 2));
          subDealerList.addAll(data.data!.result!);
          totalSubDealer.value = data.data!.totalRecords!;
          for(int i=0;i<totalSubDealer.value; i++){
            subDealerBoolList.add(false);
          }
          subDealerDataLoading.value = true;
          page_no.value++;
          print('page---> $page_no');
          isLoadingData.value = false;
        } else {
          isLoadingData.value = false;
        }
      }
    }
  }

  String imageName = '';
  var pickedImage1 = ''.obs;
  XFile? imagePath;
  final ImagePicker picker = ImagePicker();

  imagePicker() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath = image;
      imageName = image.name.toString();
      pickedImage1.value = image.path;
      // update();
    }
  }

  String imageName2 = '';
  var pickedImage2 = ''.obs;
  XFile? imagePath2;
  final ImagePicker picker2 = ImagePicker();

  imagePicker2() async {
    final image = await picker2.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath2 = image;
      imageName2 = image.name.toString();
      pickedImage2.value = image.path;
      // update();
    }
  }

  Future<void> addNewSubDealer(context, File file1, File file2, area) async {
    final response = await subDealerService.addNewSubDealer(
        file1, file2, firmName.value.text,
        contactPerson.value.text, area,
        whatsAppNumber.value.text, pincode.value.text,
        mobileNumber.value.text,
        GetStorage().read('role')=='dealer' ? GetStorage().read('dealer')['id'] : selectedDealerList);

    // print('valueMap----> $valueMap');

    try {
      if(response==''){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed!!!!'),
          backgroundColor: Colors.red,
        ));
      }else if(response is http.Response){
        if(response.statusCode==200){
          Map<String, dynamic> valueMap = jsonDecode(response.body.toString());
          print('key----> ${valueMap['success']}');
          if (valueMap['success'] == '0') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${valueMap['message']}'),
              backgroundColor: Colors.red,
            ));
          } else if (valueMap['success'] == '1') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${valueMap['message']}'),
              backgroundColor: Colors.green,
            ));
            // subDealerList.clear();
            // page_no.value = 1;
            // subDealerDataLoading.value = false;
            // await loadMoreSubDealer(context);
            // Get.back();
            Get.to(const SubDealersDetailsScreen(),
          arguments: {
            'firmname': firmName.value.text,
            'contactPerson':contactPerson.value.text,
            'mobileNumber': mobileNumber.value.text,
            'whatsAppNumber':whatsAppNumber.value.text,
            'area':area,
            'pincode':pincode.value.text,
            'frontSide':file1.path,
            'backSide': file2.path,
            'dealers': GetStorage().read('role')=='dealer' ? GetStorage().read('dealer')['id'] :selectedDealerList
          });
          }
        }
        /*else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Internet connection failed!!!'),
            backgroundColor: Colors.red,
          ));
        }*/
      }
    } on DioError catch (e) {
      Map<String, dynamic> valueMap = jsonDecode(response.toString());
      print(e.response!.statusCode);
      if (valueMap['success'] == 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${valueMap['message']}'),
          backgroundColor: Colors.red,
        ));
      } else if (valueMap['success'] == 1) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${valueMap['message']}'),
          backgroundColor: Colors.green,
        ));
        subDealerList.clear();
        page_no.value = 1;
        subDealerDataLoading.value = false;
        await loadMoreSubDealer(context);
        Get.back();
      }
    }
  }

  Future<void> updateSubDealerData(
      context, id,area, File frontSide, File backSide) async {
    subDealerDataLoading.value = false;
    final response = await subDealerService.updateSubDealer(
        id,
        firmName.value.text,
        contactPerson.value.text,
        area,
        mobileNumber.value.text,
        whatsAppNumber.value.text,
        pincode.value.text,
        frontSide.path,
        backSide.path);
    if (response == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed!!!!'),
        backgroundColor: Colors.red,
      ));
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> decodeData = jsonDecode(response.body.toString());
        if (decodeData['success'] == '0') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(decodeData['message']),
            backgroundColor: Colors.red,
          ));
        } else if (decodeData['success'] == '1') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(decodeData['message']),
            backgroundColor: Colors.green,
          ));
          subDealerList.clear();
          page_no.value = 1;
          subDealerDataLoading.value = false;
          await loadMoreSubDealer(context);
          Get.back();
        }
        print('update  data---> ${response.body}');
      }
    }
  }


  Future<void> deleteUser(context, id) async {
    final response = await subDealerService.deleteUser(id);
    if (response == '') {
      print(response);
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        print(response.body);
        // showLoading(context);
        subDealerList.clear();
          page_no.value = 1;
          subDealerDataLoading.value = false;
          await loadMoreSubDealer(context);
      }
    }
  }
}

  // addSeubdealer(File file1, File file2) async {
  // String username = 'admin';
  // String password = 'mypcot';
  // String basicAuth =
  //     'Basic ' + base64Encode(utf8.encode('$username:$password'));
  // Map<String, String> headers = {
  //   'authorization': basicAuth,
  //   'X-Access-Token': GetStorage().read('token')
  // };
  //   // SubDealerModel subDealerModel = SubDealerModel.fromJson({});
  //   var resquest = http.MultipartRequest(
  //       'POST', Uri.parse(Constants.baseUrl + Constants.addSubDealer));
  //   resquest.headers.addAll(headers);
  //   resquest.fields.addAll({
  //     'firm': 'Avinash Traders',
  //     'contact_person': 'Avinash',
  //     'area': 'Western',
  //     'whatsapp_number': '5981488468',
  //     'pincode': '401202',
  //     'mobile_number': '8648641618',
  //     'dealer[0]': '55'
  //   });
  //   var pic1 = http.MultipartFile.fromString('upload_1', file1.path);
  //   var pic2 = http.MultipartFile.fromString('upload_2', file2.path);
  //   resquest.files.add(pic1);
  //   resquest.files.add(pic2);

  //   var response = await resquest.send();
  //   var responseData = await response.stream.toBytes();
  //   var responseString = String.fromCharCodes(responseData);
  //   print(responseString);
  // }


