import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:stock24/Models/Address/city_model.dart';
import 'package:stock24/Models/Address/state_model.dart';
import 'package:stock24/Models/DealerModel/getdealer_model.dart';
import 'package:stock24/Pages/Dealers/dealer_details_screen.dart';
import 'package:stock24/Services/DealerService/dealer_service.dart';

class DealerController extends GetxController {
  DealerService dealerService = DealerService();
  RxList<Result> dealerList = <Result>[].obs;
  RxBool dealerLoading = false.obs;
  RxInt totalDealer = 0.obs;
  RxMap stateMap = {}.obs;
  RxMap cityMap = {}.obs;
  RxMap dealerData = {}.obs;

  //
  RxList dealerBoolList=[].obs;
  RxList selectedDealers=[].obs;

  //for multiselect dealer list
  RxList selectedDealerList=[].obs;

  //
  RxList booleanList=[].obs;
  //City
  List<CityResult> citylist = <CityResult>[].obs;

  //State
  List<StateResult> stateList = <StateResult>[].obs;

  Rx<TextEditingController> firmName = TextEditingController().obs;
  Rx<TextEditingController> contactPerson = TextEditingController().obs;
  Rx<TextEditingController> mobileNumber = TextEditingController().obs;
  Rx<TextEditingController> whatsAppNumber = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> gstNumber = TextEditingController().obs;
  Rx<TextEditingController> panNumber = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;
  // Rx<TextEditingController> billingAddress = TextEditingController().obs;
  Rx<TextEditingController> pincode = TextEditingController().obs;
  Rx<TextEditingController> bankName = TextEditingController().obs;
  Rx<TextEditingController> branchName = TextEditingController().obs;
  // Rx<TextEditingController> accountType = TextEditingController().obs;
  Rx<TextEditingController> accoountNumber = TextEditingController().obs;
  Rx<TextEditingController> ifscCode = TextEditingController().obs;

  //Picker 1
  String imageName = '';
  var pickedImage1 = ''.obs;
  XFile? imagePath;
  final ImagePicker picker = ImagePicker();

//Picker 2
  String imageName2 = '';
  var pickedImage2 = ''.obs;
  XFile? imagePath2;
  final ImagePicker picker2 = ImagePicker();

  //pagination
  RxInt page_no = 1.obs;
  final limit = 10;
  RxBool isLoadingData = false.obs;

  

  // Future<void> getDealerData(context) async {
  //   final response = await dealerService.getDealer();
  //   if (response == '') {
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text('Failed!!!!'),
  //       backgroundColor: Colors.red,
  //     ));
  //   } else if (response is http.Response) {
  //     if (response.statusCode == 200) {
  //       final data = getDealerFromJson(response.body.toString());
  //       getDealer.addAll({data});
  //       dealerLoading.value = true;
  //       // Get.to(DealersScreen());
  //       update();
  //       // update();
  //     }
  //   }
  // }

