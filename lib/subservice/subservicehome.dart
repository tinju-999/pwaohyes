import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwaohyes/bloc/servicebloc.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/subservice/subservicemobileview.dart';
import 'package:pwaohyes/subservice/subservicewebview.dart';
import 'package:pwaohyes/utils/screensize.dart';

class SubServiceHome extends StatefulWidget {
  final String? subServiceId;
  const SubServiceHome({super.key, this.subServiceId});

  @override
  State<SubServiceHome> createState() => _ServiceHomeState();
}

class _ServiceHomeState extends State<SubServiceHome> {
  ProviderClass? providerClass;

  @override
  initState() {
    super.initState();
    context.read<ServiceBloc>().add(GetSubServices(id: widget.subServiceId!));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenSize(
      mobileView: const SubServiceMobileView(),
      webView: const SubServiceWebView(),
      tabView: Container(),
    );
  }
}
