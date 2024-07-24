import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pwaohyes/main.dart';
import 'package:pwaohyes/utils/constants.dart';

class Helper {
  static FocusNode? focusNode;
  static GlobalKey? key = NavigationService.navigatorKey;
  static BuildContext? context = key!.currentContext!;
  static final width = MediaQuery.of(context!).size.width;
  static final height = MediaQuery.of(context!).size.height;

  static String? appVersion;
  static allowHeight(double height) {
    return SizedBox(height: height);
  }

  static showLog(msg)
      //{} // uncomment this for activate
      =>
      log('${(msg)} ');

  static shrink([valueKey]) {
    return SizedBox.shrink(
      key: valueKey,
    );
  }

  static allowWidth(double width) {
    return SizedBox(width: width);
  }

  static showSnack(String? text, [int seconds = 5]) {
    ScaffoldMessenger.of(context!).hideCurrentSnackBar();
    ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(duration: Duration(seconds: seconds), content: Text(text!)));
  }

  // static Future<void> hapticSuccess() async =>
  //     await Haptics.vibrate(HapticsType.success);
  // static Future<void> hapticWarning() async =>
  //     await Haptics.vibrate(HapticsType.warning);
  // static Future<void> hapticerror() async =>
  //     await Haptics.vibrate(HapticsType.error);
  // static Future<void> hapticlight() async =>
  //     await Haptics.vibrate(HapticsType.light);
  // static Future<void> hapticmedium() async =>
  //     await Haptics.vibrate(HapticsType.medium);
  // static Future<void> hapticheavy() async =>
  //     await Haptics.vibrate(HapticsType.heavy);
  // static Future<void> hapticrigid() async =>
  //     await Haptics.vibrate(HapticsType.rigid);
  // static Future<void> hapticsoft() async =>
  //     await Haptics.vibrate(HapticsType.soft);
  // static Future<void> hapticselection() async =>
  //     await Haptics.vibrate(HapticsType.selection);

  static showSnackWrong([int seconds = 5]) {
    ScaffoldMessenger.of(context!).hideCurrentSnackBar();
    ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
        duration: Duration(seconds: seconds),
        content:
            const Text("Something went wrong, Please try again later...")));
  }

  static showLoader() => showDialog(
      barrierDismissible: false,
      barrierColor: Colors.white70,
      context: context!,
      builder: (BuildContext context) => const AlertDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            content: Center(
              child: CupertinoActivityIndicator(),
            ),
          ));

  static void pop([BuildContext? passedContext]) => Navigator.pop(
        passedContext ?? context!,
      );
  static push(dynamic route) {
    return Navigator.push(
      context!,
      PageTransition(
        duration: const Duration(milliseconds: 400),
        type: PageTransitionType.fade,
        isIos: true,
        child: route,
      ),
    );
  }

  static setDateFormat({String? format, DateTime? dateTime}) =>
      DateFormat(format ?? "yyyy-MM-dd").format(dateTime ?? DateTime.now());
  static pushReplacement(dynamic route, [PageTransitionType? transitionType]) {
    return Navigator.pushReplacement(
        context!,
        PageTransition(
            type: transitionType ?? PageTransitionType.fade,
            isIos: true,
            child: route,
            duration: const Duration(microseconds: 600)));
  }

  static pushAndRemoveUntil(dynamic namedRoute) {
    return Navigator.of(context!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => namedRoute), (route) => false);
  }

  static pushReplacementWithDelay(BuildContext context, dynamic route,
      [delay]) {
    return Future.delayed(Duration(seconds: delay ?? 3), () async {
      Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            isIos: true,
            child: route,
          ));
    });
  }

  static showToast({required msg}) {
    Fluttertoast.cancel(); // for immediate stopping
    return Fluttertoast.showToast(msg: msg);
  }

  // static postFirebaseFcm() async {
  //   ApiService? apiService = ApiService();
  //   final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  //   await firebaseMessaging.getToken().then((value) async {
  //     Helper.showLog('fcmToken $value');
  //     http.Response response = await apiService
  //         .postReq('/api/customer/notification/token', {"token": value!});
  //     Helper.showLog("fcm token status ${response.statusCode}");
  //   });
  // }

  static Widget showIndicator() => const CupertinoActivityIndicator();

  static showCustomDialog(
          {BuildContext? context,
          required String title,
          required String content,
          Function()? actionOne,
          required Function() actionTwo,
          bool? oneButtonDisabled = false,
          String? actionOneText,
          required String actionTwoText}) =>
      showCupertinoDialog(
          context: context ?? Helper.context!,
          builder: (context) => CupertinoAlertDialog(
                title: Text(title),
                content: Text(content),
                actions: [
                  if (!oneButtonDisabled!)
                    CupertinoButton(
                        onPressed: actionOne,
                        child: Text(actionOneText!,
                            style:
                                const TextStyle(color: black, fontSize: 13))),
                  CupertinoButton(
                      onPressed: actionTwo,
                      child: Text(actionTwoText,
                          style: const TextStyle(color: black, fontSize: 13)))
                ],
              ));

  // static getVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   Helper.appVersion =
  //       'Version ${packageInfo.version}+${packageInfo.buildNumber}';
  // }

  static getGreeting() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 18) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }
}