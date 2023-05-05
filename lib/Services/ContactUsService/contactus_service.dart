import 'package:http/http.dart' as http;
class ContactUsService{

  Future<dynamic> getContactUS() async {
    try {
      var url = Uri.parse('https://app.edwolf.in/api/settings');
      var response = await http.post(url,
          body: {
            'authtoken' : '1111ABC0000',
            'key' : 'TERMS AND CONDITIONS',
          }
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