  Future<void> loadMoreDealer(context) async {
    // dealerList.clear();
    isLoadingData.value = true;
    final response = await dealerService.getDealer(page_no.value.toString(), limit.toString());
    print('response');
    if (response == '') {
      print('null response');
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> decodeData = jsonDecode(response.body.toString());
        if (decodeData['success'] == '1') {
          GetDealer data = getDealerFromJson(response.body.toString());
          // await Future.delayed(const Duration(seconds: 2));
          dealerList.addAll(data.data!.result!);
          totalDealer.value = data.data!.totalRecords!;
          for(int i=0;i<totalDealer.value; i++){
            booleanList.add(false);
            selectedDealers.add(false);
          }
          dealerLoading.value = true;
          page_no.value++;
          print('page---> $page_no');
          isLoadingData.value = false;
        } else {
          isLoadingData.value = false;
        }
      }
    }
  }

  imagePicker() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath = image;
      imageName = image.name.toString();
      pickedImage1.value = image.path;
      // update();
    }
  }

  imagePicker2() async {
    final image = await picker2.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath2 = image;
      imageName2 = image.name.toString();
      pickedImage2.value = image.path;
      // update();
    }
  }

  Future<void> addNewDealerData(context,firmname,contact_person,mobile_number,whatsApp_number,
                                emailId,marketingPerson,File file1, File file2,GST_number,
                                PAN_number,billing_Address,pinCode,country,state,city,bank_name,
                                branch_name,account_type,account_number,IFSC_code) async {

    final response = await dealerService.addNewDealer(
        firmname, contact_person, mobile_number, whatsApp_number,
        emailId, marketingPerson, file1, file2, GST_number,
        PAN_number,billing_Address, pinCode,country, state,
        city,bank_name,branch_name,account_type,account_number,IFSC_code);


    try {
      if (response != null) {
        Map<String, dynamic> valueMap = jsonDecode(response.toString());
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
          dealerLoading.value = false;
          Get.to(const DealerDetailsScreen());
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Internet connection failed!!!'),
          backgroundColor: Colors.red,
        ));
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
        dealerLoading.value = false;
        await loadMoreDealer(context);
        Get.back();
      }
    }
  }

  Future<void> updateDealerData(context,id,firm,contact_person,mobile_number,whatsapp_number,
  emailID,marketing_person,gst_no,pan_no,address,pinCode,bank_name,
  branch, account_type,account_no,ifsc_code,File frontSide,File  backSide,country,state,city) async {
    dealerData.clear();
    dealerLoading.value = false;
    final response = await dealerService.updateDealer(
        id,firm,
        contact_person,mobile_number,whatsapp_number,emailID,marketing_person,gst_no,pan_no,
        address,pinCode,bank_name,branch,account_type,account_no,
        ifsc_code,frontSide.path,backSide.path,country,state,city);
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
          dealerList.clear();
          page_no.value = 1;
          dealerLoading.value = false;
          await loadMoreDealer(context);
          Get.back();
        }
        print('update  data---> ${response.body}');
      }
    }
  }

  Future<void> getCityList(context, state_id) async {
    final response = await dealerService.getCity(state_id);
    if (response == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed!!!!'),
        backgroundColor: Colors.red,
      ));
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        final data = cityModelFromJson(response.body.toString());
        citylist.addAll(data.data!.result!);
        citylist.forEach(
          (element) {
            cityMap.addAll({'${element.id}': '${element.cityName}'});
          },
        );
        dealerLoading.value = true;
      }
    }
  }

  Future<void> getStateList(context, country_id) async {
    stateList.clear();
    final response = await dealerService.getState(country_id);
    if (response == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed!!!!'),
        backgroundColor: Colors.red,
      ));
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        final data = stateModelFromJson(response.body.toString());
        stateList.addAll(data.data!.result!);

        stateList.forEach(
          (element) {
            stateMap.addAll({'${element.id}': '${element.stateName}'});
          },
        );
        dealerLoading.value = true;
      }
    }
  }

  Future<void> deleteUser(context, id) async {
    final response = await dealerService.deleteUser(id);
    if (response == '') {
      print(response);
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        print(response.body);
        // showLoading(context);
        dealerList.clear();
        page_no.value = 1;
        dealerLoading.value = false;
        await loadMoreDealer(context);
      }
    }
  }

  // uploadImage() async {
  //   var uniqueKey = firebaseFirestore.collection(collectionName);
  //   String uploadFileName = DateTime.now().toString() + '.jpg';
  //   Reference reference =
  //       storage.ref().child(collectionName).child(uploadFileName);
  //   UploadTask uploadTask = reference.putFile(File(imagePath!.path));
  //   uploadTask.snapshotEvents.listen((event) {
  //     print(event.bytesTransferred);
  //   });

  //   await uploadTask.whenComplete(() async {
  //     uploadPath = await uploadTask.snapshot.ref.getDownloadURL();

  //     // if (uploadPath.isNotEmpty) {
  //     //   firebaseFirestore.collection('Notes').doc(auth.currentUser!.uid).set(
  //     //       {'Image': uploadPath}).then((value) => print('record inserted'));
  //     // } else {
  //     //   print('record not inserted');
  //     // }
  //   });
  // }


}

