import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/service/servicehomemobileview.dart';
import 'package:pwaohyes/service/servicehometabview.dart';
import 'package:pwaohyes/service/servicehomewebview.dart';
import 'package:pwaohyes/utils/screensize.dart';

class ServiceHome extends StatefulWidget {
  const ServiceHome({super.key});

  @override
  State<ServiceHome> createState() => _ServiceHomeState();
}

class _ServiceHomeState extends State<ServiceHome> {
  ProviderClass? providerClass;

  @override
  initState() {
    super.initState();
    providerClass = context.read<ProviderClass>();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenSize(
      mobileView: const ServiceHomeMobileView(),
      webView: ServiceHomeWebView(providerClass: providerClass,),
      tabView: const ServiceHomeTabView(),
    );
  }
}
