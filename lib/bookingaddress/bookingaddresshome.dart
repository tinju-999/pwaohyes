import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwaohyes/bloc/bookingbloc.dart';
import 'package:pwaohyes/bookingaddress/bookingaddressmobile.dart';
import 'package:pwaohyes/bookingaddress/bookingaddresstab.dart';
import 'package:pwaohyes/bookingaddress/bookingaddressweb.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/routes.dart';
import 'package:pwaohyes/utils/screensize.dart';

class BookingAddress extends StatefulWidget {
  final String? service, id, serviceAmount;
  const BookingAddress({super.key, this.service, this.id, this.serviceAmount});

  @override
  State<BookingAddress> createState() => _BookingAddressState();
}

class _BookingAddressState extends State<BookingAddress> {
  @override
  void initState() {
    Initializer.selectedServiceId = widget.id;
    Initializer.selectedServiceAmount = widget.serviceAmount;
    checkAndRedirect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingBloc, BookingState>(
      builder: (context, state) => ScreenSize(
        mobileView: const BookingAddressMobile(),
        webView: BookingAddressWeb(
          serviceTitle: widget.service,
        ),
        tabView: const BookingAddressTab(),
      ),
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
        } else {
          context
              .read<BookingBloc>()
              .add(GetSelectedServiceDetails(id: widget.id));
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
