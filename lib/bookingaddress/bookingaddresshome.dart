import 'package:flutter/material.dart';
import 'package:pwaohyes/bookingaddress/bookingaddressmobile.dart';
import 'package:pwaohyes/bookingaddress/bookingaddresstab.dart';
import 'package:pwaohyes/bookingaddress/bookingaddressweb.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/routes.dart';
import 'package:pwaohyes/utils/screensize.dart';

class BookingAddress extends StatefulWidget {
  final String? service, id;
  const BookingAddress({super.key, this.service, this.id});

  @override
  State<BookingAddress> createState() => _BookingAddressState();
}

class _BookingAddressState extends State<BookingAddress> {
  @override
  void initState() {
    checkAndRedirect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const ScreenSize(
      mobileView: BookingAddressMobile(),
      webView: BookingAddressWeb(),
      tabView: BookingAddressTab(),
    );
  }

  Future<void> checkAndRedirect() async {
    await Future.delayed(const Duration(milliseconds: 50)).then((_) {
      if (widget.service != null && widget.id != null) {
        if (!Initializer.userModel.isLoggedIn!) {
          if (Initializer.selectedAdddress!.loadingState ==
              LoadingState.success) {
            Helper.pushReplacementNamed(allservices);
          } else {
            Helper.pushReplacementNamed(locationView);
          }
        }
      } else {
        Helper.showSnack("Service details is empty, redirecting...");
        if (Initializer.selectedAdddress!.loadingState ==
            LoadingState.success) {
          Helper.pushReplacementNamed(allservices);
        } else {
          Helper.pushReplacementNamed(locationView);
        }
      }
    });
  }
}
