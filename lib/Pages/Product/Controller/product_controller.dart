import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock24/Models/WishlistModel/wishlist_model.dart';
import 'package:stock24/Services/ProductService/product_service.dart';
import 'package:http/http.dart' as http;
import '../../../Models/ProductModel/finish_model.dart';
import '../../../Models/ProductModel/product_body_model.dart';
import '../../../Models/ProductModel/product_category_model.dart';
import '../../../Models/ProductModel/product_model.dart';
import '../../../Models/ProductModel/product_size_model.dart';

class ProductController extends GetxController {
  ProductService productService = ProductService();
  var getProducts = <ProductModel>{}.obs;

  // product
  RxList<Result> productList = <Result>[].obs;
  RxBool isProductLoading = false.obs;
  RxInt totalProducts = 0.obs;

  //Wishlist
  RxList<WishlistResult> wishList = <WishlistResult>[].obs;
  RxBool wishlistLoading = false.obs;
  RxInt totalWishlist = 0.obs;

  RxList sizeBoolList=[].obs;
  RxList categoryBoolList=[].obs;

  Rx<TextEditingController> productName = TextEditingController().obs;
  Rx<TextEditingController> tilesPerBox = TextEditingController().obs;
  Rx<TextEditingController> sqmrtPerBox = TextEditingController().obs;
  Rx<TextEditingController> sqftPerBox = TextEditingController().obs;
  Rx<TextEditingController> price = TextEditingController().obs;
  Rx<TextEditingController> mrp = TextEditingController().obs;
  Rx<TextEditingController> qty = TextEditingController().obs;
  RxList batch = [].obs;
  RxInt batchCount = 1.obs;
  RxList<CategoryResult> categoryList = <CategoryResult>[].obs;
  RxList<SizeResult> sizeList = <SizeResult>[].obs;
  RxList<FinishResult> finishList = <FinishResult>[].obs;
  RxList<BodyResult> bodyList = <BodyResult>[].obs;
  // RxList<Batch> batch = <Batch>[].obs;
  // RxBool filterBool = false.obs;

  RxList selectedProductBoolList=[].obs;
  RxList selectedProductList=[].obs;

  //filter api
  RxInt page_noF=1.obs;
  RxBool check=false.obs;
  RxBool isLoadingFilter=false.obs;

  //product pagination
  RxInt page_no = 1.obs;
  final limit = 10;
  RxBool isLoadingData = false.obs;

  //wishlist pagination
  RxInt page_noW = 1.obs;
  final limitW = 10;
  RxBool isLoadingDataW = false.obs;

  Future<void> loadMoreProducts(context) async {
    isLoadingData.value = true;

    final response = await productService.getProduct(page_no.value.toString(), limit.toString());
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
          for(int i=0;i<totalProducts.value;i++){
            selectedProductBoolList.add(false);
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

  Future<void> getProductCategories(context) async {
    categoryList.clear();
    categoryBoolList.clear();
    final response = await productService.getCategories();
    if (response == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed!!!!'),
        backgroundColor: Colors.red,
      ));
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        final data = productCategoryModelFromJson(response.body.toString());
        categoryList.addAll(data.data!.result!);
        for(int i=0;i < categoryList.length; i++){
          categoryBoolList.add(false);
        }
        isProductLoading.value = true;
      }
    }
  }

  Future<void> getProductSizes(context) async {
    sizeList.clear();
    sizeBoolList.clear();
    final response = await productService.getSizes();
    if (response == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed!!!!'),
        backgroundColor: Colors.red,
      ));
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        final data = productSizeModelFromJson(response.body.toString());
        sizeList.addAll(data.data!.result!);
        for(int i=0;i < sizeList.length;i++){
          sizeBoolList.add(false);
        }
        isProductLoading.value = true;
      }
    }
  }

  Future<void> getProductBody(context) async {
    bodyList.clear();
    final response = await productService.getBody();
    if (response == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed!!!!'),
        backgroundColor: Colors.red,
      ));
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        final data = productBodyModelFromJson(response.body.toString());
        bodyList.addAll(data.data!.result!);
        isProductLoading.value = true;
      }
    }
  }

  Future<void> getFinish(context) async {
    finishList.clear();
    final response = await productService.getFinish();
    if (response == '') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed!!!!'),
        backgroundColor: Colors.red,
      ));
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        final data = finishModelFromJson(response.body.toString());
        finishList.addAll(data.data!.result!);
        isProductLoading.value = true;
      }
    }
  }

  Future<void> filterApi(context, List category, List size) async {
    // productList.clear();
    isLoadingFilter.value = true;

    final response = await productService.applyFilter(
        page_noF.value.toString(), limit.toString(), category, size);

    print('response');
    if (response == '') {
      print('null response');
    } else if (response is http.Response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> decodeData = jsonDecode(response.body.toString());
        if (decodeData['success'] == '1') {
          ProductModel data = productModelFromJson(response.body.toString());
          productList.addAll(data.data!.result!);
          totalProducts.value = productList.length;
          print('filter api----> ${productList.toString()}');
          isProductLoading.value = true;
          page_noF++;
          print('page---> $page_noF');
          isLoadingFilter.value = false;
        } else {
          isLoadingFilter.value = false;
        }
      }
    }
  }

  Future<void> addNewProduct(
      context, category_id, size, body, finish, List attachment) async {
    final response = await productService.addNewProduct2(
                    category_id, productName.value.text,
                    size, body, finish, tilesPerBox.value.text,
                    sqmrtPerBox.value.text, sqftPerBox.value.text,
                    price.value.text, mrp.value.text, attachment, batch);
    print('valueMap----> ${attachment.toString()}');
    try {
      if (response != null) {
        print('controller response----> ${response.toString()}');
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
          productList.clear();
          page_no.value = 1;
          isProductLoading.value = false;
          await loadMoreProducts(context);
          Get.back();
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
        isProductLoading.value = false;
        await loadMoreProducts(context);
        Get.back();
      }
    }
  }

  Future<void> addToWishListProduct(context, product_id) async {
    final response = await productService.addToWishList(product_id);
    if (response == '') {
      print(response);
    } else if (response is http.Response) {
      Map<String, dynamic> valueMap = jsonDecode(response.body.toString());
      print('key----> ${valueMap['success']}');
      if (response.statusCode == 200) {
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
          print(response.body);
          page_noW.value = 1;
          wishlistLoading.value = false;
          await loadWishlistData(context);
          Get.back();
        }
      }
    }
  }

    Future<void> loadWishlistData(context) async {
      isLoadingDataW.value = true;
      final response = await productService.getWishList(
          page_noW.value.toString(), limitW.toString());
      print('response');
      if (response == '') {
        print('null response');
      } else if (response is http.Response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> decodeData = jsonDecode(
              response.body.toString());
          print('decode data----> ${decodeData.toString()}');
          if (decodeData['success'] == '1') {
            WishlistModel data = wishlistModelFromJson(response.body.toString());
            print(' data----> ${data.toString()}');
            // await Future.delayed(const Duration(seconds: 2));
            wishList.addAll(data.data!.result!);
            totalWishlist.value = data.data!.totalRecords!;
            wishlistLoading.value = true;
            page_noW.value++;
            print('page---> $page_noW');
            isLoadingDataW.value = false;
          } else {
            isLoadingDataW.value = false;
          }
        }
      }
    }
  }
