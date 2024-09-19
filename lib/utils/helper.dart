import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/main.dart';
import 'package:pwaohyes/model/bookingdatemodel.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:js' as js;

class Helper {
  static FocusNode? focusNode;
  static GlobalKey? key = NavigationService.navigatorKey;
  static BuildContext? context = key!.currentContext!;
  static double width = MediaQuery.of(context!).size.width;
  static double height = MediaQuery.of(context!).size.height;

  static String? appVersion;
  static allowHeight(double height) {
    return SizedBox(height: height);
  }

  static setDateAndTimings() {
    DateTime now = DateTime.now();
    //

    Initializer.bookingDateSuggestions.clear();
    //
    Initializer.bookingDateSuggestions.addAll([
      BookingDateTimeModel(
        date: now,
        label: "Today",
        isSelected: true,
      ),
      BookingDateTimeModel(
        date: now.add(const Duration(days: 1)),
        label: "Tomorrow",
        isSelected: false,
      ),
      BookingDateTimeModel(
        date: now,
        label: "Custom",
        isSelected: false,
      ),
    ]);

    setTimings(now);
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

  static void showAuthDialogue({required BuildContext context}) {
    final formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Form(
          key: formKey,
          child: BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) =>
                current is VerifyingOTP ||
                current is OTPVerified ||
                current is OTPNotVerified ||
                current is VerifyingOTPError ||
                current is RequestingOTP ||
                current is OTPRequested ||
                current is OTPNotRequested ||
                current is OTPNotRequested,
            builder: (context, state) => Container(
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                  )),
              padding: const EdgeInsets.only(
                  top: 32, bottom: 18, left: 14, right: 14),
              width: Helper.width / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Verify Now",
                    style: TextStyle(fontSize: 28),
                  ),
                  Helper.allowHeight(5),
                  const Text(
                    "Please Enter Your Mobile Number To Verify",
                    style: TextStyle(
                      fontSize: 14,
                      color: grey,
                    ),
                  ),
                  Helper.allowHeight(10),
                  TextFormField(
                      autofocus: true,
                      controller: Initializer.phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter mobile number";
                        } else {
                          return null;
                        }
                      },
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      buildCounter: (context,
                              {required currentLength,
                              required isFocused,
                              required maxLength}) =>
                          Helper.shrink(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 14),
                        hintText: "Mobile Number",
                        hintStyle: const TextStyle(fontSize: 13, color: grey),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      )),
                  if (state is OTPRequested) Helper.allowHeight(10),
                  if (state is OTPRequested ||
                      Initializer.otpController.text.isNotEmpty)
                    TextFormField(
                        autofocus: true,
                        controller: Initializer.otpController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter a valid OTP";
                          } else {
                            return null;
                          }
                        },
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        buildCounter: (context,
                                {required currentLength,
                                required isFocused,
                                required maxLength}) =>
                            Helper.shrink(),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 14),
                          hintText: "OTP",
                          hintStyle: const TextStyle(fontSize: 13, color: grey),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: grey),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        )),
                  Helper.allowHeight(10),
                  SizedBox(
                    width: Helper.width,
                    child: MaterialButton(
                      onPressed: () {
                        if (state is! RequestingOTP || state is! VerifyingOTP) {
                          if (state is OTPRequested) {
                            if (formKey.currentState!.validate()) {
                              Initializer.authBloc.verifyOtp(
                                  Initializer.otpController.text,
                                  Initializer.phoneController.text);
                            }
                          } else {
                            if (formKey.currentState!.validate()) {
                              Initializer.authBloc.verifyPhone(
                                  Initializer.phoneController.text);
                            }
                          }
                        }
                      },
                      elevation: 5.0,
                      color: primaryColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 6),
                      child: state is RequestingOTP || state is VerifyingOTP
                          ? const Center(
                              child: CupertinoActivityIndicator(
                                  color: Colors.white))
                          : state is OTPRequested
                              ? const Text("Verify OTP",
                                  style: TextStyle(color: white, fontSize: 16))
                              : const Text("Send OTP",
                                  style: TextStyle(color: white, fontSize: 16)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
        duration: const Duration(microseconds: 600),
      ),
    );
  }

  static pushReplacementNamed(String routeName) =>
      Navigator.of(context!).pushReplacementNamed(routeName);

  static pushNamed(String routeName, [Map? arguments]) =>
      Navigator.of(context!).pushNamed(
        routeName,
        arguments: arguments,
      );

  static pushAndRemoveUntil(dynamic namedRoute) {
    return Navigator.of(context!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => namedRoute), (route) => false);
  }

  static pushReplacementWithDelay(dynamic route, [delay]) {
    return Future.delayed(Duration(seconds: delay ?? 3), () async {
      Navigator.pushReplacement(
          key!.currentContext!,
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

  static DateTime getStartTime(DateTime now) =>
      DateTime(now.year, now.month, now.day, 8, 0, 0, 0, 0);

  static DateTime getEndingTime(DateTime now) =>
      DateTime(now.year, now.month, now.day, 20, 0, 0, 0, 0);

  static void loopDates(
      int diiference, DateTime? date, DateTime now, DateTime endingTime) {
    for (int i = 1; i <= diiference; i++) {
      if (i == 1) {
        date = DateTime(now.year, now.month, now.day, now.hour + i, 30, 0, 0);
      } else {
        if (date!.isBefore(endingTime)) {
          date = DateTime(now.year, now.month, now.day, now.hour + i, 0, 0, 0);
        } else {
          break;
        }
      }
      Initializer.bookingTimeSuggestions.add(
        BookingDateTimeModel(
          label: Helper.setDateFormat(dateTime: date, format: "hh:mm a"),
          date: date,
          isSelected: i == 1 ? true : false,
        ),
      );
    }

    Initializer.bookingTimeSuggestions.add(
      BookingDateTimeModel(
        label: "Select Time",
        date: date,
        isSelected: false,
      ),
    );
  }

  static void setTimings(DateTime now) {
    Initializer.bookingTimeSuggestions.clear();
    // DateTime startingTime = getStartTime(now);
    DateTime endingTime = getEndingTime(now);

    if (now.isBefore(endingTime)) {
      DateTime? date;
      int diiference = endingTime.difference(now).inHours;
      if (diiference >= 3) {
        loopDates(diiference < 3 ? diiference : 3, date, now, endingTime);
      } else {
        loopDates(diiference, date, now, endingTime);
      }
    } else {
      Helper.showLog('now.isBefore(endingTime)');
    }
  }

  static String toTitleCase(String input) {
    if (input.isEmpty) return input;

    // Trim leading and trailing whitespaces
    input = input.trim();

    // Split the input into words using space as a delimiter
    List<String> words = input.split(' ');

    // Capitalize the first letter of each word
    List<String> titleCaseWords = words.map((word) {
      if (word.isEmpty) {
        return word; // Handle any empty strings (e.g., multiple spaces)
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).toList();

    // Join the words back together
    return titleCaseWords.join(' ');
  }

  static String toSentenceCase(String input) {
    if (input.isEmpty) return input;

    // Trim leading and trailing whitespaces
    input = input.trim();

    // Convert the entire input to lowercase
    input = input.toLowerCase();

    // Split the input into sentences using '. ', '!', and '?' as delimiters
    List<String> sentences = input.split(RegExp(r'(?<=[.!?])\s+'));

    // Capitalize the first letter of each sentence
    List<String> sentenceCaseSentences = sentences.map((sentence) {
      if (sentence.isEmpty) return sentence;
      return sentence[0].toUpperCase() + sentence.substring(1);
    }).toList();

    // Join the sentences back together
    return sentenceCaseSentences.join(' ');
  }

  static double getPercentage(double totalValue, num value) =>
      (((value / totalValue) * 100) * 100);

  // static String getDeviceType() {
  //   String deviceType = '';
  //   if (Platform.isAndroid) {
  //     deviceType = 'android';
  //   } else if (Platform.isIOS) {
  //     deviceType = 'ios';
  //   } else {
  //     deviceType = 'web';
  //   }
  //   return deviceType;
  // }

  static String timeConversion({required String? time24}) {
    // Parse the input time string (24-hour format)
    final DateTime parsedTime = DateFormat("HH:mm").parse(time24!);

    // Format the parsed time into a 12-hour format with AM/PM
    final String formattedTime = DateFormat("hh:mm a").format(parsedTime);

    return formattedTime;
  }

  static Widget wrapperShimmer(
          {required double? width, required double? height}) =>
      Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        children: List.generate(
          9,
          (index) => Shimmer.fromColors(
            baseColor: Colors.grey[100]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              width: width ?? Helper.width / 6,
              height: height ?? 60,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
        ),
      );

  static launchUrl(String url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  static getApp() =>
      js.context.callMethod('open', ['https://live.ohyesworld.com/get/app']);

  static openMap({required double lat, lon}) => js.context
      .callMethod('open', ['https://www.google.com/maps?q=$lat,$lon']);

  static void showSuccessWeb() => showDialog(
        context: context!,
        builder: (context) => AlertDialog(
            content: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                  )),
              padding: const EdgeInsets.only(
                  top: 32, bottom: 18, left: 14, right: 14),
              width: Helper.width / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(CupertinoIcons.checkmark_seal_fill,
                      color: Colors.green, size: 60),
                  Helper.allowHeight(5),
                  const Text(
                    "Service Booked Successfully",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                  Helper.allowHeight(10),
                  SizedBox(
                    width: Helper.width / 1.2,
                    child: const Text(
                      "Track your bookings, schedule new services, and explore convenient household services near you with the Oh Yes app.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Helper.allowHeight(10),
                  Container(
                    color: white,
                    margin: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 32),
                    width: Helper.width / 2,
                    child: MaterialButton(
                      onPressed: () => Helper.getApp(),
                      elevation: 5.0,
                      color: primaryColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 14),
                      child:
                          const Text("Use App", style: TextStyle(color: white)),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: -80,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: white,
                ),
                child: IconButton(
                  onPressed: () => Helper.pop,
                  icon: const Icon(CupertinoIcons.clear, color: black),
                ),
              ),
            ),
          ],
        )),
      );

  static showSuccessMobile() => showDialog(
        context: context!,
        builder: (context) => AlertDialog(
            content: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(CupertinoIcons.checkmark_seal_fill,
                      color: Colors.green, size: 55),
                  Helper.allowHeight(10),
                  const Text(
                    "Service Booked Successfully",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.green,
                    ),
                  ),
                  Helper.allowHeight(10),
                  SizedBox(
                    width: Helper.width / 1.2,
                    child: const Text(
                      "Track your bookings, schedule new services, and explore convenient household services near you with the Oh Yes app.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Helper.allowHeight(10),
                  Container(
                    color: white,
                    margin: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 32),
                    width: Helper.width / 2,
                    child: MaterialButton(
                      onPressed: () => Helper.getApp(),
                      elevation: 5.0,
                      color: primaryColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 14),
                      child:
                          const Text("Use App", style: TextStyle(color: white)),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: -80,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: white,
                ),
                child: IconButton(
                  onPressed: () => Helper.pop,
                  icon: const Icon(
                    CupertinoIcons.clear,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        )),
      );

  static bool isMobile() {
    double screenWidth = MediaQuery.of(context!).size.width;
    return screenWidth < 600; // Define your screen size threshold
  }
}
