import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/Pages/Memo/controller/memo_controller.dart';
import 'package:stock24/utility.dart';
import '../Dealers/Controller/dealer_controller.dart';
import 'memo_droptlist.dart';

class MultiSelectDealerScreen extends StatefulWidget {
  const MultiSelectDealerScreen({Key? key}) : super(key: key);

  @override
  State<MultiSelectDealerScreen> createState() =>
      _MultiSelectDealerScreenState();
}

class _MultiSelectDealerScreenState extends State<MultiSelectDealerScreen> {
  final dealerController=Get.put(DealerController());
  final memoController=Get.find<MemoController>();
  @override
  void initState() {
  super.initState();
  memoController.selecredMemoList.forEach((element) {
    memoController.qtyController.add( TextEditingController());
  });
  print('selected memo list list ${memoController.selecredMemoList.length}');
  print('quantity controller list ${memoController.qtyController.length}');
  }

  Future<bool> onWillPop() async {
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: SafeArea(
          child: Scaffold(
        appBar: customAppBar(context, 'Create Sample Memo'),
        floatingActionButton: InkWell(
          onTap: () async{
            for(int i=0;i < memoController.qtyController.length; i++){
              print('before adding data in list ${memoController.selecredMemoList.toString()}');
                memoController.selecredMemoList[i].addAll({'qty': memoController.qtyController[i].value.text});

                memoController.totalPcs=memoController.totalPcs+ int.parse(memoController.qtyController[i].value.text);
                print('after adding data in list ${memoController.selecredMemoList.toString()}');
            }
            print('selected memo list ${memoController.selecredMemoList.toString()}');
            print('category id list ${memoController.categoryIdList.toString()}');
            print('selected subdealer list ${dealerController.selectedDealers.toString()}');
            memoController.addNewMemo(context,dealerController.selectedDealers,memoController.categoryIdList,memoController.selecredMemoList,);


             // Navigator.push(context,
            //     MaterialPageRoute(builder: (ctx) => const SampleMemoViewScreen()));
          },
          child: Container(
            height: 55,
            width: getWidth(context) * 0.40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: primaryColor),
            child: Center(
              child: customText('Create', 22, whiteColor, 'Skia-Regular')
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: GetStorage().read('role')== 'dealer' ?
                      Container(
                        height: 60,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                            border: Border.all(width:0.5,color: primaryColor)),
                        child: Padding(padding:const  EdgeInsets.only(left: 15,right: 15),
                          child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText('${GetStorage().read('dealer')['name']}', 18, primaryColor, 'Roboto-Regular') ?? customText('Select Dealer(Multiselect)',18,primaryColor.withOpacity(0.1) ,'Roboto-Regular'),
                              SvgPicture.asset('assets/Common/downArrow.svg')
                            ],
                          ),),
                      ) :
                      InkWell(
                        onTap: ()async{

                          Get.to(const MemoDropList());
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          border: Border.all(width:0.5,color: primaryColor)),
                          child: Padding(padding:const  EdgeInsets.only(left: 15,right: 15),
                          child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             customText('${GetStorage().read('dealer')['name']}', 18, primaryColor, 'Roboto-Regular') ?? customText('Select Dealer(Multiselect)',18,primaryColor.withOpacity(0.1) ,'Roboto-Regular'),
                              SvgPicture.asset('assets/Common/downArrow.svg')
                            ],
                          ),),
                        ),
                      )
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: memoDetails(),
                    ),
                  ],
                ),
                // Align(alignment: Alignment.bottomCenter,child: ElevatedButton(onPressed: (){}, child: Text('ncbjh')))
              ],
            ),
          ),
        ),
      )),
    );
  }



  Widget memoDetails() {
    return Obx((){
      return ListView.separated(
        shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (ctx,index){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(width: getWidth(context)*0.60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: customText(memoController.selecredMemoList[index]['productName'], 16, primaryColor, 'Roboto-Regular')),
                      customText(memoController.selecredMemoList[index]['size'], 16, primaryColor, 'Roboto-Regular'),
                    ],
                  ),
                ),
                Container(
                  height: 35,
                  width: 93,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: memoController.qtyController[index],
                    decoration: InputDecoration(
                      hintText: 'Qty',
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                      helperStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto-Regular',
                          color: primaryColor.withOpacity(0.1)),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: whiteColor, width: 0.8)),
                      enabledBorder:const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: primaryColor, width: 0.8),
                      ),
                      focusedBorder:const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: primaryColor, width: 0.8),
                      ),
                      errorBorder:const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: primaryColor, width: 0.8),
                      ),
                      focusedErrorBorder:const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: primaryColor, width: 0.8),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
          separatorBuilder: (ctx,s){
            return Padding(
                padding:const EdgeInsets.only(top: 11, bottom: 11),
                child: showDottedDash());
          },
          itemCount: memoController.selecredMemoList.length);
    });
  }

  @override
  void dispose() {
    super.dispose();
    memoController.totalPcs.value=0;
    memoController.qtyController.clear();
    // memoController.selecredMemoList.clear();
  }
}
