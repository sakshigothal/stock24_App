import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stock24/Pages/Product/Controller/product_controller.dart';

import '../../../Colors/colors.dart';
import '../../../utility.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final productController = Get.put(ProductController());
  String? selectedSize;
  String? selectedCategory;
  String? selectedBody;
  String? selectedFinish;
  List<Widget> widgetList = [];
  List selectedFiles=[];
  String imageName = '';
  var pickedImage1 = '';
  XFile? imagePath;
  final ImagePicker picker = ImagePicker();
  PageController controller = PageController();
  @override
  void initState() {
    super.initState();
    productController.getProductSizes(context);
    productController.getFinish(context);
    productController.getProductBody(context);
    productController.getProductCategories(context);
   setState(() {
      widgetList.add(InkWell(
                  onTap: () async {
                    imagePicker();
                  },
                  child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor),
                          color: whiteColor),
                      child:
                          Center(child: Icon(Icons.add, color: primaryColor))),
                ));
   });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: customAppBar(context, 'Add Product'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: Container(
                  height: getHeight(context) * 0.22,
                  width: getWidth(context) * 0.45,
                  child: widgetList.length > 1 ?   PageView.builder(controller: controller,
                    itemCount: widgetList.length,itemBuilder: (ctx,index){
                    return widgetList[index + 1];
                  }) :   Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_tDSibGYFBHV4Ug-yJkzt0R3EtODGJbt76tbYHTxJYNpBqa_SoI1JI-YarWcY4QZrjtU&usqp=CAU')
                ),
              ),
              widgetList.length == 1 ? SizedBox() :
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: SmoothPageIndicator(
                  controller: controller,
                  count: widgetList.length -1,
                  effect: const SlideEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: primaryColor,
                      paintStyle: PaintingStyle.stroke),
                ),
              ),
              showDottedDash(),
              Padding(
                padding: const EdgeInsets.only(top: 15,bottom: 15),
                child: Container(height: 125,width: getWidth(context),
                  child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: widgetList.length,itemBuilder: (ctx,index){
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Stack(clipBehavior: Clip.none,children: [Container(height: 110,width: 110,child: widgetList[index]),
                      index == 0 ? SizedBox() :  Positioned(right: 0,
                        child: InkWell(onTap: ()async{
                          setState(() {
                            widgetList.removeAt(index);
                          });
                        }, child: Icon(Icons.close,color: Colors.red,))
                      )]),
                    );
                  }),
                ),
              ),
              showDottedDash(),
              const SizedBox(height: 20),
              textField('Product Name *',productController.productName.value),
              Obx(() {
                return Container(
                  height: 60,
                  width: getWidth(context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: primaryColor, width: 0.5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        style: const TextStyle(color: primaryColor),
                        value: selectedCategory,
                        hint: customText(
                            'Category *',
                            18,
                            Color(0xff312D2D).withOpacity(0.2),
                            'Roboto-Regular'),
                        icon: SvgPicture.asset('assets/Common/downArrow.svg'),
                        items: productController.categoryList.map((item) {
                          return DropdownMenuItem<String>(
                              value: item.id.toString(),
                              child: customText(item.categoryName, 15,
                                  primaryColor, 'Roboto-Regular'));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        },
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return Container(
                      height: 60,
                      width: getWidth(context) * 0.43,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor, width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            style: const TextStyle(color: primaryColor),
                            value: selectedSize,
                            hint: customText('Size *', 18, Color(0xff312D2D).withOpacity(0.2), 'Roboto-Regular'),
                            icon:
                                SvgPicture.asset('assets/Common/downArrow.svg'),
                            items: productController.sizeList.map((item) {
                              return DropdownMenuItem<String>(
                                  value: item.size,
                                  child: customText(item.size, 15, primaryColor, 'Roboto-Regular'));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedSize = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return Container(
                      height: 60,
                      width: getWidth(context) * 0.43,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor, width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            style: const TextStyle(color: primaryColor),
                            value: selectedBody,
                            hint: customText('Body *', 18, Color(0xff312D2D).withOpacity(0.2), 'Roboto-Regular'),
                            icon:
                                SvgPicture.asset('assets/Common/downArrow.svg'),
                            items: productController.bodyList.map((item) {
                              return DropdownMenuItem<String>(
                                  value: item.body,
                                  child: customText(item.body, 15, primaryColor, 'Roboto-Regular'));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedBody = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return Container(
                      height: 60,
                      width: getWidth(context) * 0.43,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: primaryColor, width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            style: const TextStyle(color: primaryColor),
                            value: selectedFinish,
                            hint: customText('Finish *', 18, Color(0xff312D2D).withOpacity(0.2), 'Roboto-Regular'),
                            icon:
                                SvgPicture.asset('assets/Common/downArrow.svg'),
                            items: productController.finishList.map((item) {
                              return DropdownMenuItem<String>(
                                  value: item.finish,
                                  child: customText(item.finish, 15, primaryColor, 'Roboto-Regular'));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedFinish = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                  Container(
                    height: 60,
                    width: getWidth(context) * 0.43,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primaryColor, width: 0.5)),
                    child: TextFormField(
                      controller: productController.tilesPerBox.value,
                      decoration: InputDecoration(
                        hintText: 'Tiles per box *',
                        enabled: true,
                        // filled: true,
                        hintStyle: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff312D2D).withOpacity(0.2)),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: primaryColor, width: 0.5)),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: primaryColor, width: 0.5),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: primaryColor, width: 0.5),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: primaryColor, width: 0.5),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: primaryColor, width: 0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 60,
                    width: getWidth(context) * 0.43,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primaryColor, width: 0.5)),
                    child: TextFormField(
                      controller: productController.sqmrtPerBox.value,
                      decoration: InputDecoration(
                        hintText: 'Sqmrt per box *',
                        enabled: true,
                        // filled: true,
                        hintStyle: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff312D2D).withOpacity(0.2)),
                        // contentPadding:
                        //     EdgeInsets.symmetric(vertical: 10.0),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: primaryColor, width: 0.5)),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: primaryColor, width: 0.5),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: primaryColor, width: 0.5),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: primaryColor, width: 0.5),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: primaryColor, width: 0.5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: getWidth(context) * 0.43,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primaryColor, width: 0.5)),
                    child: TextFormField(
                      controller: productController.sqftPerBox.value,
                      decoration: InputDecoration(
                        hintText: 'Sqft per box *',
                        enabled: true,
                        // filled: true,
                        hintStyle: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff312D2D).withOpacity(0.2)),
                        // contentPadding:
                        //     EdgeInsets.symmetric(vertical: 10.0),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: primaryColor, width: 0.5)),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: primaryColor, width: 0.5),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: primaryColor, width: 0.5),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: primaryColor, width: 0.5),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: primaryColor, width: 0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 20),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  customText('Quantity *', 18, primaryColor, 'Roboto-Regular'),
                  InkWell(onTap: ()async{
                   setState(() {
                      if(productController.qty.value.text.isNotEmpty && productController.batchCount.value < 3){
                        productController.batch.add({'batch_code':'Box${productController.batchCount.value}','batch_qty':productController.qty.value.text});
                      productController.qty.value.clear();
                      productController.batchCount.value++;
                      print(productController.batchCount.value);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please enter valid Details!!!!!'),
                            backgroundColor: Colors.red,
                             ));
                      }
                      
                      // if(productController.batchCount.value < 3){
                      //   productController.batchCount.value++;
                      // }
                   });
                  },child:customText('Add Batch', 16, checkBoxColor, 'Roboto-Regular'))
                  
                ],),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 60,
                    width: getWidth(context) * 0.43,
                    decoration: BoxDecoration(
                      color: Color(0xffE4E4E4),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primaryColor, width: 0.5)),
                    child: Center(child: Obx((){
                      return customText('B${productController.batchCount.value}', 17, primaryColor, 'Roboto-Regular');
                    }))
                  ),
                  Container(
                    height: 60,
                    width: getWidth(context) * 0.43,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: primaryColor, width: 0.5)),
                    child: TextFormField(
                      controller: productController.qty.value,
                      decoration: InputDecoration(
                        hintText: 'Box Qty *',
                        enabled: true,
                        // filled: true,
                        hintStyle: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff312D2D).withOpacity(0.2)),
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(color: primaryColor, width: 0.5)),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: primaryColor, width: 0.5),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: primaryColor, width: 0.5),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: primaryColor, width: 0.5),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: primaryColor, width: 0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              textField('Price *',productController.price.value),
              textField('MRP *',productController.mrp.value),
              const SizedBox(height: 30),
              InkWell(onTap: ()async{
                print(productController.batch.toString());
                if(selectedFiles.isNotEmpty &&   productController.productName.value.text.isNotEmpty &&
                    selectedCategory!.isNotEmpty &&
                    selectedSize!.isNotEmpty && selectedBody!.isNotEmpty && selectedFinish!.isNotEmpty
                && productController.tilesPerBox.value.text.isNotEmpty && productController.sqmrtPerBox.value.text.isNotEmpty
                && productController.sqftPerBox.value.text.isNotEmpty && productController.batch.isNotEmpty
                && productController.price.value.text.isNotEmpty && productController.mrp.value.text.isNotEmpty){

                      // productController.batch.add({'batch_code':'Box${productController.batchCount.value}','batch_qty':productController.qty.value.text});
                    productController.addNewProduct(context, selectedCategory, selectedSize.toString(), selectedBody, selectedFinish, selectedFiles);
                    
                    
                }
                else{
                  print(productController.batch.toString());
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please enter valid Details!!!!!'),
        backgroundColor: Colors.red,
      ));
                }
                
              },
                child: Container(decoration: BoxDecoration(color: primaryColor,
                borderRadius: BorderRadius.circular(10)),
                    child: Padding(padding:const EdgeInsets.only(top: 12,bottom: 12,left: 20,right: 20),
                        child: customText('Add Product', 22, whiteColor, 'Skia-Regular'))),
              ),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    ));
  }

  Widget textField(hintText,TextEditingController con) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: con,
        decoration: InputDecoration(
          hintText: hintText,
          enabled: true,
          hintStyle: TextStyle(
              fontSize: 16.0, color: Color(0xff312D2D).withOpacity(0.2)),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: primaryColor, width: 0.5)),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: primaryColor, width: 0.5),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: primaryColor, width: 0.5),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: primaryColor, width: 0.5),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: primaryColor, width: 0.5),
          ),
        ),
      ),
    );
  }

  imagePicker() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image;
        imageName = image.name.toString();
        pickedImage1 = image.path;
          widgetList.add(Container(child: Image.file(File(pickedImage1.toString()),fit: BoxFit.fill),));
          selectedFiles.add(pickedImage1.toString());
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    selectedBody='';
    selectedCategory='';
    selectedFiles.clear();
    selectedFinish='';
    selectedSize='';
    productController.productName.value.clear();
    productController.tilesPerBox.value.clear();
    productController.sqmrtPerBox.value.clear();
    productController.sqftPerBox.value.clear();
    productController.price.value.clear();
    productController.mrp.value.clear();
    productController.batch.clear();
    productController.batchCount.value=1;
  }
}
