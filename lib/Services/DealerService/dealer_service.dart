import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:stock24/Constants/constant.dart';
import 'package:stock24/utility.dart';

class DealerService {
  // final dealerController = Get.isRegistered<DealerController>()
  //     ? Get.find<DealerController>()
  //     : Get.put(DealerController());
  // final controller = Get.find<DealerController>();
  Future<dynamic> getDealer(page_no, limit) async {
    String basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.getDealer);
      var response = await http.post(
        url,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-Access-Token': GetStorage().read('token').toString()
        },
        body: {'page_no': page_no, 'limit': limit},
      );
      print(response.body);
      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }

  Future<dynamic> addNewDealer(firmname,contact_person,mobile_number,whatsApp_number,emailId,marketingPerson,File  file1,
        File file2,GST_number,PAN_number,billing_Address,pinCode,country,
        state, city,bank_name,branch_name,account_type,account_number,IFSC_code
      ) async {
    String basicAuth = await authorizationHeader();
    print(basicAuth);
    var dioP = dio.Dio();
    dioP.options.baseUrl = Constants.baseUrl;
    dioP.options.connectTimeout = 5000;
    dioP.options.receiveTimeout = 5000;
    dioP.options.headers = {
      'authorization': basicAuth,
      'X-Access-Token': GetStorage().read('token')
    };
    try {
      var body = dio.FormData.fromMap({
        'firm': firmname,
        'contact_person': contact_person,
        'whatsapp_number': whatsApp_number,
        'marketing_person': marketingPerson,
        // 'designation':'Test Designation',
        // 'area':'Western',
        'gst_no': GST_number,
        'pan_no': PAN_number,
        'address': billing_Address,
        'pincode': pinCode,
        'country': country,
        'state': state,
        'city': city,
        'branch':'Virar East',
        'bank_name': bank_name,
        'account_type': account_type,
        'account_no': account_number,
        'ifsc_code': IFSC_code,
        'email': emailId,
        'mobile_number': mobile_number,
        'upload_1': await dio.MultipartFile.fromFile(file1.path.toString()),
        'upload_2': await dio.MultipartFile.fromFile(file2.path.toString()),
      }
      );
      var response = await dioP.post(Constants.baseUrl + Constants.addDealer,
          data: body);
      print(response.data.toString());
      print(response.runtimeType);
      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }

  Future<dynamic> getCity(state_id) async {
    String basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.getCities);
      var response = await http.post(
        url,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-Access-Token': GetStorage().read('token').toString()
        },
        body: {'state_id': state_id},
      );
      print(response.body);
      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }

  Future<dynamic> getState(country_id) async {
    String basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.getStates);
      var response = await http.post(url, headers: <String, String>{
        'authorization': basicAuth,
        'X-Access-Token': GetStorage().read('token').toString()
      }, body: {
        'country_id': country_id
      });
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


  Future<dynamic> updateDealer(id,firm,contact_person,mobile_number,whatsapp_number,emailID,marketing_person,gst_no,pan_no,address,pincode,bank_name,
  branch, account_type,account_no,ifsc_code,frontSide,  backSide,country,state,city) async {
    var basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.updateDealer);
      var response = await http.post(
        url,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-Access-Token': GetStorage().read('token').toString()
        },
        body: {'id': id, 'firm': firm,'contact_person':contact_person,'designation':'Test Designation',
        'area':'Western Area','mobile_number':mobile_number,'whatsapp_number':whatsapp_number,'email':emailID,
        'marketing_person':marketing_person,'gst_no':gst_no,'pan_no':pan_no,'address':address,
        'pincode':pincode,'bank_name':bank_name,'branch':branch,'account_type':account_type,
        'account_no':account_no,'ifsc_code':ifsc_code,'upload_1': frontSide,'upload_2': backSide,
        'country':country,'state':state,'city':city},
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
