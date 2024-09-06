
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pwaohyes/apiservice/ip.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class ServerHelper {
  static String myQPadUrl = "https://api.myqpad.com";
  static String myQPadUrlImage = "https://api.myqpad.com/file/get/";
  static Future<Response> post(String url, Map data) async {
    // Helper.showLog(Helper.userModel.token ?? "");
    Helper.showLog('${apiEnvironment.baseUrl + url} -- $data');
    Helper.showLog('Token: Bearer ${Initializer.userModel.token ?? ""}');
    Helper.showLog(
        'Refresh token: Bearer ${Initializer.userModel.refreshToken ?? ""}');
    // var body = json.encode(data);
    // try {
    return await http
        .post(Uri.parse(apiEnvironment.baseUrl + url),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
              'Authorization': 'Bearer ${Initializer.userModel.token ?? ""}',
              'Refreshtoken':
                  'Bearer ${Initializer.userModel.refreshToken ?? ""}',
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
      Helper.showLog(apiEnvironment.baseUrl + url);
      Helper.showLog('Token: Bearer ${Initializer.userModel.token ?? ""}');
      Helper.showLog(
          'Refresh token: Bearer ${Initializer.userModel.refreshToken ?? ""}');
      var response =
          await http.get(Uri.parse(apiEnvironment.baseUrl + url), headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${Initializer.userModel.token ?? ""}',
        'Refreshtoken': 'Bearer ${Initializer.userModel.refreshToken ?? ""}',
      });

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

  static Future<Response> getMyQPost(
      String url, Map<String, dynamic> data) async {
    Helper.showLog('${myQPadUrl + url} -- $data');
    Helper.showLog('Token: Bearer ${Initializer.userModel.token ?? ""}');
    Helper.showLog(
        'Refresh token: Bearer ${Initializer.userModel.refreshToken ?? ""}');
    return await http
        .post(Uri.parse(myQPadUrl + url),
            headers: {
              // 'Content-Type': 'application/x-www-form-urlencoded',
              // 'Authorization': 'Bearer ${Initializer.userModel.token ?? ""}',
              // 'Refreshtoken':
              //     'Bearer ${Initializer.userModel.refreshToken ?? ""}',
            },
            body: data);
  }

  static getMyQPostSpecial(String url, Map data) async {
    Helper.showLog('${myQPadUrl + url} -- $data');
    Helper.showLog('Token: Bearer ${Initializer.userModel.token ?? ""}');
    Helper.showLog(
        'Refresh token: Bearer ${Initializer.userModel.refreshToken ?? ""}');
    return await http
        .post(Uri.parse(myQPadUrl + url),
            headers: {
              // 'Content-Type': 'application/x-www-form-urlencoded',
              // 'Authorization': 'Bearer ${Initializer.userModel.token ?? ""}',
              // 'Refreshtoken':
              //     'Bearer ${Initializer.userModel.refreshToken ?? ""}',
            },
            body: data)
        .timeout(const Duration(seconds: 20));
  }
}
