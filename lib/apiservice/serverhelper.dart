import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pwaohyes/apiservice/ip.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class ServerHelper {
  static Future<Response> post(String url, Map data) async {
    // Helper.showLog(Helper.userModel.token ?? "");
    Helper.showLog('${apiEnvironment.baseUrl + url} -- $data');
    // var body = json.encode(data);
    // try {
    return await http
        .post(Uri.parse(apiEnvironment.baseUrl + url),
            headers: {
              // 'Accept': 'application/json',
              'Content-Type': 'application/x-www-form-urlencoded',
              'Authorization': 'Bearer ${Initializer.userModel.token!}',
            },
            body: data)
        .timeout(const Duration(seconds: 20));
    // if (response.statusCode == 200) {
    //   return jsonDecode(response.body);
    // } else {
    //   var error = {
    //     "status": false,
    //     "msg": "${response.statusCode} - ${response.reasonPhrase}"
    //   };
    //   return error;
    // }
    // } on Exception catch (e) {
    //   Helper.showLog(e.toString());
    // }
  }

  static Future<Response> get(String url) async {
    try {
      var response = await http.get(
        Uri.parse(apiEnvironment.baseUrl + url),
        headers: {
          // 'Accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer ${Initializer.userModel.token!}',
        },
      );
      Helper.showLog(apiEnvironment.baseUrl + url);
      return response;
      // if (response.statusCode == 200) {
      //   return jsonDecode(response.body);
      // } else {
      //   // var error = {
      //   //   "status": false,
      //   //   "msg": "${response.statusCode} - ${response.reasonPhrase}"
      //   // };
      //   return jsonDecode(response.body);
      // }
    } on Exception catch (e) {
      // Helper.showToast(msg: e.toString());
      Helper.showLog(e.toString());
      throw Exception();
    }
  }
}
