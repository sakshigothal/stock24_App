import 'dart:convert';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:url_launcher/url_launcher.dart';

getHeight(context) {
  return MediaQuery.of(context).size.height;
}

getWidth(context) {
  return MediaQuery.of(context).size.width;
}

customAppBar(context, title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(70),
    child: Container(
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Color(0xff6C62A3).withOpacity(0.4),
            blurRadius: 7.0, // soften the shadow
            spreadRadius: 0.2, //extend the shadow
            offset: Offset(
              0.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () async {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset('assets/Common/backArrow.svg'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: getWidth(context) * 0.65,
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: const TextStyle(
                  color: primaryColor,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 22.0,
                  fontFamily: 'Roboto-Regular',
                  height: 1.0,
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

showLoader(context){
  return showGeneralDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.5),
    pageBuilder: (_, __, ___) {
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(// Dialog background
            width: 120,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.transparent,/*whiteColor.withOpacity(0.5),*/
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
            ),// Dialog height
            child: LoadingAnimationWidget.flickr(
              leftDotColor: const Color(0xFF0063DC),
              rightDotColor: const Color(0xFFFF0084),
              size: 50.0,),
          ),
        ),
      );
    },
  );
}

showDottedDash() {
  return const DottedLine(
    dashColor: Color(0xff707070),
    lineThickness: 1.3,
    dashGapLength: 2,
    dashGapRadius: 1.0,
    dashRadius: 1.5,
  );
}

customText(text, double fontSize, Color color, fontFamily) {
  return Text(text,
      style:
          TextStyle(fontSize: fontSize, color: color, fontFamily: fontFamily));
}

loader() {
  return CircularProgressIndicator();
}

showLoading(context) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Container(height: getHeight(context),width: getWidth(context),color: Colors.transparent,
            child: Center(
                child:
                    LoadingAnimationWidget.inkDrop(color: primaryColor, size: 50)),
          ),
        );
      });
}

userCall(mobile_number) async {
  Uri url = Uri.parse('tel:+91${mobile_number}');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

authorizationHeader() async{
  String username = 'admin';
  String password = 'mypcot';
  String basicAuth =
      'Basic ' + base64Encode(utf8.encode('$username:$password'));
  return basicAuth;
}
