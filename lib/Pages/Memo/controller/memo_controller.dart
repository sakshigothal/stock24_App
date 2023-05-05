import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:stock24/Models/MemoModel/memo_model.dart';
import 'package:stock24/Services/MemoService/memo_service.dart';
import '../../../Models/ProductModel/product_model.dart';
import '../../../Services/ProductService/product_service.dart';
import '../sample_memo_view_screen.dart';

class MemoController extends GetxController {
  ProductService productService = ProductService();
  var getProducts = <ProductModel>{}.obs;
  RxList productBoolList=[].obs;
  RxList selecredMemoList=[].obs;
  RxList categoryIdList=[].obs;
  RxList<TextEditingController> qtyController = <TextEditingController>[].obs;

  //product pagination
  RxInt page_no = 1.obs;
  final limit = 10;
  RxBool isLoadingData = false.obs;

  //Memo pagination
  RxInt page_noM = 1.obs;
  final limitM = 10;
  RxBool isLoadingDataM = false.obs;
  RxInt totalPcs=0.obs;

  // product
  RxList<Result> productList = <Result>[].obs;
  RxBool isProductLoading = false.obs;
  RxInt totalProducts = 0.obs;


  //Memo
  MemoService memoService=MemoService();
  RxList<MemoResult> memoList=<MemoResult>[].obs;
  RxBool isMemoLoading=false.obs;
  RxInt totalMemo=0.obs;


  Future<void> loadMoreProducts(context) async {
    isLoadingData.value = true;

    final response = await productService.getProduct(
        page_no.value.toString(), limit.toString());
    print('response');
    if (response == '') {
      print('null response');
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> decodeData = jsonDecode(response.body.toString());
        print('decode data----> ${decodeData.toString()}');
        if (decodeData['success'] == '1') {
          ProductModel data = productModelFromJson(response.body.toString());
          print(' data----> ${data.toString()}');
          // await Future.delayed(const Duration(seconds: 2));
          productList.addAll(data.data!.result!);
          totalProducts.value = data.data!.totalRecords!;
          for(int i = 0; i < totalProducts.value; i++){
            productBoolList.add(false);
          }
          isProductLoading.value = true;
          page_no.value++;
          print('page---> $page_no');
          isLoadingData.value = false;
        } else {
          isLoadingData.value = false;
        }
      }
    }
  }


  Future<void> loadMemo(context) async {
    // memoList.clear();
    isLoadingDataM.value = true;

    final response = await memoService.getMemo(page_noM.value.toString(), limitM.toString());

    print('response');
    if (response == '') {
      print('null response');
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> decodeData = jsonDecode(response.body.toString());
        if (decodeData['success'] == '1') {
          MemoModel data = memoModelFromJson(response.body.toString());
          // await Future.delayed(const Duration(seconds: 2));
          memoList.addAll(data.data!.result!);
          totalMemo.value = data.data!.totalRecords!;
          isMemoLoading.value = true;
          page_noM.value++;
          print('page---> $page_noM');
          isLoadingDataM.value = false;
        } else {
          isLoadingDataM.value = false;
        }
      }
    }
  }


  Future<void> addNewMemo(context,List dealers,List category_id,List sample_data) async {
    final response = await memoService.createMemo(GetStorage().read('dealer')['id'] ?? dealers,category_id,sample_data);

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
            print('Sucess');
            Get.to(SampleMemoViewScreen());
            // subDealerList.clear();
            // page_no.value = 1;
            // subDealerDataLoading.value = false;
            // await loadMoreSubDealer(context);
            // Get.back();
            // Get.to(const SubDealersDetailsScreen(),
            //     arguments: {
            //       'firmname': firmName.value.text,
            //       'contactPerson':contactPerson.value.text,
            //       'mobileNumber': mobileNumber.value.text,
            //       'whatsAppNumber':whatsAppNumber.value.text,
            //       'area':area,
            //       'pincode':pincode.value.text,
            //       'frontSide':file1.path,
            //       'backSide': file2.path,
            //       'dealers':selectedDealerList
            //     });
          }
        }else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Internet connection failed!!!'),
            backgroundColor: Colors.red,
          ));
        }
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
        // subDealerList.clear();
        // page_no.value = 1;
        // subDealerDataLoading.value = false;
        // await loadMoreSubDealer(context);
        // Get.back();
      }
    }
  }
}
