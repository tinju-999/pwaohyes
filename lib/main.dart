import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/booking/bookinghome.dart';
import 'package:pwaohyes/bookingaddress/bookingaddresshome.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/service/servicehome.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/initializer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // PWAInstall().setup(installCallback: () {
  //   debugPrint('APP INSTALLED!');
  // });
  // Text('Launch Mode: ${PWAInstall().launchMode?.shortLabel}');
  // Text('Has Install Prompt: ${PWAInstall().hasPrompt}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProviderClass>(
            create: (context) => ProviderClass()),
      ],
      child: MultiBlocProvider(
        providers: [BlocProvider<AuthBloc>(create: (context) => AuthBloc())],
        child: MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            debugShowCheckedModeBanner: false,
            title: 'Oh Yes Services',
            theme: ThemeData(
              fontFamily: 'Poppins',
              colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
              appBarTheme: const AppBarTheme(
                toolbarHeight: 90,
                backgroundColor: white,
                elevation: 0.0,
              ),
              useMaterial3: false,
              scaffoldBackgroundColor: backgroundcolor,
            ),
            home: Builder(
              builder: (context) {
                Initializer.providerClass = context.read<ProviderClass>();
                return const ServiceHome();
              },
            )
            //
            // const AuthScreen(),
            ),
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
