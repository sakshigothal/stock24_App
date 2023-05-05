import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/Pages/AboutScreen/aboutUs_screen.dart';
import 'package:stock24/Pages/Dealers/dealers_screen.dart';
import 'package:stock24/Pages/Product/product_screen.dart';
import 'package:stock24/Pages/MarketingPersonals/Controller/marketingPersonal_controller.dart';
import 'package:stock24/Pages/MarketingPersonals/marketing_personal_screen.dart';
import 'package:stock24/Pages/Sub%20Dealers/Controller/subdealer_controller.dart';
import 'package:stock24/Pages/Sub%20Dealers/sub_dealers_screen.dart';
import 'package:stock24/Pages/WelcomeScreen/Controller/signup_controller.dart';
import 'package:stock24/Pages/WelcomeScreen/welcome_screen.dart';
import 'package:stock24/Services/MarketingPersonal/marketingpersonal_service.dart';
import 'package:stock24/utility.dart';

import '../ContactUs/contactus_screen.dart';
import '../Memo/create_sample_memo_screen.dart';
import '../Memo/sample_memo_screen.dart';
import '../Product/Controller/product_controller.dart';
import '../Wishlist/wishlist_screen.dart';

class MarketingPersonalsScreen extends StatefulWidget {
  const MarketingPersonalsScreen({Key? key}) : super(key: key);

  @override
  State<MarketingPersonalsScreen> createState() =>
      _MarketingPersonalsScreenState();
}

