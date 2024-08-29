import 'package:flutter/material.dart';
import 'package:pwaohyes/slotbooking/slotbookingwebview.dart';
import 'package:pwaohyes/slotbooking/slotbookinmobileview.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/screensize.dart';

class SlotBookingView extends StatefulWidget {
  const SlotBookingView({super.key});

  @override
  State<SlotBookingView> createState() => _SlotBookingViewState();
}

class _SlotBookingViewState extends State<SlotBookingView> {
  @override
  void initState() {
    Initializer.myQBloc.getMyQCats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenSize(
          mobileView: const SlotBookingMobileView(),
          webView: const SlotBookingWebView(),
          tabView: Container()),
    );
  }
}
