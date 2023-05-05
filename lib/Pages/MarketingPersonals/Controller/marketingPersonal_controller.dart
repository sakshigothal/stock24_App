import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:stock24/Models/Dashboard/dashboard_model.dart';
import 'package:stock24/Models/MarketingPersonals/getmarketing_personal_model.dart';
import 'package:stock24/Services/MarketingPersonal/marketingpersonal_service.dart';
import '../../../Models/MarketingPersonals/area_model.dart';

class GetMarketingPersonalsController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController whatsAppNo = TextEditingController();
  MarketingPersonalService marketingPersonalService = MarketingPersonalService();
  var maketingPersonalData = <GetMarketingPersonals>{}.obs;

  //for selected marketing person
  RxString selectedMarketingPerson=''.obs;
  RxString selectedMarketingPersonId=''.obs;

  RxList<Result> getMarketingList = <Result>[].obs;
  RxList<Area> getArea = <Area>[].obs;
  AreaModel? aboutUS;
  RxList<Country> getCountry = <Country>[].obs;
  RxMap countryMap = {}.obs;
  var dashboard = <DashboardModel>{};
  // List arealist = [].obs;
  RxBool dashboardLoading = false.obs;
  RxBool loading = false.obs;
  RxBool areaLoding = false.obs;
  var mySelection = ''.obs;
  RxString str = ''.obs;

  RxInt page_no = 1.obs;
  final limit = 10;
  RxBool isLoadingData = false.obs; //pagination
  RxInt total_records = 0.obs;

  //update marketing personal
  var uId;
  RxBool updateData = false.obs;

  @override
  void onClose() {
    super.onClose();
    name.dispose();
    mobileNo.dispose();
    designation.dispose();
    whatsAppNo.dispose();
  }

  // Future<void> getMarketingPersonal(context) async {
  //   maketingPersonalData.clear();
  //   loading.value = false;
  //   final response = await marketingPersonalService.getMarketingPersonals(
  //       page_no.value.toString(), limit.toString());
  //   if (response == '') {
  //     // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     //   content: Text('Failed!!!!'),
  //     //   backgroundColor: Colors.red,
  //     // ));
  //   } else if (response is http.Response) {
  //     if (response.statusCode == 200) {
  //       // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       //   content: Text('Success'),
  //       //   backgroundColor: Colors.green,
  //       // ));
  //       final data = getMarketingPersonalsFromJson(response.body.toString());

  //       maketingPersonalData.addAll({data});
  //       getMarketingList.addAll(maketingPersonalData.first.data!.result!);
  //       // showLoading(context);
  //       loading.value = true;
  //     }
  //   }
  // }

  Future<void> loadMoreHorizontal(context) async {
    // maketingPersonalData.clear();
    isLoadingData.value = true;
    final response = await marketingPersonalService.getMarketingPersonals(
        page_no.value.toString(), limit.toString());

    print('response');
    if (response == '') {
      print('null response');
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> decodeData = jsonDecode(response.body.toString());
        if (decodeData['success'] == '1') {
          GetMarketingPersonals data =
              getMarketingPersonalsFromJson(response.body.toString());

          total_records.value = data.data!.totalRecords!;
          // await Future.delayed(const Duration(seconds: 2));
         // if(data.data!.result != null){

           getMarketingList.addAll(data.data!.result!);
           print(getMarketingList.length);
           loading.value = true;
           page_no.value++;
         // }else{
           isLoadingData.value = false;
         // }
        } else {
          isLoadingData.value = false;
        }
      }
    }
  }

  Future<void> aDDMarketingPersonal(context, selected) async {
    final response = await marketingPersonalService.addMarketingPersonal(
        name.text,
        mobileNo.text,
        whatsAppNo.text,
        designation.text,
        selected.toString());
    if (response == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed!!!!'),
        backgroundColor: Colors.red,
      ));
    } else if (response is http.Response) {
      Map<String, dynamic> decodeData = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        if (decodeData['success'] == '0') {
          Get.back();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${decodeData['message']}'),
            backgroundColor: Colors.red,
          ));
        }else if (decodeData['success'] == '1') {
          Get.back();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${decodeData['message']}'),
            backgroundColor: Colors.green,
          ));
          loading.value = false;
          await loadMoreHorizontal(context);
          // await getMarketingPersonal(context);

          print('add api----> ${response.body}');
          // update();
        }

      }
    }
  }

  Future<void> uPdateMarketingPersonal(context, selected) async {
    final response = await marketingPersonalService.updateMarketingPersonal(uId,
        name.text, mobileNo.text, whatsAppNo.text, designation.text, selected);
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
          getMarketingList.clear();
          page_no.value = 1;
          loading.value = false;
          await loadMoreHorizontal(context);
          Get.back();
        }
        print('update  data---> ${response.body}');
      }
    }
  }

  Future<void> deleteUser(context, id) async {
    final response = await marketingPersonalService.deleteUser(id);
    if (response == '') {
      print(response);
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        print(response.body);
        // showLoading(context);
        getMarketingList.clear();
        page_no.value = 1;
        loading.value = false;
        await loadMoreHorizontal(context);
      }
    }
  }

  Future<void> getDashBoardData() async {
    dashboard.clear();
    dashboardLoading.value = false;
    final response = await marketingPersonalService.getDashboardData();
    if (response == '') {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text('Failed!!!!'),
      //   backgroundColor: Colors.red,
      // ));
      print(response);
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content: Text('Success'),
        //   backgroundColor: Colors.green,
        // ));
        print(response.body);
        final data = dashboardModelFromJson(response.body.toString());
        dashboard.addAll({data});
        dashboardLoading.value = true;
      }
    }
  }

  Future<void> getAreaList(context) async {
    getArea.clear();
    getCountry.clear();
    final response = await marketingPersonalService.getArea();
    if (response == '') {
      
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        final data = areaModelFromJson(response.body.toString());
        aboutUS=areaModelFromJson(response.body.toString());
        getArea.addAll(data.data!.area!);
        getCountry.addAll(data.data!.countries!);
        getCountry.forEach(
          (element) {
            countryMap.addAll({'${element.id}': '${element.countryName}'});
          },
        );
        areaLoding.value = true;
      }
    }
  }
}
