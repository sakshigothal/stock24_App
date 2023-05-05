
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart' as dio;
import '../../Constants/constant.dart';
import 'package:http/http.dart' as http;

import '../../utility.dart';
class ProductService{
    Future<dynamic> getProduct(pageNo,limit) async {
    var basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.getProducts);
      var response = await http.post(
        url,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-Access-Token': GetStorage().read('token').toString()
        },
        body: {'page_no': pageNo, 'limit': limit},
      );
      print(response.body);
      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }

  Future<dynamic> getCategories() async {
    var basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.getCategories);
      var response = await http.post(
        url,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-Access-Token': GetStorage().read('token').toString()
        },
      );
      print(response.body);
      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }

  Future<dynamic> getSizes() async {
    var basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.getSize);
      var response = await http.post(
        url,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-Access-Token': GetStorage().read('token').toString()
        },
        // body: {'page_no': pageNo, 'limit': limit},
      );
      print(response.body);
      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }

  Future<dynamic> getBody() async {
    var basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.getBody);
      var response = await http.post(
        url,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-Access-Token': GetStorage().read('token').toString()
        },
        // body: {'page_no': pageNo, 'limit': limit},
      );
      print(response.body);
      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }

  Future<dynamic> getFinish() async {
    var basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.getFinish);
      var response = await http.post(
        url,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-Access-Token': GetStorage().read('token').toString()
        },
        // body: {'page_no': pageNo, 'limit': limit},
      );
      print(response.body);
      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }

  Future<dynamic> applyFilter(pageNo,limit,List category_id,List size) async {

    var basicAuth = await authorizationHeader();
    Map<String,String> headers = {
      'authorization': basicAuth,
      'X-Access-Token': GetStorage().read('token')
    };
    print(basicAuth);
    try{
      var request = http.MultipartRequest('POST',Uri.parse(Constants.baseUrl+Constants.getProducts));
      for (var i = 0; i < category_id.length; i++){
        request.fields['category_id[$i]']=category_id[i];
      }
      for (var i = 0; i < category_id.length; i++){
        request.fields['size[$i]']=size[i];
      }
      request.fields['page_no']=pageNo;
      request.fields['limit']=limit;
      request.headers.addAll(headers);
      var response = await request.send();
      var responseData =  http.Response.fromStream(response);
      return responseData;
    }catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }


  // Future<dynamic> addNewProduct(category_id,product_name,size,body,finish,tiles_per_box,sqmtr_per_box,sqft_per_box,price,mrp,List attachment) async {
  //   var basicAuth = await authorizationHeader();
  //   print(basicAuth);
  //   try {
  //     var url = Uri.parse(Constants.baseUrl + Constants.addProduct);
  //     for (var i = 0; i < attachment.length; i++) {
  //       print('object$i');
  //       var response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'authorization': basicAuth,
  //         'X-Access-Token': GetStorage().read('token').toString()
  //       },body: {
  //         'category_id':category_id,
  //         'product_name': product_name,
  //         'size':size,
  //         'body':body,
  //         'finish':finish,
  //         'tiles_per_box':tiles_per_box,
  //         'sqmtr_per_box':sqmtr_per_box,
  //         'sqft_per_box':sqft_per_box,
  //         'price':price,'mrp':mrp,
  //         'batch[0][batch_code]':'BOXP1',
  //         'batch[0][batch_qty]': '100',
  //         'batch[1][batch_code]': 'BOXP2',
  //         'batch[1][batch_qty]': '200',
  //         '${attachment[i]}':await MultipartFile.fromFile('${attachment[i]}')
  //       }
  //     );
  //     print(response.body);
  //     return response;
  //     }
  //   } catch (e) {
  //     print('=======This is exception=========');
  //     print(e);
  //     return ' ';
  //   }
  // }


  Future<dynamic> addNewProduct2(category_id,product_name,size,product_body,finish,tiles_per_box,sqmtr_per_box,sqft_per_box,price,mrp,List attachment,
      List batch) async {
    String basicAuth = await authorizationHeader();
    
    print(basicAuth);
    var dioP = dio.Dio();
    dioP.options.baseUrl = Constants.baseUrl;
    dioP.options.connectTimeout = 5000;
    dioP.options.receiveTimeout = 5000;
    Map<String,String> headers = {
      'authorization': basicAuth,
      'X-Access-Token': GetStorage().read('token')
    };

    try {
      var request= http.MultipartRequest('POST',Uri.parse(Constants.baseUrl+Constants.addProduct));
      request.fields['category_id']=category_id;
      request.fields['product_name']=product_name;
      request.fields['size']=size;
      request.fields['body']=product_body;
      request.fields['finish']=finish;
      request.fields['price']=price;
      request.fields['mrp']=mrp;
      request.fields['tiles_per_box']=tiles_per_box;
      request.fields['sqmtr_per_box']=sqmtr_per_box;
      request.fields['sqft_per_box']=sqft_per_box;
      for (var i = 0; i < batch.length; i++) {
        // batch.add({'${batch[i]['batch_code']}': 'Box$i','${batch[i]['batch_qty']}': qty});
        request.fields['batch[$i][batch_code]']=batch[i]['batch_code'];
        request.fields['batch[$i][batch_qty]']=batch[i]['batch_qty'];
      }
      // request.fields['batch[0][batch_code]']='BOXP1';
      // request.fields['batch[0][batch_qty]']='100';
      // request.fields['batch[1][batch_code]']='BOXP2';
      // request.fields['batch[1][batch_qty]']='200';
      
      for (var i = 0; i < attachment.length; i++) {
        request.files.add(await http.MultipartFile.fromPath('attachment${[i]}', '${attachment[i]}'));
      }

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      print(response.toString());
      return response.stream.bytesToString();
      
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }


  Future<dynamic> addToWishList(product_id) async {
    var basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.addToWishlist);
      var response = await http.post(url,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-Access-Token': GetStorage().read('token').toString()
        },
        body: {'product_id':product_id},
      );
      print(response.body);
      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }


    Future<dynamic> getWishList(pageNo,limit) async {
      var basicAuth = await authorizationHeader();
      print(basicAuth);
      try {
        var url = Uri.parse(Constants.baseUrl + Constants.getWishlist);
        var response = await http.post(
          url,
          headers: <String, String>{
            'authorization': basicAuth,
            'X-Access-Token': GetStorage().read('token').toString()
          },
          body: {'page_no': pageNo, 'limit': limit},
        );
        print(response.body);
        return response;
      } catch (e) {
        print('=======This is exception=========');
        print(e);
        return ' ';
      }
    }
}