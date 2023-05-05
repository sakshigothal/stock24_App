import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../Constants/constant.dart';
import '../../utility.dart';

class MemoService{

  Future<dynamic> createMemo( dealers,List category_id,List sample_data) async {
    var basicAuth = await authorizationHeader();
    Map<String,String> headers = {
      'authorization': basicAuth,
      'X-Access-Token': GetStorage().read('token')
    };
    print(basicAuth);
    try {
      var request = http.MultipartRequest('POST',Uri.parse(Constants.baseUrl+Constants.createSample));
      if(GetStorage().read('role') != 'dealer'){
        for(int i=0;i<dealers.length;i++){
          request.fields['subdealers[$i]']=dealers[i]['id'].toString();
        }
      }else{
        request.fields['subdealers[0]']=GetStorage().read('dealer')['id'].toString();
      }


      for(int i=0;i<category_id.length;i++){
        request.fields['category_id[$i]']=category_id[i];
      }
      for(int i=0;i<sample_data.length;i++){
        request.fields['sample_data[$i][product_id]']=sample_data[i]['id'];
        request.fields['sample_data[$i][size]']=sample_data[i]['size'];
        request.fields['sample_data[$i][qty]']=sample_data[i]['qty'];
      }
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

  Future<dynamic> getMemo(pageNo,limit) async {
    var basicAuth = await authorizationHeader();
    print(basicAuth);
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.getSampleMemo);
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