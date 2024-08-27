import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pwaohyes/slotbooking/slotbookingwebview.dart';
import 'package:pwaohyes/utils/screensize.dart';

class SlotBookingView extends StatefulWidget {
  const SlotBookingView({super.key});

  @override
  State<SlotBookingView> createState() => _SlotBookingViewState();
}

class _SlotBookingViewState extends State<SlotBookingView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenSize(
          mobileView: Container(),
          webView: const SlotBookingWebView(),
          tabView: Container()),
    );
  }
}
