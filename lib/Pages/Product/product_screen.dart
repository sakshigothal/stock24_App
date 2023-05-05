import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/Pages/Product/Controller/product_controller.dart';
import 'package:stock24/Pages/Product/product_details_screen.dart';
import 'package:stock24/utility.dart';
import 'package:http/http.dart' as http;
import 'Controller/add_product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final productController = Get.put(ProductController());
  bool select = false;
  List addCategory = [];
  List addSize = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    productController.loadMoreProducts(context);
    /*productController.getProductCategories(context);
    productController.getProductSizes(context);*/
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(() => productController.selectedProductList.isEmpty ? SizedBox()  : Container(
        height: 100,
        width: getWidth(context),
        color: whiteColor,
        child: Stack(
          children: [
            Padding(
                padding:
                const EdgeInsets.only(top: 15, left: 20),
                child: customText('Selected : ${productController.selectedProductList.length}', 16, primaryColor,'Roboto-Regular')),
            Padding(
                padding:
                const EdgeInsets.only(top: 55, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: ()async{
                        final uri=Uri.parse(productController.selectedProductList[0].toString());
                        final res=await http.get(uri);
                        final bytes=res.bodyBytes;
                        final temp=await getTemporaryDirectory();
                        final path='${temp.path}/image.jpg';
                        File(path).writeAsBytesSync(bytes);
                        Share.shareFiles([path]);
                      },
                      child: Row(children: [
                        SvgPicture.asset('assets/Common/share_icon.svg'),
                        Padding(
                          padding:const EdgeInsets.only(left: 10),
                          child: customText('Share Image only', 16, primaryColor, 'Roboto-Regular'),
                        )
                      ]),
                    ),
                  ],
                )),
          ],
        ),
      )),
      appBar: customAppBar(context, 'Products'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding:GetStorage().read('role') != 'dealer' ? const EdgeInsets.only(right: 0) :const EdgeInsets.only(right: 10) ,
                    child: Container(
                      height: 56,
                      width: GetStorage().read('role') != 'dealer' ?  getWidth(context) *0.89 : getWidth(context) * 0.65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: whiteColor,
                          shape: BoxShape.rectangle,
                          boxShadow: [
                            BoxShadow(
                              color:const Color(0xff6C62A3).withOpacity(0.4),
                              blurRadius: 7.0, // soften the shadow
                              spreadRadius: 0.2, //extend the shadow
                              offset: const Offset(
                                0.0, // Move to right 10  horizontally
                                1.0, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                          border: Border.all(color: whiteColor,)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextFormField(
                            cursorColor: primaryColor,
                            decoration: InputDecoration(
                              hintText: 'Search here',
                              enabled: true,
                              filled: true,
                              fillColor: whiteColor /*Colors.red*/,
                              hintStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: const Color(0xff1B285C).withOpacity(0.1),
                                  fontFamily: 'Poppins Regular'),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: whiteColor, width: 0.1)),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: whiteColor, width: 0.1),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: whiteColor, width: 0.1),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: whiteColor, width: 0.1),
                              ),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: whiteColor, width: 0.1),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                 GetStorage().read('role') == 'dealer' ? InkWell(
                    onTap: () {
                      Get.to(AddProduct());
                    },
                    child: Container(
                      height: 56,
                      width: getWidth(context) * 0.21,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: primaryColor),
                      child: Center(
                          child: customText('ADD', 20, whiteColor, 'Roboto-Regular')),
                    ),
                  ) : SizedBox(),
                ],
              ),
              // productController.isProductLoading.value ?
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          return customText(
                              'Total Products  : ${productController.totalProducts.value}', 18, primaryColor, 'Roboto-Regular');
                        }),
                        InkWell(
                          onTap: () {
                            productController.getProductCategories(context);
                            productController.getProductSizes(context);
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    content: Container(
                                      height: getHeight(context) * 0.40,
                                      width: getWidth(context),
                                      color: whiteColor,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                              child: customText('Apply Filters', 18, primaryColor, 'Roboto-Regular')),
                                          Padding(
                                              padding: const EdgeInsets.only(top: 15, bottom: 8),
                                              child: customText('Select Category', 17, primaryColor, 'Roboto-Regular')),
                                          Obx(() => StaggeredGrid.count(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 5,
                                              crossAxisSpacing: 5,
                                              children: List.generate(productController.categoryList.length, (index) {
                                                return InkWell(
                                                  onTap: ()async{
                                                    setState(() {
                                                      addCategory.add(productController.categoryList[index].id);
                                                    });
                                                    productController.categoryBoolList[index]=!productController.categoryBoolList[index];
                                                  },
                                                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                                      color:productController.categoryBoolList[index] == true ?primaryColor: Colors.grey.shade300),
                                                    child: Padding(padding:const EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 10),
                                                      child: Center(child: customText(productController.categoryList[index].categoryName, 17,productController.categoryBoolList[index] == true ? whiteColor : primaryColor, 'Roboto_Regular')),),
                                                  ),
                                                );

                                              })),),
                                          Padding(
                                              padding: const EdgeInsets.only(top: 15, bottom: 8),
                                              child: customText('Select Size', 17, primaryColor, 'Roboto-Regular')),
                                          Obx(() =>  StaggeredGrid.count(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10,
                                              children: List.generate(productController.sizeList.length,
                                                      (index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          addSize.add(productController.sizeList[index].size);
                                                          productController.sizeBoolList[index]=!productController.sizeBoolList[index];
                                                        });
                                                        print(productController.sizeList[index].size);
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(15),
                                                            color: productController.sizeBoolList[index]==true ? primaryColor : Colors.grey.shade300),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 8,bottom: 8,left: 10,right: 10),
                                                          child: Center(
                                                              child: customText(productController.sizeList[index].size, 17,productController.sizeBoolList[index]==true ? whiteColor : primaryColor, 'Roboto_Regular')),
                                                        ),
                                                      ),
                                                    );
                                                  })),),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 20),
                                            child: Row(
                                              mainAxisAlignment:MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                    onPressed: () async {
                                                      Get.back();
                                                    },
                                                    child: customText('Cancel',15,primaryColor,'Roboto-Regular')),
                                                TextButton(
                                                    onPressed: () async {
                                                      productController.filterApi(context,addCategory,addSize);
                                                      Get.back();
                                                      productController.productList.clear();
                                                      productController.page_noF.value=1;
                                                      setState(() {
                                                        addSize.clear();
                                                        addCategory.clear();
                                                      });
                                                      // productController.sizeBoolList.clear();
                                                    },
                                                    child: customText('Apply', 15, primaryColor,'Roboto-Regular'))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Row(
                            children: [
                              customText('Filter', 18, primaryColor, 'Roboto-Regular'),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child:
                                SvgPicture.asset('assets/Common/filter_data.svg'),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: getHeight(context) * 0.65,
                      width: getWidth(context),
                      child: productData()),
                ],
              )
              //     : Center(
              //   child: CircularProgressIndicator(),
              // )
            ],
          ),
        ),
      ),
    ));
  }

  Widget productData() {
    return Obx(() {
      return LazyLoadScrollView(
        isLoading: productController.isLoadingData.value,
        onEndOfPage: () async {
          productController.loadMoreProducts(context);
        },
        child: Scrollbar(
          child: ListView(
            shrinkWrap: true,
            children: [
              GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  clipBehavior: Clip.none,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 40,
                    childAspectRatio: 0.80,
                    crossAxisCount: 2,
                  ),
                  itemCount: productController.productList.length,
                  itemBuilder: (ctx, index) {
                    return Stack(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            Get.to(ProductDetailsScreen(check: false),
                                arguments: {
                                  'batch':productController.productList[index].batch,
                                  'product_id': productController.productList[index].id.toString(),
                                  'productList': productController.productList[index].productImages,
                                  'productName': productController.productList[index].productName,
                                  'size': productController.productList[index].size,
                                  'body': productController.productList[index].body,
                                  'finish': productController.productList[index].finish,
                                  'tiles_per_box': productController.productList[index].tilesPerBox,
                                  'sqmtr_per_box': productController.productList[index].sqmtrPerBox,
                                  'sqft_per_box': productController.productList[index].sqftPerBox,
                                  'price': productController.productList[index].price,
                                  'mrp': productController.productList[index].mrp,
                                });
                          },
                          child: Container(
                            child: Image.network(productController.productList[index].productImages![0].image!,
                                height: getHeight(context) * 0.21,
                                fit: BoxFit.fill),
                          ),
                        ),
                        // SizedBox(height: 19),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                                padding:const EdgeInsets.only(bottom: 10, top: 10),
                                child: customText(productController.productList[index].productName, 18, primaryColor, 'Roboto-Regular'))),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 50, right: 9),
                            child: Obx(() => Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  borderRadius: productController.selectedProductBoolList[index] == true
                                      ? BorderRadius.circular(20)
                                      : null,
                                  color: whiteColor,
                                ),
                                child:  Checkbox(
                                  value: productController.selectedProductBoolList[index],
                                  onChanged: (value) {
                                    // setState(() {
                                      productController.selectedProductBoolList[index] = ! productController.selectedProductBoolList[index];
                                      productController.selectedProductBoolList[index] = value!;
                                      if(value==true){
                                        productController.selectedProductList.add(productController.productList[index].productImages![0].image);
                                      }else{
                                        productController.selectedProductList.remove(productController.productList[index].productImages![0].image);
                                      }
                                    print(productController.selectedProductBoolList.toString());
                                    // });
                                    /*scaffoldKey.currentState!
                                        .showBottomSheet((context) => Container(
                                      height: 100,
                                      width: getWidth(context),
                                      color: whiteColor,
                                      child: Stack(
                                        children: [
                                          Padding(
                                              padding:
                                              const EdgeInsets.only(top: 15, left: 20),
                                              child: customText('Selected : ${productController.selectedProductList.length}', 16, primaryColor,'Roboto-Regular')),
                                          Padding(
                                              padding:
                                              const EdgeInsets.only(top: 55, left: 20),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: ()async{
                                                      final uri=Uri.parse(productController.selectedProductList[0].toString());
                                                      final res=await http.get(uri);
                                                      final bytes=res.bodyBytes;
                                                      final temp=await getTemporaryDirectory();
                                                      final path='${temp.path}/image.jpg';
                                                      File(path).writeAsBytesSync(bytes);
                                                      Share.shareFiles([path]);
                                                    },
                                                    child: Row(children: [
                                                      SvgPicture.asset('assets/Common/share_icon.svg'),
                                                      Padding(
                                                        padding:const EdgeInsets.only(left: 10),
                                                        child: customText('Share Image only', 16, primaryColor, 'Roboto-Regular'),
                                                      )
                                                    ]),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ));*/
                                  },
                                  fillColor: MaterialStateProperty.all(checkBoxColor),
                                  shape: productController.selectedProductBoolList[index] == true ? CircleBorder() : null,
                                ))),
                          ),
                        )
                      ],
                    );
                  }),
              productController.isLoadingData.value
                  ? Container(
                      height: getHeight(context) * 0.05,
                      child: const Center(child: CircularProgressIndicator()))
                  : const SizedBox()
            ],
          ),
        ),
      );
    });
  }
  @override
  void dispose() {
    super.dispose();
    productController.productList.clear();
    productController.page_no.value=1;
    productController.selectedProductBoolList.clear();
    productController.selectedProductList.clear();
  }
}
