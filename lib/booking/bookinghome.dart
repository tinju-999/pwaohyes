import 'package:flutter/material.dart';
import 'package:pwaohyes/booking/bookingmobile.dart';
import 'package:pwaohyes/booking/bookingweb.dart';
import 'package:pwaohyes/booking/bookingtab.dart';
import 'package:pwaohyes/utils/screensize.dart';

class BookingHome extends StatefulWidget {
  const BookingHome({super.key});

  @override
  State<BookingHome> createState() => _BookingHomeState();
}

class _BookingHomeState extends State<BookingHome> {
  @override
  Widget build(BuildContext context) {
    return const ScreenSize(
      mobileView: BookingMobile(),
      webView: BookingWeb(),
      tabView: BookingTab(),
    );
  }
}
