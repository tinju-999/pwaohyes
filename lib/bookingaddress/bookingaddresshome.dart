import 'package:flutter/material.dart';
import 'package:pwaohyes/bookingaddress/bookingaddressmobile.dart';
import 'package:pwaohyes/bookingaddress/bookingaddresstab.dart';
import 'package:pwaohyes/bookingaddress/bookingaddressweb.dart';
import 'package:pwaohyes/utils/screensize.dart';

class BookingAddress extends StatefulWidget {
  const BookingAddress({super.key});

  @override
  State<BookingAddress> createState() => _BookingAddressState();
}

class _BookingAddressState extends State<BookingAddress> {
  @override
  Widget build(BuildContext context) {
    return const ScreenSize(
      mobileView: BookingAddressMobile(),
      webView: BookingAddressWeb(),
      tabView: BookingAddressTab(),
    );
  }
}
