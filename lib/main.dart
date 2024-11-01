import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/bloc/bookingbloc.dart';
import 'package:pwaohyes/bloc/locationbloc.dart';
import 'package:pwaohyes/bloc/myqbloc.dart';
import 'package:pwaohyes/bloc/servicebloc.dart';
import 'package:pwaohyes/booking/bookinghome.dart';
import 'package:pwaohyes/booking/bookingweb.dart';
import 'package:pwaohyes/bookingaddress/bookingaddresshome.dart';
import 'package:pwaohyes/bookingaddress/bookingaddressweb.dart';
import 'package:pwaohyes/location/locationpermissionview.dart';
import 'package:pwaohyes/model/selectedaddressmodel.dart';
import 'package:pwaohyes/model/usermodel.dart';
import 'package:pwaohyes/provider/locationprovider.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/review/addreviewpage.dart';
import 'package:pwaohyes/service/servicehome.dart';
import 'package:pwaohyes/slotbooking/shopview/shopview.dart';
import 'package:pwaohyes/slotbooking/slotbookingview.dart';
import 'package:pwaohyes/subservice/subservicehome.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/preferences.dart';
import 'package:pwaohyes/utils/routes.dart';
import 'package:url_strategy/url_strategy.dart';
// import 'dart:js';
//7034444303
// void useJsObject(JsObject jsObject) {
//    // Ensure jsObject is not null
//   // Example: Call a method on the JavaScript object
//   context.callMethod('console.log', [jsObject]);
// }

