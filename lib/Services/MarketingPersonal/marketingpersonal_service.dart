
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:stock24/Constants/constant.dart';
import 'package:stock24/utility.dart';

class MarketingPersonalService {
  // int page_no = 1;
  // final limit = 10;
  Future<dynamic> getMarketingPersonals(pageNo,limit) async {
    String basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.getMarketingPerson);
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

  Future<dynamic> addMarketingPersonal(
      name, mobileNo, whatsAppNo, designation, area) async {
    String basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.addMarketingPerson);
      var response = await http.post(
        url,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-Access-Token': GetStorage().read('token').toString()
        },
        body: {
          'name': name,
          'mobile_number': mobileNo,
          'designation': designation,
          'area': area,
          'whatsapp_number': whatsAppNo
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

  Future<dynamic> updateMarketingPersonal(
      uId, name, mobileNo, whatsAppNo, designation, area) async {
    String basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.updateMarketingPerson);
      var response = await http.post(
        url,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-Access-Token': GetStorage().read('token').toString()
        },
        body: {
          'id': uId,
          'name': name,
          'mobile_number': mobileNo,
          'whatsapp_number': whatsAppNo,
          'designation': designation,
          'area': area,
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

  Future<dynamic> getDashboardData() async {
    String basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.dashboard);
      var response = await http.post(
        url,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-Access-Token': GetStorage().read('token').toString()
        },
        body: {},
      );
      print(GetStorage().read('token').toString());
      print(response.body);
      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }

  Future<dynamic> getArea() async {
    String basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.getMasterData);
      var response = await http.post(
        url,
        headers: <String, String>{
          'authorization': basicAuth,
          'X-Access-Token': GetStorage().read('token').toString()
        },
        // body: {},
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
