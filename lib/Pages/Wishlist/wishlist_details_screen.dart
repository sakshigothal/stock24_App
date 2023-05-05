import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/Pages/Product/Controller/product_controller.dart';
import 'package:stock24/utility.dart';

import '../../Models/WishlistModel/wishlist_model.dart';

class WishlistDetailsScreen extends StatefulWidget {
  const WishlistDetailsScreen({Key? key}) : super(key: key);

  @override
  State<WishlistDetailsScreen> createState() => _WishlistDetailsScreenState();
}

class _WishlistDetailsScreenState extends State<WishlistDetailsScreen> {
  final productController = Get.put(ProductController());
  PageController controller = PageController();
  var product_id;
  var productName;
  var size;
  var body;
  var finish;
  var tiles_per_box;
  var sqmtr_per_box;
  var sqft_per_box;
  var price;
  var mrp;
  List<ProductImage> product_images = [];
  List product = [];
  @override
  void initState() {
    super.initState();
    product_id = Get.arguments['product_id'];
    productName = Get.arguments['productName'];
    size = Get.arguments['size'];
    body = Get.arguments['body'];
    finish = Get.arguments['finish'];
    tiles_per_box = Get.arguments['tiles_per_box'];
    sqmtr_per_box = Get.arguments['sqmtr_per_box'];
    sqft_per_box = Get.arguments['sqft_per_box'];
    price = Get.arguments['price'];
    mrp = Get.arguments['mrp'];
    product_images = Get.arguments['productList'];
    // print('product--Image---> ${product_images.}');

    for (var i = 0; i < product_images.length; i++) {
      print('product_image---->${product_images[i]}');
      product.add(product_images[i].image);
      print('length--->${product.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: customAppBar(context, 'Product Details'),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            height: 165,
                            width: 165,
                            child: PageView.builder(
                                controller: controller,
                                itemCount: product.length,
                                itemBuilder: (ctx, index) {
                                  return showPageView(product[index]);
                                }),
                          ),
                        ),
                      ],
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, top: 20),
                          child: SvgPicture.asset('assets/Common/share_icon2.svg'),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 19),
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: product.length,
                    effect: const SlideEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        activeDotColor: primaryColor,
                        paintStyle: PaintingStyle.stroke),
                  ),
                ),
                showDottedDash(),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                          'Contact Dealer', 16, primaryColor, 'Roboto-Regular'),
                      Row(
                        children: [
                          SvgPicture.asset('assets/Common/green_whatsapp.svg'),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: InkWell(
                                onTap: () {
                                  userCall('282265558');
                                },
                                child: SvgPicture.asset(
                                    'assets/Common/call_icon.svg')),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                showDottedDash(),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 19, bottom: 15, left: 20, right: 20),
                  child: Row(
                    children: [
                      customText(
                          'Product Name', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                        padding: const EdgeInsets.only(left: 46, right: 13),
                        child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                      ),
                      customText(productName, 16, primaryColor, 'Roboto-Regular')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                  child: Row(
                    children: [
                      customText('Size', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                        padding:const EdgeInsets.only(left: 120, right: 13),
                        child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                      ),
                      customText(size.toString().substring(4), 16, primaryColor,
                          'Roboto-Regular')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                  child: Row(
                    children: [
                      customText('Body', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                        padding: const EdgeInsets.only(left: 114, right: 13),
                        child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                      ),
                      customText(body.toString().substring(5), 16, primaryColor,
                          'Roboto-Regular')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                  child: Row(
                    children: [
                      customText('Finish', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                        padding:const EdgeInsets.only(left: 106, right: 13),
                        child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                      ),
                      customText(finish, 16, primaryColor, 'Roboto-Regular')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                  child: Row(
                    children: [
                      customText(
                          'Tiles per box', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                        padding:const EdgeInsets.only(left: 58, right: 13),
                        child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                      ),
                      customText(tiles_per_box, 16, primaryColor, 'Roboto-Regular')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                  child: Row(
                    children: [
                      customText(
                          'Sqmtr Per box', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                        padding:const EdgeInsets.only(left: 48, right: 13),
                        child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                      ),
                      customText(sqmtr_per_box, 16, primaryColor, 'Roboto-Regular')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                  child: Row(
                    children: [
                      customText(
                          'Sqft per box', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                        padding:const EdgeInsets.only(left: 61, right: 13),
                        child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                      ),
                      customText(sqft_per_box, 16, primaryColor, 'Roboto-Regular')
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                  child: Row(
                    children: [
                      customText(
                          'Ava Qty', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                        padding:const EdgeInsets.only(left: 93, right: 13),
                        child: customText(
                            ':', 16, primaryColor, 'Roboto-Regular'),
                      ),
                      customText(
                          'B1 - 40 Box', 16, primaryColor, 'Roboto-Regular')
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 148, right: 13),
                        child: customText(
                            ':', 16, primaryColor, 'Roboto-Regular'),
                      ),
                      customText(
                          'B2 - 30 Box', 16, primaryColor, 'Roboto-Regular')
                    ],
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding:const EdgeInsets.only(left: 148, right: 13),
                        child: customText(
                            ':', 16, primaryColor, 'Roboto-Regular'),
                      ),
                      customText(
                          'B3 - 139 Box', 16, primaryColor, 'Roboto-Regular')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                  child: Row(
                    children: [
                      customText('Price', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                        padding:const EdgeInsets.only(left: 114, right: 13),
                        child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                      ),
                      customText(price, 16, primaryColor, 'Roboto-Regular')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                  child: Row(
                    children: [
                      customText('MRP', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                        padding: const EdgeInsets.only(left: 115, right: 13),
                        child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                      ),
                      customText(mrp, 16, primaryColor, 'Roboto-Regular')
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      customText('Staus', 16, primaryColor, 'Roboto-Regular'),
                      Padding(
                        padding:const EdgeInsets.only(left: 108, right: 13),
                        child: customText(':', 16, primaryColor, 'Roboto-Regular'),
                      ),
                      customText('Running', 16, primaryColor, 'Roboto-Regular')
                    ],
                  ),
                ),
                const SizedBox(height: 40)
              ],
            ),
          ),
        ));
  }

  Widget showPageView(image) {
    return Container(
        height: 165,
        width: 165,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(image, fit: BoxFit.fill)));
  }

  openAlert() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            insetPadding:const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            alignment: Alignment.center,
            child: Container(
              height: getHeight(context) * 0.4,
              width: 289,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 32, bottom: 27),
                        child: customText('Select Quantity', 16, primaryColor,
                            'Roboto-Regular')),
                    Padding(
                      padding:
                      const EdgeInsets.only(bottom: 8, left: 34, right: 34),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('B1 - 40 Box'),
                          Container(
                            height: 35,
                            width: 93,
                            child: Center(
                              child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:const BorderSide(width: 0.2)),
                                    hintText: 'Box',
                                    hintStyle:const TextStyle(fontFamily: 'Roboto-Regular', fontSize: 14)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(bottom: 8, left: 34, right: 34),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         const Text('B2 - 30 Box'),
                          Container(
                            height: 35,
                            width: 93,
                            child: Center(
                              child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:const BorderSide(width: 0.2)),
                                    hintText: 'Box',
                                    hintStyle:const TextStyle(fontFamily: 'Roboto-Regular', fontSize: 14)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 34, right: 34),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('B3 - 139 Box'),
                          Container(
                            height: 35,
                            width: 93,
                            child: Center(
                              child: TextField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide:const BorderSide(width: 0.2)),
                                    hintText: 'Box',
                                    hintStyle:const TextStyle(fontFamily: 'Roboto-Regular', fontSize: 14)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            print('product_id ----> $product_id');
                            // openAlert();
                          },
                          child: Container(
                            height: 55,
                            width: getWidth(context) * 0.38,
                            decoration: BoxDecoration(
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(10),
                                color: whiteColor),
                            child: Center(
                                child: customText('Proceed', 22, primaryColor,
                                    'Skia-Regular')),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
