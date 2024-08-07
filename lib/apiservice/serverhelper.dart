import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pwaohyes/apiservice/ip.dart';
import 'package:pwaohyes/utils/helper.dart';

class ServerHelper {
  static Future<dynamic> post(String url, Map data) async {
    // Helper.showLog(Helper.userModel.token ?? "");
    Helper.showLog('${apiEnvironment.baseUrl + url} -- $data');
    var body = json.encode(data);
    dynamic response;
    try {
      response = await http
          .post(Uri.parse(apiEnvironment.baseUrl + url),
              headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "Authorization": '',
              },
              body: body)
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        var error = {
          "status": false,
          "msg": "${response.statusCode} - ${response.reasonPhrase}"
        };
        return error;
      }
    } on Exception catch (e) {
      Helper.showLog(e.toString());
    }
  }

  static Future<Response> get(String url) async {
    try {
      var response = await http.get(
        Uri.parse(apiEnvironment.baseUrl + url),
        headers: {
          // "Content-Type": "application/x-www-form-urlencoded",
          "token": '',
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
