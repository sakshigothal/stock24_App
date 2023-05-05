
import 'package:http/http.dart' as http;
import 'package:stock24/Constants/constant.dart';
import 'package:stock24/utility.dart';

class SignUpServices {
  Future<dynamic> preLogin(mobleNo) async {
    String basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.prelogin);
      var response = await http.post(
        url,
        headers: <String, String>{'authorization': basicAuth},
        body: {
          'mobile_number': mobleNo,
        },
      );
      print(response.body);
      // Get.rawSnackbar(
      //     title: 'Register Successfully!!!', backgroundColor: Colors.green);

      return response;
    } catch (e) {
      print('=======This is exception=========');
      print(e);
      return ' ';
    }
  }

  Future login(otp, mobileNO) async {
    String basicAuth = await authorizationHeader();
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.login);
      var response = await http.post(
        url,
        headers: <String, String>{'authorization': basicAuth},
        body: {
          'login_type': 'otp',
          'otp_code': otp,
          'mobile_number': mobileNO,
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
}