Future<void> main() async {
  // PWAInstall().setup(installCallback: () {
  //   debugPrint('APP INSTALLED!');
  // });

  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  // if (PWAInstall().installPromptEnabled) {
  //   Helper.showLog("Install prompt enabled");
  // }

  // Create a JavaScript object with properties
  // var jsObject = JsObject.jsify({'key': 'value'});

  // // Call a JavaScript function
  // context.callMethod('alert', ['Hello from Dart!']);

  // Pass the JavaScript object to another function
  // useJsObject(jsObject);

  // PWAInstall().setup(installCallback: () {
  //   debugPrint('APP INSTALLED!');
  // });
  // Text('Launch Mode: ${PWAInstall().launchMode?.shortLabel}');
  // Text('Has Install Prompt: ${PWAInstall().hasPrompt}');

  var token = await Preferences.getToken();
  var refreshToken = await Preferences.getRefershToken();
  var location = await Preferences.getLocation();
  Helper.showLog("the token: $token");
  Helper.showLog("the refresh-token: $refreshToken");
  if (location.isNotEmpty) {
    Initializer.selectedAdddress =
        SelectedAddressModel.fromJson(jsonDecode(location));
  }
  if (token.isNotEmpty) {
    var phone = await Preferences.getPhone();
    Initializer.userModel = UserModel(
        isLoggedIn: true,
        token: token,
        refreshToken: refreshToken,
        phone: phone);
  } else {
    Initializer.userModel =
        UserModel(isLoggedIn: false, token: "", refreshToken: "");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ServiceBloc()),
        BlocProvider(create: (context) => MyQBloc()),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ProviderClass>(
              create: (context) => ProviderClass()),
          ChangeNotifierProvider<LocationProvider>(
              create: (context) => LocationProvider()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
            BlocProvider<LocationBloc>(create: (context) => LocationBloc()),
            BlocProvider<MyQBloc>(create: (context) => MyQBloc()),
            BlocProvider<BookingBloc>(create: (context) => BookingBloc()),
            //MyQBloc
          ],
          child: MaterialApp(
              navigatorKey: NavigationService.navigatorKey,
              debugShowCheckedModeBanner: false,
              title: 'Oh Yes Services',
              theme: ThemeData(
                fontFamily: 'Poppins',
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
                appBarTheme: const AppBarTheme(
                  toolbarHeight: 90,
                  // backgroundColor: white,
                  elevation: 0.0,
                ),
                useMaterial3: false,
                // scaffoldBackgroundColor: backgroundcolor,
              ),
              // onGenerateRoute: (RouteSettings route){

              // },
              // initialRoute: locationView,
              routes: routes,
              onGenerateRoute: (settings) {
                Uri uri = Uri.parse(settings.name!);
                if (uri.pathSegments.isNotEmpty &&
                    uri.pathSegments.first.toLowerCase() == 'addreviewpage') {
                  final shopName = uri.queryParameters['shopName'];
                  final shopCat = uri.queryParameters['shopCat'];
                  final partnerId = uri.queryParameters['partnerId'];
                  final shopId = uri.queryParameters['shopId'];
                  final rating = uri.queryParameters['rating'];
                  final comment = uri.queryParameters['comment'];
                  final commentId = uri.queryParameters['commentId'];

                  return MaterialPageRoute(
                      builder: (context) => AddReviewPage(
                            shopName: shopName,
                            shopCat: shopCat,
                            partnerId: partnerId,
                            shopId: shopId,
                            rating: rating,
                            comment: comment,
                            commentId: commentId,
                          ),
                      settings: RouteSettings(name: settings.name));
                } else if (uri.pathSegments.isNotEmpty &&
                    uri.pathSegments.first.toLowerCase() == 'slotbookingshop') {
                  final id = uri.queryParameters['id'];
                  return MaterialPageRoute(
                      builder: (context) => SlotShopView(id: id),
                      settings: RouteSettings(name: settings.name));
                } else if (uri.pathSegments.first.toLowerCase() == 'booking') {
                  final catId = uri.queryParameters['catId'];
                  final title = uri.queryParameters['title'];
                  return MaterialPageRoute(
                      builder: (context) =>
                          BookingHome(catId: catId, title: title),
                      settings: RouteSettings(name: settings.name));
                } else if (uri.pathSegments.first.toLowerCase() ==
                    'subservices') {
                  final subServiceId = uri.queryParameters['subServiceId'];
                  return MaterialPageRoute(
                      builder: (context) =>
                          SubServiceHome(subServiceId: subServiceId),
                      settings: RouteSettings(name: settings.name));
                } else if (uri.pathSegments.first.toLowerCase() ==
                    'chooselocation') {
                  return MaterialPageRoute(
                      builder: (context) =>
                          const LocationPermissionView(route: null),
                      settings: RouteSettings(name: settings.name));
                } else if (uri.pathSegments.first.toLowerCase() ==
                    'allservices') {
                  return MaterialPageRoute(
                      builder: (context) => const ServiceHome(),
                      settings: RouteSettings(name: settings.name));
                } else if (uri.pathSegments.first.toLowerCase() ==
                    'servicebooking') {
                  return MaterialPageRoute(
                      builder: (context) => const BookingWeb(),
                      settings: RouteSettings(name: settings.name));
                } else if (uri.pathSegments.first.toLowerCase() ==
                    'confirmbooking') {
                  return MaterialPageRoute(
                      builder: (context) => const BookingAddressWeb(),
                      settings: RouteSettings(name: settings.name));
                } else if (uri.pathSegments.first.toLowerCase() ==
                    'slotbooking') {
                  return MaterialPageRoute(
                      builder: (context) => const SlotBookingView(),
                      settings: RouteSettings(name: settings.name));
                } else if (uri.pathSegments.first.toLowerCase() ==
                    'bookingaddress') {
                  final service = uri.queryParameters['service'];
                  final id = uri.queryParameters['id'];
                  return MaterialPageRoute(
                      builder: (context) =>
                          BookingAddress(service: service, id: id),
                      settings: RouteSettings(name: settings.name));
                }
                //SubServiceHome
                return Initializer.selectedAdddress!.loadingState ==
                        LoadingState.success
                    ? MaterialPageRoute(
                        builder: (context) => const ServiceHome(),
                        settings: const RouteSettings(name: "allservices"))
                    : MaterialPageRoute(
                        builder: (context) =>
                            const LocationPermissionView(route: null),
                        settings: const RouteSettings(name: 'chooselocation'));
              },
              home: Builder(
                builder: (context) {
                  Initializer.providerClass = context.read<ProviderClass>();
                  Initializer.serviceBloc = context.read<ServiceBloc>();
                  Initializer.authBloc = context.read<AuthBloc>();
                  Initializer.locationBloc = context.read<LocationBloc>();
                  Initializer.myQBloc = context.read<MyQBloc>();
                  Initializer.locationProvider =
                      context.read<LocationProvider>();
                  return Initializer.selectedAdddress!.loadingState ==
                          LoadingState.success
                      ? const ServiceHome()
                      : const LocationPermissionView(route: null);
                },
              )),
        ),
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
