
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:stock24/Constants/constant.dart';
import 'package:stock24/utility.dart';

class SubDealerService {
  Future<dynamic> getSubDealer(pageNo,limit) async {
    var basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.getSubDealer);
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

 /* Future<dynamic> addSubDealer(firm, contact_person, area, whatsapp_number,
      pincode, mobile_number, dealer, upload_1, upload_2) async {
    String basicAuth = await authorizationHeader();
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.addSubDealer);
      var response = await http.post(
        url,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-Access-Token': GetStorage().read('token').toString()
        },
        body: {
          'firm': firm,
          'contact_person': contact_person,
          'area': area,
          'whatsapp_number': whatsapp_number,
          'pincode': pincode,
          'mobile_number': mobile_number,
          'dealer[0]': dealer,
          'upload_1': upload_1,
          'upload_2': upload_2
        },
      );
      print(response.body);
      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }*/

  Future<dynamic> addNewSubDealer(File frontSide, File backSide, firm,
      contact_person, area, whatsapp_number, pincode, mobile_number, dealers) async {
    String basicAuth = await authorizationHeader();
    Map<String,String> headers = {
      'authorization': basicAuth,
      'X-Access-Token': GetStorage().read('token')
    };

    try {
      print('add new subdelaer----->> ${GetStorage().read('dealer')}');
      var request = http.MultipartRequest('POST',Uri.parse(Constants.baseUrl+Constants.addSubDealer));
      request.fields['firm']=firm;
      request.fields['contact_person']=contact_person;
      request.fields['area']=area;
      request.fields['whatsapp_number']=whatsapp_number;
      request.fields['pincode']=pincode;
      request.fields['mobile_number']=mobile_number;
      request.files.add(await http.MultipartFile.fromPath('upload_1', frontSide.path));
      request.files.add(await http.MultipartFile.fromPath('upload_2', backSide.path));

        if(GetStorage().read('role') !='dealer'){
          for(int i=0;i<dealers.length;i++){
            request.fields['dealer[$i]']=dealers[i]['id'];
          }

        }else{
          request.fields['dealer[0]']=GetStorage().read('dealer')['id'].toString();

      }

      // var formData = FormData.fromMap({
      //   'firm': firm,
      //   'contact_person': contact_person,
      //   'area': area,
      //   'whatsapp_number': whatsapp_number,
      //   'pincode': pincode,
      //   'mobile_number': mobile_number,
      //   // 'dealer[0]': '55',
      //   'upload_1': await MultipartFile.fromFile(frontSide.path),
      //   'upload_2': await MultipartFile.fromFile(backSide.path)
      // });
      // var response = await dio.post(Constants.baseUrl + Constants.addSubDealer,
      //     data: formData);
      // print(response.data.toString());
      // print(response.runtimeType);
      // return response;
      request.headers.addAll(headers);
      var response = await request.send();
      var responseData =  http.Response.fromStream(response);
      return responseData;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }


  Future<dynamic> updateSubDealer(id,firm,contact_person,area,mobile_number,
                                  whatsapp_number,pincode, frontSide,  backSide) async {
    var basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.updateSubDealer);
      var response = await http.post(
        url,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-Access-Token': GetStorage().read('token').toString()
        },
        body: {
          'id': id,
          'firm': firm,
          'contact_person':contact_person,
          'area':area,
          'mobile_number':mobile_number,
          'whatsapp_number':whatsapp_number,
          'pincode':pincode,
          'dealer[0]':'55',
          'upload_1': frontSide,
          'upload_2': backSide},
      );
      print(response.body);
      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }

  Future<dynamic> deleteUser(id) async {
    String basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.deleteUser);
      var response = await http.post(
        url,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-Access-Token': GetStorage().read('token').toString()
        },
        body: {'id': id},
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
