import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:stock24/Pages/Wishlist/wishlist_details_screen.dart';
import 'package:stock24/utility.dart';
import '../../Colors/colors.dart';
import '../Product/Controller/product_controller.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final productController = Get.put(ProductController());
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    productController.loadWishlistData(context);

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: customAppBar(context, 'Wishlist'),
          body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
                children: [
                  Container(
                    height: 56,
                    width: getWidth(context),
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
                        border: Border.all(
                          color: whiteColor,
                        )),
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
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    10.0,
                                  ),
                                ),
                                borderSide: BorderSide(
                                    color: whiteColor, width: 0.1)),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                              BorderSide(color: whiteColor, width: 0.1),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                              BorderSide(color: whiteColor, width: 0.1),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                              BorderSide(color: whiteColor, width: 0.1),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                              BorderSide(color: whiteColor, width: 0.1),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          return customText('Total Products  : ${productController.totalWishlist.value}', 18, primaryColor, 'Roboto-Regular');
                        }),
                      ],
                    ),
                  ),
                  Container(
                      height: getHeight(context) * 0.65,
                      width: getWidth(context),
                      child: wishlistData()),
                ],
            ),),
          ),
    ));
  }


  Widget wishlistData() {
    return Obx(() {
      return LazyLoadScrollView(
        isLoading: productController.isLoadingDataW.value,
        onEndOfPage: () async {
          productController.loadWishlistData(context);
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
                  itemCount: productController.wishList.length,
                  itemBuilder: (ctx, index) {
                    return Stack(
                      children: [
                        InkWell(
                          onTap: () async {
                            Get.to(const WishlistDetailsScreen(),
                                arguments: {
                                  'product_id': productController.wishList[index].id.toString(),
                                  'productList': productController.wishList[index].productImages,
                                  'productName': productController.wishList[index].productName,
                                  'size': productController.wishList[index].size,
                                  'body': productController.wishList[index].body,
                                  'finish': productController.wishList[index].finish,
                                  'tiles_per_box': productController.wishList[index].tilesPerBox,
                                  'sqmtr_per_box': productController.wishList[index].sqmtrPerBox,
                                  'sqft_per_box': productController.wishList[index].sqftPerBox,
                                  'price': productController.wishList[index].price,
                                  'mrp': productController.wishList[index].mrp,
                                });
                          },
                          child: Container(
                            child: Image.network(
                                productController.wishList[index].productImages![0].image!,
                                height: getHeight(context) * 0.21,
                                fit: BoxFit.fill),
                          ),
                        ),
                        // SizedBox(height: 19),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                                padding:const EdgeInsets.only(bottom: 10, top: 10),
                                child: customText(productController.wishList[index].productName, 18,
                                    primaryColor, 'Roboto-Regular'))),
                      ],
                    );
                  }),
              productController.isLoadingDataW.value
                  ?  Container(
                  height: getHeight(context) * 0.05,
                  child: const Center(child: CircularProgressIndicator()))
                  : const SizedBox()
            ],
          ),
        ),
      );
    });
  }
}
