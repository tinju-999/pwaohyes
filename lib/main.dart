import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/bloc/locationbloc.dart';
import 'package:pwaohyes/bloc/servicebloc.dart';
import 'package:pwaohyes/location/locationpermissionview.dart';
import 'package:pwaohyes/model/selectedaddressmodel.dart';
import 'package:pwaohyes/model/usermodel.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/service/servicehome.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/preferences.dart';
import 'package:pwaohyes/utils/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // PWAInstall().setup(installCallback: () {
  //   debugPrint('APP INSTALLED!');
  // });
  // Text('Launch Mode: ${PWAInstall().launchMode?.shortLabel}');
  // Text('Has Install Prompt: ${PWAInstall().hasPrompt}');

  var token = await Preferences.getToken();
  var location = await Preferences.getLocation();
  Helper.showLog("the token is $token and location is $location");
  if (location.isNotEmpty) {
    Initializer.selectedAdddress =
        SelectedAddressModel.fromJson(jsonDecode(location));
  }
  if (token.isNotEmpty) {
    Initializer.userModel = UserModel(
      isLoggedIn: true,
      token: token,
    );
  } else {
    Initializer.userModel = UserModel(
      isLoggedIn: false,
      token: "",
    );
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
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ProviderClass>(
              create: (context) => ProviderClass()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
            BlocProvider<LocationBloc>(create: (context) => LocationBloc()),
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
              initialRoute: LocationView,
              routes: routes,

              home: Builder(
                builder: (context) {
                  Initializer.providerClass = context.read<ProviderClass>();
                  Initializer.serviceBloc = context.read<ServiceBloc>();
                  Initializer.authBloc = context.read<AuthBloc>();
                  Initializer.locationBloc = context.read<LocationBloc>();
                  return
                      // const ServiceHome();
                      // const BookingAddressWeb();
                      Initializer.selectedAdddress != null
                          ? const ServiceHome()
                          : const LocationPermissionView(route: null);
                },
              )
              //
              // const AuthScreen(),
              ),
        ),
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
