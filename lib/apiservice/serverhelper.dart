// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:pwaohyes/apiservice/ip.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/preferences.dart';
import 'package:pwaohyes/utils/routes.dart';

class ServerHelper {
  static String myQPadUrl = "https://api.myqpad.com";
  static String myQPadUrlImage = "https://api.myqpad.com/file/get/";

  Future<Response> refreshToken() async {
    Helper.showLog("----------> CALLING REFRESH TOKEN <----------");
    Response response = await http.post(
        Uri.parse('${apiEnvironment.baseUrl}refresh'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Initializer.userModel.token ?? ""}',
        },
        body: jsonEncode(
            {'refreshToken': Initializer.userModel.refreshToken ?? ""}));

    if (response.statusCode == 200) {
      Helper.showLog(response.body);
      Helper.showLog("----------> REFRESH TOKEN SUCCESS <----------");
      var data = jsonDecode(response.body);
      Helper.showLog(data);
      await Preferences.setToken(data['data']['access_token']);
      Initializer.userModel.token = data['data']['access_token'];
    } else {
      BuildContext context = Helper.key!.currentContext!;
      context.read<AuthBloc>().add(DoLogout());
      Helper.pushReplacementNamed(allservices);
      Helper.showLog("----------> CALLING REFRESH TOKEN ERROR <----------");
    }
    return response;
  }

  static Future<Response> post(String url, Map data) async {
    Helper.showLog('${apiEnvironment.baseUrl + url} -- $data');
    Helper.showLog('Token: Bearer ${Initializer.userModel.token ?? ""}');
    Helper.showLog(
        'Refresh token: Bearer ${Initializer.userModel.refreshToken ?? ""}');

    Response response = await http
        .post(Uri.parse(apiEnvironment.baseUrl + url),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
              'Authorization': 'Bearer ${Initializer.userModel.token ?? ""}',
              'Refreshtoken':
                  'Bearer ${Initializer.userModel.refreshToken ?? ""}',
            },
            body: data)
        .timeout(const Duration(seconds: 20));
    Helper.showLog(response.body);
    if (response.statusCode == 401) {
      Response refreshTokenResponse = await ServerHelper().refreshToken();
      if (refreshTokenResponse.statusCode == 200) {
        return await http
            .post(
              Uri.parse(apiEnvironment.baseUrl + url),
              headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'Authorization': 'Bearer ${Initializer.userModel.token ?? ""}',
                'Refreshtoken':
                    'Bearer ${Initializer.userModel.refreshToken ?? ""}',
              },
              body: data,
            )
            .timeout(const Duration(seconds: 20));
      } else {
        return refreshTokenResponse;
      }
    } else {
      return response;
    }
  }

  static Future<Response> get(String url) async {
    try {
      Helper.showLog(apiEnvironment.baseUrl + url);
      Helper.showLog('Token: Bearer ${Initializer.userModel.token ?? ""}');
      Helper.showLog(
          'Refresh token: Bearer ${Initializer.userModel.refreshToken ?? ""}');
      Response getResponse =
          await http.get(Uri.parse(apiEnvironment.baseUrl + url), headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${Initializer.userModel.token ?? ""}',
        'Refreshtoken': 'Bearer ${Initializer.userModel.refreshToken ?? ""}',
      });
      if (getResponse.statusCode == 401) {
        Helper.showLog("----------> NOT AUTHENTICATED <----------");
        Response refreshTokenResponse = await ServerHelper().refreshToken();
        if (refreshTokenResponse.statusCode == 200) {
          return await http
              .get(Uri.parse(apiEnvironment.baseUrl + url), headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Bearer ${Initializer.userModel.token ?? ""}',
            'Refreshtoken':
                'Bearer ${Initializer.userModel.refreshToken ?? ""}',
          });
        } else {
          return refreshTokenResponse;
        }
      } else {
        Helper.showLog("----------> AUTHENTICATED <----------");
        return getResponse;
      }
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
    return await http.post(Uri.parse(myQPadUrl + url),
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

  static delete(String url) async {
    try {
      Helper.showLog(apiEnvironment.baseUrl + url);
      Helper.showLog('Token: Bearer ${Initializer.userModel.token ?? ""}');
      Helper.showLog(
          'Refresh token: Bearer ${Initializer.userModel.refreshToken ?? ""}');
      Response getResponse =
          await http.delete(Uri.parse(apiEnvironment.baseUrl + url), headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer ${Initializer.userModel.token ?? ""}',
        'Refreshtoken': 'Bearer ${Initializer.userModel.refreshToken ?? ""}',
      });
      if (getResponse.statusCode == 401) {
        Helper.showLog("----------> NOT AUTHENTICATED <----------");
        Response refreshTokenResponse = await ServerHelper().refreshToken();
        if (refreshTokenResponse.statusCode == 200) {
          return await http
              .delete(Uri.parse(apiEnvironment.baseUrl + url), headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Bearer ${Initializer.userModel.token ?? ""}',
            'Refreshtoken':
                'Bearer ${Initializer.userModel.refreshToken ?? ""}',
          });
        } else {
          return refreshTokenResponse;
        }
      } else {
        Helper.showLog("----------> AUTHENTICATED <----------");
        return getResponse;
      }
    } on Exception catch (e) {
      // Helper.showToast(msg: e.toString());
      Helper.showLog(e.toString());
      throw Exception();
    }
  }

  static put(String url, Map<String, bool> map) async {
    try {
      Helper.showLog(apiEnvironment.baseUrl + url);
      Helper.showLog('Token: Bearer ${Initializer.userModel.token ?? ""}');
      Helper.showLog(
          'Refresh token: Bearer ${Initializer.userModel.refreshToken ?? ""}');
      Response getResponse = await http.put(
        Uri.parse(apiEnvironment.baseUrl + url),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer ${Initializer.userModel.token ?? ""}',
          'Refreshtoken': 'Bearer ${Initializer.userModel.refreshToken ?? ""}',
        },
        body: jsonEncode(map),
      );
      if (getResponse.statusCode == 401) {
        Helper.showLog("----------> NOT AUTHENTICATED <----------");
        Response refreshTokenResponse = await ServerHelper().refreshToken();
        if (refreshTokenResponse.statusCode == 200) {
          return await http
              .delete(Uri.parse(apiEnvironment.baseUrl + url), headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Authorization': 'Bearer ${Initializer.userModel.token ?? ""}',
            'Refreshtoken':
                'Bearer ${Initializer.userModel.refreshToken ?? ""}',
          });
        } else {
          return refreshTokenResponse;
        }
      } else {
        Helper.showLog("----------> AUTHENTICATED <----------");
        return getResponse;
      }
    } on Exception catch (e) {
      // Helper.showToast(msg: e.toString());
      Helper.showLog(e.toString());
      throw Exception();
    }
  }
}