class _MarketingPersonalsScreenState extends State<MarketingPersonalsScreen> {
  final controller = Get.put(SignupController());
  final subDealerControler = Get.put(SubDealerController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MarketingPersonalService marketingPersonalService =
      MarketingPersonalService();
  final getMarketingData = Get.put(GetMarketingPersonalsController());
  final productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    getMarketingData.getDashBoardData();
    productController.loadWishlistData(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset:false,
            key: _scaffoldKey,
            drawer: Drawer(
              elevation: 10,
              child: ListView(
                clipBehavior: Clip.none,
                  addAutomaticKeepAlives:false,
                  addRepaintBoundaries:false,
                  addSemanticIndexes:false,
                children: [
                  Container(
                    width: getWidth(context),
                    height: 180,
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      decoration: BoxDecoration(color: primaryColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: 'Stock',
                                style: TextStyle(
                                  fontSize: 33,
                                  fontFamily: 'Skia-Regular',
                                  color: whiteColor,
                                )),
                            TextSpan(
                                text: '24',
                                style: TextStyle(
                                  fontSize: 33,
                                  fontFamily: 'Papyrus-Regular',
                                  color: whiteColor,
                                )),
                          ])),
                          customText('Next Generation App', 13, whiteColor, 'Skia-Regular'),
                          const SizedBox(height: 40),
                          GetStorage().read('Name') != null
                              ? customText('${GetStorage().read('Name') } - ${GetStorage().read('role')}', 17, whiteColor, 'Skia-Regular')
                              :const SizedBox(),
                          const SizedBox(height: 5),
                          GetStorage().read('MobileNumber') != null
                              ? customText(GetStorage().read('MobileNumber'), 17, whiteColor, 'Skia-Regular')
                              : const SizedBox()
                        ],
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 35, left: 30, top: 10),
                    child: InkWell(
                      onTap: ()async{
                        _scaffoldKey.currentState!.closeDrawer();
                      },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(     Icons.home, color: primaryColor, size: 30,),
                          ),
                          customText('Home', 20, primaryColor, 'Skia-Regular')
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35, left: 30),
                    child: InkWell(
                      onTap: () async {
                        Get.to(const AboutUsScreen());
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: SvgPicture.asset('assets/Common/dealers.svg', width: 30),
                          ),
                          customText('About Us', 20, primaryColor, 'Skia-Regular')
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35, left: 30),
                    child: InkWell(
                      onTap: () async {
                        Get.to(const ContactUsScreen());
                      },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.contact_support,
                              color: primaryColor,
                              size: 30,
                            ),
                          ),
                          customText('Contact Us', 20, primaryColor, 'Skia-Regular')
                        ],
                      ),
                    ),
                  ),
                  GetStorage().read('role') == 'company admin' ||
                          GetStorage().read('role') == 'marketing person' ||
                      GetStorage().read('role') == 'sub dealer'
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 35, left: 30),
                          child: InkWell(
                            onTap: () async {
                              Get.to(const CreateSampleMemoScreen());
                            },
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    Icons.create,
                                    color: primaryColor,
                                    size: 30,
                                  ),
                                ),
                                customText('Create Memo', 20, primaryColor, 'Skia-Regular')
                              ],
                            ),
                          ),
                        ),
                  GetStorage().read('role') == 'company admin' ||
                          GetStorage().read('role') == 'marketing person'
                      ?const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 35, left: 30),
                          child: InkWell(
                            onTap: () async {
                              Get.to(const SampleMemoScreen());
                            },
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(Icons.notes, color: primaryColor, size: 30),
                                ),
                                customText('Memo', 20, primaryColor, 'Skia-Regular')
                              ],
                            ),
                          ),
                        ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                contentPadding: const EdgeInsets.only(left: 20, right: 20),
                                content: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 150,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      customText('Are you sure,Do you want to Logout?', 18, primaryColor, 'Roboto-Regular'),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          TextButton(
                                              onPressed: () async {
                                                final box = GetStorage();
                                                box.erase();
                                                box.remove('token');
                                                GetStorage().remove('MobileNumber');
                                                GetStorage().remove('Name');
                                                Get.deleteAll();
                                                Get.back();
                                                Get.to(const WelcomeScreen());
                                              },
                                              child: customText('Yes', 18, primaryColor, 'Roboto-Regular')),
                                          TextButton(
                                              onPressed: () async {
                                                Get.back();
                                              },
                                              child: customText('No', 18, primaryColor, 'Roboto-Regular'))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.logout,
                              color: primaryColor,
                              size: 30,
                            ),
                          ),
                          customText('Log Out', 20, primaryColor, 'Skia-Regular')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 25),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                            onTap: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                            child: SvgPicture.asset('assets/Common/Group 94.svg'))),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: getWidth(context) * 0.65,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: 'Stock',
                                style: TextStyle(
                                  fontSize: 33,
                                  fontFamily: 'Skia-Regular',
                                  color: primaryColor,
                                )),
                            TextSpan(
                                text: '24',
                                style: TextStyle(
                                  fontSize: 33,
                                  fontFamily: 'Papyrus-Regular',
                                  color: primaryColor,
                                )),
                          ])),
                          const Text(
                            'Next Generation App',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              color: primaryColor,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 15.0,
                              // fontFamily: 'Poppins Medium',
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 15),
                    child: Obx(() {
                      return getMarketingData.dashboardLoading.value
                          ? Column(children: [
                              GetStorage().read('role') == 'marketing person' ||
                                      GetStorage().read('role') == 'dealer' ||
                                      GetStorage().read('role') == 'sub dealer'
                                  ?const SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        // if(getMarketingData.dash)
                                        Get.to(const DetailsScreen());
                                      },
                                      child: commonContainer('assets/Common/mPersonal.svg',
                                          getMarketingData.dashboard.first.data!.marketingPersonsCount, 'Marketing Personals'),
                                    ),
                              const SizedBox(height: 18),
                              GetStorage().read('role') == 'sub dealer' ||
                                      GetStorage().read('role') == 'dealer'
                                  ?const SizedBox()
                                  : InkWell(
                                      onTap: () async {
                                        // dealerController.getDealerData(context);
                                        Get.to(const DealersScreen());
                                      },
                                      child: commonContainer('assets/Common/dealers.svg',
                                          getMarketingData.dashboard.first.data!.dealersCount, 'Dealers'),
                                    ),
                              const SizedBox(height: 18),
                              GetStorage().read('role') == 'sub dealer'
                                  ? const SizedBox()
                                  : InkWell(
                                      onTap: () async {
                                        Get.to(const SubDealersScreen());
                                      },
                                      child: commonContainer('assets/Common/sub_dealers.svg',
                                          getMarketingData.dashboard.first.data!.subdealersCount, 'Sub-Dealers')),
                              const SizedBox(height: 18),
                              InkWell(
                                  onTap: () async{
                                    Get.to(const ProductScreen());
                                  },
                                  child: commonContainer('assets/Common/product.svg',
                                      getMarketingData.dashboard.first.data!.productsCount, 'Products')),
                              const SizedBox(height: 18),
                              GetStorage().read('role') == 'company admin' ||
                                      GetStorage().read('role') ==
                                          'marketing person' ||
                                      GetStorage().read('role') == 'dealer'
                                  ? const SizedBox()
                                  : InkWell(onTap: () {
                                      Get.to(const WishListScreen());
                                    }, child: Obx(() {
                                      return commonContainer('assets/Common/order.svg',
                                          productController.totalWishlist.value, 'Wishlist');
                                    })),
                              const SizedBox(height: 18),
                            ])
                          :  Container(
                              height: getHeight(context),
                              width: getWidth(context),
                              child: const Center(child: CircularProgressIndicator()));
                    })),
              ]),
            )));
  }

  Widget commonContainer(image, total, stock) {
    return Container(
        height: 136,
        width: getWidth(context),
        decoration: BoxDecoration(
            color: whiteColor,
            // border: Border.all(color: Color(0xff6C62A3).withOpacity(0.1)),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff6C62A3).withOpacity(0.4),
                blurRadius: 3.0, // soften the shadow
                spreadRadius: 0.2, //extend the shadow
                offset: const Offset(
                  0.0, // Move to right 10  horizontally
                  3.0, // Move to bottom 10 Vertically
                ),
              )
            ]),
        child: Stack(
          // alignment: AlignmentDirectional.center,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: SvgPicture.asset(
                    image,
                    height: 26,
                    width: 40,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customText(stock, 22, primaryColor, 'Skia-Regular'),
                  Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: customText('Total : $total', 15, primaryColor, 'Skia-Regular'),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
