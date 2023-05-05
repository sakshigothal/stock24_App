import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/Pages/Memo/controller/memo_controller.dart';
import 'package:stock24/Pages/Product/product_details_screen.dart';
import 'package:stock24/utility.dart';
import '../Product/Controller/add_product.dart';
import 'multiselect_dealer_screen.dart';

class CreateSampleMemoScreen extends StatefulWidget {
  const CreateSampleMemoScreen({Key? key}) : super(key: key);

  @override
  State<CreateSampleMemoScreen> createState() => _CreateSampleMemoScreenState();
}

class _CreateSampleMemoScreenState extends State<CreateSampleMemoScreen> {
  final memoController = Get.put(MemoController());

  bool select = false;
  List addCategory = [];
  List addSize = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    memoController.loadMoreProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Obx(() => memoController.selecredMemoList.isEmpty ? SizedBox() : Container(
            height: 76,
            width: getWidth(context),
            color: whiteColor,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: customText('Selected : ${memoController.selecredMemoList.length}', 16, primaryColor, 'Roboto-Regular'))),
                Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                          onTap: () async{
                            Get.to(const MultiSelectDealerScreen());
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: primaryColor),
                              child: Padding(
                                  padding:const EdgeInsets.only(top: 8, bottom: 8, left: 14, right: 14),
                                  child: customText('Proceed', 22, whiteColor, 'Skia-Regular')))),
                    ))
              ],
            ),
          )),
          appBar: customAppBar(context, 'Create Sample Memo'),
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
                                  offset:const Offset(
                                    0.0, // Move to right 10  horizontally
                                    1.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                              border: Border.all(color: whiteColor)),
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
                                    borderSide: BorderSide(color: whiteColor, width: 0.1),),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: whiteColor, width: 0.1),),
                                  errorBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: whiteColor, width: 0.1),),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: whiteColor, width: 0.1),),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          return customText(
                              'Total Products  : ${memoController.totalProducts.value}', 18, primaryColor, 'Roboto-Regular');
                        }),
                      ],
                    ),
                  ),
                  Container(
                      height: getHeight(context) * 0.65,
                      width: getWidth(context),
                      child: productData()),
                ],
              ),
            ),
          ),
        ));
  }

  bottomSheet(BuildContext cont) {
    showBottomSheet(
        context: cont,
        builder: (ctx) {
          return Container(
            height: 250,
          );
        });
  }

  Widget productData() {
    return Obx(() {
      return LazyLoadScrollView(
        isLoading: memoController.isLoadingData.value,
        onEndOfPage: () async {
          memoController.loadMoreProducts(context);
        },
        child: Scrollbar(
          child: ListView(
            shrinkWrap: true,
            children: [
              GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  clipBehavior: Clip.none,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 40,
                    childAspectRatio: 0.80,
                    crossAxisCount: 2,
                  ),
                  itemCount: memoController.productList.length,
                  itemBuilder: (ctx, index) {
                    return Stack(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {
                            Get.to(const ProductDetailsScreen(check: false),
                                arguments: {
                                  'product_id': memoController.productList[index].id.toString(),
                                  'productList': memoController.productList[index].productImages,
                                  'productName': memoController.productList[index].productName,
                                  'size': memoController.productList[index].size,
                                  'body': memoController.productList[index].body,
                                  'finish': memoController.productList[index].finish,
                                  'tiles_per_box': memoController.productList[index].tilesPerBox,
                                  'sqmtr_per_box': memoController.productList[index].sqmtrPerBox,
                                  'sqft_per_box': memoController.productList[index].sqftPerBox,
                                  'price': memoController.productList[index].price,
                                  'mrp': memoController.productList[index].mrp,
                                });
                          },
                          child: Container(
                            child: Image.network(memoController.productList[index].productImages![0].image!,
                                height: getHeight(context) * 0.21,
                                fit: BoxFit.fill),
                          ),
                        ),
                        // SizedBox(height: 19),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                                padding: const EdgeInsets.only(bottom: 10, top: 10),
                                child: customText(memoController.productList[index].productName, 18, primaryColor, 'Roboto-Regular'))),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(bottom: 50, right: 9),
                            child: Obx(() => Container(
                                height: 18,
                                width: 18,
                                decoration: BoxDecoration(
                                  borderRadius: memoController.productBoolList[index] == true
                                      ? BorderRadius.circular(20)
                                      : null,
                                  color: whiteColor,
                                ),
                                child: Checkbox(
                                  value: memoController.productBoolList[index],
                                  onChanged: (value) {
                                    setState(() {
                                      print(value);
                                      memoController.productBoolList[index] = ! memoController.productBoolList[index];
                                      memoController.productBoolList[index] = value;
                                      print(value);
                                      if(value==true){
                                        memoController.selecredMemoList.add(
                                            {'id': memoController.productList[index].id.toString(),
                                              'productName': memoController.productList[index].productName,
                                              'size': memoController.productList[index].size});
                                        print('selelcted memo list ---> ${memoController.selecredMemoList.toString()}');
                                        memoController.categoryIdList.addAll({memoController.productList[index].categoryId});
                                        print('category list ---> ${memoController.categoryIdList.toString()}');
                                      }else{
                                        memoController.selecredMemoList.removeWhere((element) => element['id']==memoController.productList[index].id.toString());
                                        memoController.categoryIdList.remove(memoController.productList[index].categoryId);
                                        print(memoController.selecredMemoList.toString());
                                        print(memoController.categoryIdList.toString());
                                      }

                                    } );
                                    /*scaffoldKey.currentState!.showBottomSheet((context) => Container(
                                      height: 76,
                                      width: getWidth(context),
                                      color: whiteColor,
                                      child: Stack(
                                        children: [
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                  padding: const EdgeInsets.only(left: 20),
                                                  child: customText('Selected : ${memoController.selecredMemoList.length}', 16, primaryColor, 'Roboto-Regular'))),
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding: const EdgeInsets.only(right: 20),
                                                child: InkWell(
                                                    onTap: () async{
                                                     Get.to(const MultiSelectDealerScreen());
                                                    },
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            color: primaryColor),
                                                        child: Padding(
                                                            padding:const EdgeInsets.only(top: 8, bottom: 8, left: 14, right: 14),
                                                            child: customText('Proceed', 22, whiteColor, 'Skia-Regular')))),
                                              ))
                                        ],
                                      ),
                                    ));*/
                                  },
                                  fillColor:
                                  MaterialStateProperty.all(checkBoxColor),
                                  shape: memoController.productBoolList[index] == true ? const CircleBorder() : null,
                                ))),
                          ),
                        )
                      ],
                    );
                  }),
              memoController.isLoadingData.value
                  ? Container(
                  height: getHeight(context) * 0.05,
                  child:const Center(child: CircularProgressIndicator()))
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
    memoController.selecredMemoList.clear();
  }
}