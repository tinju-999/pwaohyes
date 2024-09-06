import 'package:flutter/material.dart';
import 'package:pwaohyes/slotbooking/shopview/slobookingshopmobileview.dart';
import 'package:pwaohyes/slotbooking/shopview/slotshopwebview.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/screensize.dart';

class SlotShopView extends StatefulWidget {
  final String? id;

  const SlotShopView({super.key, this.id});

  @override
  State<SlotShopView> createState() => _SlotShopViewState();
}

class _SlotShopViewState extends State<SlotShopView> {
  @override
  void initState() {
    Initializer.selectedShopId = widget.id;
    Initializer.seletedShopSlotDate = DateTime.now();
    Initializer.myQBloc.getMyQOneShop(widget.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ScreenSize(
          mobileView: SlotBookingShopMobileView(),
          webView: SlotBookingShopWebView(),
          tabView: SlotBookingShopWebView()),
    );
  }
}
