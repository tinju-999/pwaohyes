import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/bloc/servicebloc.dart';
import 'package:pwaohyes/common/footer.dart';
import 'package:pwaohyes/common/header.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class BookingMobile extends StatefulWidget {
  final String? catId, title;
  const BookingMobile({super.key, this.catId, this.title});

  @override
  State<BookingMobile> createState() => _BookingMobileState();
}

class _BookingMobileState extends State<BookingMobile> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const Drawer(),
      bottomNavigationBar: bookingButton(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Header(
                removeBadge: false,
                scaffoldKey: scaffoldKey,
                route: const BookingMobile(),
              ),
              Helper.allowHeight(10),
              BookingMobilePage(
                title: widget.title,
              ),
              Helper.allowHeight(10),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }

  bookingButton(BuildContext context) => Container(
        color: white,
        margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
        width: Helper.width / 2,
        child: MaterialButton(
          onPressed: () => Helper.getApp(),
          elevation: 5.0,
          color: primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
          child:
              const Text("Use App For Booking", style: TextStyle(color: white)),
        ),
      );
}

class BookingMobilePage extends StatelessWidget {
  final String? title;
  const BookingMobilePage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Helper.width,
        color: white,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        child: BlocBuilder<ServiceBloc, ServiceState>(
          buildWhen: (previous, current) =>
              current is GettingServiceDetail ||
              current is ServiceDetailFetched ||
              current is ServiceDetailNotFetched,
          builder: (context, state) => state is GettingServiceDetail
              ? const Center(child: CupertinoActivityIndicator())
              : state is ServiceDetailFetched
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Container(
                        //   clipBehavior: Clip.hardEdge,
                        //   decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(8.0),
                        //       color: primaryColor),
                        //   width: Helper.width,
                        //   height: 140,
                        //   constraints:
                        //       BoxConstraints(maxHeight: Helper.height / 6.5),
                        // ),
                        // Helper.allowHeight(15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  Initializer.serviceDetailedModel.data!
                                      .service!.title!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Helper.allowHeight(2.5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Selector<ProviderClass, String>(
                                      selector: (p0, p1) => p1.selectedServiceAmount,
                                      builder: (context, value, child) =>
                                          value == "0"
                                              ? const Text(
                                                  "Free",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.green,
                                                      fontSize: 18),
                                                )
                                              : Text(
                                                  "$rupeeSymbol $value",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18),
                                                ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: primaryColor,
                              ),
                              constraints: const BoxConstraints(maxHeight: 80),
                              child: Initializer.serviceDetailedModel.data!
                                      .service!.image!.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: Initializer.serviceDetailedModel
                                          .data!.service!.image!.first,
                                      fit: BoxFit.cover,
                                      width: Helper.width / 2.5,
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        'assets/images/bg2.jpeg',
                                        fit: BoxFit.fitHeight,
                                      ),
                                    )
                                  : Image.asset(
                                      'assets/images/bg2.jpeg',
                                      fit: BoxFit.fitHeight,
                                    ),
                            ),
                          ],
                        ),

                        //servicesview
                        Helper.allowHeight(10),
                        if (Initializer.serviceDetailedModel.data!.serviceTypes!
                            .isNotEmpty)
                          selectServiceView(), //descriptionview
                        Helper.allowHeight(15),
                        descriptionView(),
                        if (Initializer.serviceDetailedModel.data!.service!
                                .description!.included!.isNotEmpty ||
                            Initializer.serviceDetailedModel.data!.service!
                                .description!.excluded!.isNotEmpty)
                          includedAndExcludedView(),
                      ],
                    )
                  : Center(
                      child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: BackButton()),
                        Helper.allowHeight(30),
                        const Text("Something went wrong"),
                        Helper.allowHeight(30),
                      ],
                    )),
        ));
  }

  selectServiceView() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Select Services",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: Helper.width / 2, child: const Divider()),
          Helper.allowHeight(5),
          Wrap(
            runSpacing: 1.0,
            children: List.generate(
                Initializer.serviceDetailedModel.data!.serviceTypes!.length,
                (index) => Container(
                      margin: const EdgeInsets.only(right: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Selector<ProviderClass, String>(
                            selector: (p0, p1) => p1.selectedServiceId,
                            builder: (context, value, child) => SizedBox(
                              width: 30,
                              height: 30,
                              child: Radio<String>(
                                value: Initializer.serviceDetailedModel.data!
                                    .serviceTypes![index].sId!,
                                groupValue: value,
                                activeColor: primaryColor,
                                focusColor: grey,
                                // title: const Text("Title"),
                                onChanged: (value) => Initializer.providerClass!
                                    .chooseService(value!, index),
                              ),
                            ),
                          ),
                          Helper.allowWidth(5),
                          Text(
                            Initializer.serviceDetailedModel.data!
                                .serviceTypes![index].name!,
                            style: const TextStyle(fontSize: 13),
                          )
                        ],
                      ),
                    )),
          ),
        ],
      );

  descriptionView() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Description",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: Helper.width / 2, child: const Divider()),
          Helper.allowHeight(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                child: Text(
                  Initializer
                      .serviceDetailedModel.data!.service!.description!.text!,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  includedAndExcludedView() => Column(
        children: [
          if (Initializer.serviceDetailedModel.data!.service!.description!
              .included!.isNotEmpty)
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Helper.allowHeight(10),
                const Text(
                  "Included",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Helper.allowHeight(5),
                const Divider(),
                Helper.allowHeight(5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      Initializer.serviceDetailedModel.data!.service!
                          .description!.included!.length,
                      (index) => Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 22,
                                  ),
                                  Helper.allowWidth(30),
                                  Flexible(
                                    child: Text(
                                      Initializer
                                          .serviceDetailedModel
                                          .data!
                                          .service!
                                          .description!
                                          .included![index],
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  )
                                ],
                              ),
                              if (index !=
                                  Initializer
                                          .serviceDetailedModel
                                          .data!
                                          .service!
                                          .description!
                                          .included!
                                          .length +
                                      1)
                                Helper.allowHeight(5.0)
                            ],
                          )),
                )
              ],
            ),
          if (Initializer.serviceDetailedModel.data!.service!.description!
              .included!.isNotEmpty)
            Helper.allowHeight(15),
          if (Initializer.serviceDetailedModel.data!.service!.description!
              .excluded!.isNotEmpty)
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Excluded",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Helper.allowHeight(5),
                const Divider(),
                Helper.allowHeight(5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                      Initializer.serviceDetailedModel.data!.service!
                          .description!.excluded!.length,
                      (index) => Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.close_outlined,
                                    color: Colors.red,
                                    size: 22,
                                  ),
                                  Helper.allowWidth(30),
                                  Flexible(
                                    child: Text(
                                      Initializer
                                          .serviceDetailedModel
                                          .data!
                                          .service!
                                          .description!
                                          .excluded![index],
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              if (index !=
                                  Initializer
                                          .serviceDetailedModel
                                          .data!
                                          .service!
                                          .description!
                                          .excluded!
                                          .length +
                                      1)
                                Helper.allowHeight(5.0)
                            ],
                          )),
                )
              ],
            ),
        ],
      );

  //includes&excludesview
}
