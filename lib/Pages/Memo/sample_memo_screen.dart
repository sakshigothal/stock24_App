import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:stock24/Colors/colors.dart';
import 'package:stock24/Pages/Memo/controller/memo_controller.dart';
import 'package:stock24/Pages/Memo/create_sample_memo_screen.dart';
import 'package:stock24/utility.dart';

class SampleMemoScreen extends StatefulWidget {
  const SampleMemoScreen({Key? key}) : super(key: key);

  @override
  State<SampleMemoScreen> createState() => _SampleMemoScreenState();
}

class _SampleMemoScreenState extends State<SampleMemoScreen> {
  final memoController=Get.put(MemoController());
  @override
  void initState() {
    super.initState();
    memoController.loadMemo(context);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: customAppBar(context, 'Sample Memo'),
      body: Obx((){
        return memoController.isMemoLoading.value ? SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() =>  customText(
                          'Total  : ${memoController.totalMemo}', 18, primaryColor, 'Roboto-Regular'),),
                      InkWell(
                          onTap: () async{
                            Get.to(const CreateSampleMemoScreen());
                            /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => CreateSampleMemoScreen()));*/
                          },
                          child: customText(
                              'Create Memo', 16, checkBoxColor, 'Roboto-Regular'))
                    ],
                  ),
                ),
                Container(height: getHeight(context)*0.78,child: subDealersData())
              ],
            ),
          ),
        ) :const Center(child: CircularProgressIndicator(),);
      })
    ));
  }


  Widget subDealersData() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: LazyLoadScrollView(
          isLoading: memoController.isLoadingDataM.value,
          onEndOfPage: () async {
             memoController.loadMemo(context);
          },
          child: Scrollbar(
            child: ListView(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: memoController.memoList.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                            width: getWidth(context),
                            height: 163,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
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
                            child: Stack(
                              children: [
                                Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                        padding:const EdgeInsets.only(top: 19, left: 20),
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              customText(
                                                  memoController.memoList[index].companyName, 20, primaryColor, 'Roboto-Medium'),
                                              Padding(
                                                  padding:const EdgeInsets.only(right: 10),
                                                  child: customText(memoController.memoList[index].createdAt, 14,
                                                      primaryColor, 'Roboto-Regular'))
                                            ]))),
                                Padding(
                                  padding: const EdgeInsets.only(top: 50, left: 20),
                                  child: Row(
                                    children: [
                                      customText('Selected Products', 16, primaryColor,
                                          'Roboto-Regular'),
                                      Padding(
                                          padding:const EdgeInsets.only(left: 9, right: 13),
                                          child: customText(
                                              ':', 16, primaryColor, 'Roboto-Regular')),
                                      customText(memoController.memoList[index].sampleData!.length.toString(), 16, primaryColor, 'Roboto-Regular')
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 83, left: 20),
                                  child: Row(
                                    children: [
                                      customText(
                                          'Sub-dealers', 16, primaryColor, 'Roboto-Regular'),
                                      Padding(
                                          padding: const EdgeInsets.only(left: 9, right: 13),
                                          child: customText(
                                              ':', 16, primaryColor, 'Roboto-Regular')),
                                      customText('8', 16, primaryColor, 'Roboto-Regular')
                                    ],
                                  ),
                                ),
                                const Align(
                                    alignment: AlignmentDirectional.bottomEnd,
                                    child: Padding(
                                      padding:
                                       EdgeInsets.only(bottom: 35, left: 20, right: 20),
                                      child: Divider(),
                                    )),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: customText(
                                              'Edit', 16, checkBoxColor, 'Roboto-Regular')),
                                      TextButton(
                                          onPressed: () {},
                                          child: customText(
                                              'Delete', 16, checkBoxColor, 'Roboto-Regular')),
                                    ],
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 55, right: 20),
                                      child:
                                      customText('Pcs', 14, primaryColor, 'Roboto-Regular'),
                                    )),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 81, right: 20),
                                      child: customText(memoController.memoList[index].totalPcs.toString(), 26, primaryColor, 'Roboto-Regular'),
                                    ))
                              ],
                            )),
                      );
                    }),
                memoController.totalMemo.value== memoController.memoList.length ? const SizedBox() :
                 memoController.isLoadingDataM.value
                    ? Container(
                    height: getHeight(context) * 0.05,
                    child:const Center(child: CircularProgressIndicator()))
                    : const SizedBox()
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    memoController.memoList.clear();
    memoController.page_noM.value=1;
  }
}
