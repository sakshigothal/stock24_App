import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/Pages/WelcomeScreen/Controller/signup_controller.dart';
import 'package:stock24/utility.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var bool = false;
  final controller = Get.put(SignupController());
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: primaryColor,
          /*floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: controller.condition.value == false
              ? Padding(
                padding: EdgeInsets.only(
                    bottom: getHeight(context) * 0.06),
                child: InkWell(
                  onTap: () async {

                    await controller.checkSignup(context);
                  },
                  child: Container(
                    height: 55,
                    width: 162,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: whiteColor.withOpacity(0.4),
                            blurRadius: 7.0, // soften the shadow
                            spreadRadius: 0.2, //extend the shadow
                            offset: const Offset(
                              0.0, // Move to right 10  horizontally
                              1.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: customText('Proceed', 22, primaryColor, 'Skia-Regular')),
                  ),
                ),
              )
              : loginButton(),*/
          body: Obx(() {
            return SingleChildScrollView(
              child: Container(
                height: getHeight(context),
                width: getWidth(context),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                  text: 'Stock',
                                  style: TextStyle(
                                    fontSize: 64,
                                    fontFamily: 'Skia-Regular',
                                    color: whiteColor,
                                  )),
                              TextSpan(
                                  text: '24',
                                  style: TextStyle(
                                    fontSize: 64,
                                    fontFamily: 'Papyrus-Regular',
                                    color: whiteColor,
                                  )),
                            ]))),
                    Positioned(
                        top: getHeight(context) * 0.12,
                        child: customText('Next Generation App', 18, whiteColor, 'Skia-Regular')),
                    Positioned(
                        top: getHeight(context) * 0.2,
                        child: SvgPicture.asset('assets/WelcomeScreen/Group 3267.svg')),
                    Positioned(
                      top: getHeight(context) * 0.5,
                      // left: getWidth(context)*0.2,

                      child: Padding(
                          padding: EdgeInsets.only(top: controller.condition.value == false ? 20 : 50),
                          child: controller.condition.value == false
                              ? Column(
                            children: [
                              customText('Welcome !!\n', 25, whiteColor, 'Skia-Regular'),
                              customText('Sign in to get Started.', 21, whiteColor, 'Skia-Regular')
                            ],
                          )
                              : commonText()),
                    ),
                    controller.condition.value == false
                        ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: getHeight(context) * 0.10),
                        child: InkWell(
                          onTap: () async {

                            await controller.checkSignup(context);
                          },
                          child: Container(
                            height: 55,
                            width: 162,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: whiteColor.withOpacity(0.4),
                                    blurRadius: 7.0, // soften the shadow
                                    spreadRadius: 0.2, //extend the shadow
                                    offset: const Offset(
                                      0.0, // Move to right 10  horizontally
                                      1.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ],
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: customText('Proceed', 22, primaryColor, 'Skia-Regular')),
                          ),
                        ),
                      ),
                    )
                        : loginButton(),
                    controller.condition.value == false ? enterNo() : enterOtp()
                  ],
                ),
              ),
            );
          })),
    );
  }

  Widget enterNo() {
    return Positioned(
      top: getHeight(context) * 0.7,
      child: Container(
        height: 61,
        width: getWidth(context) * 0.9,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(5),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: whiteColor,
            )),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: customText('+91', 16, primaryColor, 'Skia-Regular')),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 60, top: 12, bottom: 12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: VerticalDivider(
                    width: 1.0,
                    color: primaryColor.withOpacity(0.1),
                    thickness: 1.5,
                  ),
                )),
            Positioned(
              left: 80.0,
              top: 0.0,
              bottom: 0.0,
              right: 0.0,
              child: Center(
                  child: Form(
                    key: controller.loginFormKey,
                    child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: controller.mobileNo,
                cursorColor: primaryColor,
                onSaved: (value) {
                    setState(() {
                      controller.mobileNo.text = value!;
                    });
                },
                validator: (value) {
                    // return controller.checkMobileNumber(value!);
                },
                minLines: 1,
                inputFormatters: [
                    // LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                    hintText: 'Enter Mobile Number',
                    enabled: true,
                    filled: true,
                    fillColor: whiteColor /*Colors.red*/,
                    hintStyle: TextStyle(
                        fontSize: 16.0,
                        color: primaryColor.withOpacity(0.1),
                        fontFamily: 'Poppins Regular'),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
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
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget enterOtp() {
    return Positioned(
      top: getHeight(context) * 0.66,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 61,
            width: getWidth(context) * 0.9,
            decoration: BoxDecoration(
                color: whiteColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: whiteColor,
                )),
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Form(
                    key: controller.loginFormKey,
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: controller.otp,
                      cursorColor: primaryColor,
                      onSaved: (value) {
                        // signUpController.mobileNo = value!;
                      },
                      validator: (value) {
                        // return signUpController.validateMobileNo(value!);
                      },
                      minLines: 1,
                      inputFormatters: [
                        // LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                        hintText: 'Enter OTP',
                        enabled: true,
                        filled: true,
                        fillColor: whiteColor /*Colors.red*/,
                        hintStyle: TextStyle(
                            fontSize: 16.0,
                            color: const Color(0xff1B285C).withOpacity(0.1),
                            fontFamily: 'Poppins Regular'),
                        contentPadding:const EdgeInsets.symmetric(vertical: 10.0),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: whiteColor, width: 0.1)),
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
                  )),
            ),
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () {
              controller.resendOTP(context);
            },
            child: customText('Resend OTP', 16, checkBoxColor, 'Skia-Regular'),
          )
        ],
      ),
    );
  }

  Widget loginButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: getHeight(context) * 0.13),
        child: InkWell(
          onTap: () async {
            if(controller.loginFormKey.currentState!.validate()){
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.green,));
                  });

              controller.userLogin(context);
            }
            /*showDialog(
                context: context,
                builder: (ctx) {
                  return Center(
                      child: CircularProgressIndicator(color: Colors.green,));
                              });
            controller.checkLogin(context);*/
          },
          child: Container(
            height: 55,
            width: getWidth(context) * 0.4,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: whiteColor.withOpacity(0.4),
                blurRadius: 7.0, // soften the shadow
                spreadRadius: 0.2, //extend the shadow
                offset: const Offset(
                  0.0, // Move to right 10  horizontally
                  1.0, // Move to bottom 10 Vertically
                ),
              )
            ], color: whiteColor, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: customText('Login', 22, primaryColor, 'Skia-Regular'),
            ),
          ),
        ),
      ),
    );
  }

  Widget commonText() {
    return Column(
      children: [
        customText('Enter the OTP sent to your mobile Number', 15, whiteColor, 'Roboto-Regular'),
        Padding(
            padding: const EdgeInsets.only(top: 5),
            child: InkWell(
                onTap: () {
                  controller.condition.value = false;
                },
                child: customText(controller.mobileNo.text, 15, whiteColor, 'Roboto-Regular')))
      ],
    );
  }
}
