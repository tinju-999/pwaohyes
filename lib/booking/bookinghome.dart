import 'package:flutter/material.dart';
import 'package:pwaohyes/booking/bookingmobile.dart';
import 'package:pwaohyes/booking/bookingweb.dart';
import 'package:pwaohyes/booking/bookingtab.dart';
import 'package:pwaohyes/utils/screensize.dart';

class BookingHome extends StatelessWidget {
  final String? catId, title;
  const BookingHome({super.key, required this.catId, this.title});

  @override
  Widget build(BuildContext context) {
    return ScreenSize(
      mobileView: const BookingMobile(),
      webView: BookingWeb(catId: catId),
      tabView: const BookingTab(),
    );
  }
}
