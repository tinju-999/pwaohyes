import 'package:flutter/material.dart';
import 'package:pwaohyes/slotbooking/shopview/slotshopwebview.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/screensize.dart';

class SlotShopView extends StatefulWidget {
  final String? id;

  const SlotShopView({super.key, required this.id});

  @override
  State<SlotShopView> createState() => _SlotShopViewState();
}

class _SlotShopViewState extends State<SlotShopView> {
  @override
  void initState() {
    Initializer.myQBloc.getMyQOneShop(widget.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenSize(
          mobileView: Container(),
          webView: const SlotBookingShopWebView(),
          tabView: Container()),
    );
  }
}
