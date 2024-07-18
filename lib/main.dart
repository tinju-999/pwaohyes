import 'package:flutter/material.dart';
import 'package:pwa_install/pwa_install.dart';
import 'package:pwaohyes/auth/authscreen.dart';
import 'package:pwaohyes/utils/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PWAInstall().setup(installCallback: () {
    debugPrint('APP INSTALLED!');
  });
  Text('Launch Mode: ${PWAInstall().launchMode?.shortLabel}');
  Text('Has Install Prompt: ${PWAInstall().hasPrompt}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const AuthScreen(),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
