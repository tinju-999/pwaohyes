import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwaohyes/bloc/servicebloc.dart';
import 'package:pwaohyes/booking/bookingmobile.dart';
import 'package:pwaohyes/booking/bookingweb.dart';
import 'package:pwaohyes/booking/bookingtab.dart';
import 'package:pwaohyes/utils/screensize.dart';

class BookingHome extends StatefulWidget {
  final String? catId, title;
  const BookingHome({super.key, this.catId, this.title});

  @override
  State<BookingHome> createState() => _BookingHomeState();
}

class _BookingHomeState extends State<BookingHome> {
  @override
  void initState() {
    context.read<ServiceBloc>().add(GetSubServicesDetail(catId: widget.catId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenSize(
      mobileView: BookingMobile(catId: widget.catId, title: widget.title),
      webView: BookingWeb(catId: widget.catId, title: widget.title),
      tabView: const BookingTab(),
    );
  }
}
