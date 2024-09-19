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
import 'package:pwaohyes/utils/routes.dart';

class BookingWeb extends StatefulWidget {
  final String? catId, title;
  const BookingWeb({super.key, this.catId, this.title});

  @override
  State<BookingWeb> createState() => _BookingWebState();
}

class _BookingWebState extends State<BookingWeb> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Header(
              removeBadge: false,
              route: BookingWeb(catId: widget.catId),
              scaffoldKey: scaffoldKey,
            ),
            Helper.allowHeight(15),
            BookingWebPage(title: widget.title),
            Helper.allowHeight(15),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class BookingWebPage extends StatefulWidget {
  final String? title;
  const BookingWebPage({super.key, this.title});

  @override
  State<BookingWebPage> createState() => _BookingWebPageState();
}

class _BookingWebPageState extends State<BookingWebPage> {
  final yourScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
      color: white,
      child: BlocBuilder<ServiceBloc, ServiceState>(
        buildWhen: (previous, current) =>
            current is GettingServiceDetail ||
            current is ServiceDetailFetched ||
            current is ServiceDetailNotFetched,
        builder: (context, state) => state is GettingServiceDetail
            ? const Center(child: CupertinoActivityIndicator())
            : state is ServiceDetailFetched
                ? Column(
                    children: [
                      Helper.allowHeight(15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: Helper.height / 3,
                              constraints:
                                  BoxConstraints(maxHeight: Helper.height / 3),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                // color: primaryColor,
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Initializer.serviceDetailedModel.data!
                                      .service!.image!.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: Initializer.serviceDetailedModel
                                          .data!.service!.image!.first,
                                      fit: BoxFit.cover,
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
                          ),
                          Helper.allowWidth(30),
                          Expanded(
                            flex: 8,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 36),
                                clipBehavior: Clip.hardEdge,
                                height: Helper.height / 1.3,
                                decoration: BoxDecoration(
                                  // color: primaryColor,
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  Initializer
                                                      .serviceDetailedModel
                                                      .data!
                                                      .service!
                                                      .title!,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 28),
                                                ),
                                              ],
                                            ),
                                            // Helper.allowHeight(5),
                                            Selector<ProviderClass, String>(
                                              selector: (p0, p1) => p1.amount,
                                              builder:
                                                  (context, value, child) =>
                                                      value == "0"
                                                          ? const Text(
                                                              "Free",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .green,
                                                                  fontSize: 24),
                                                            )
                                                          : Text(
                                                              "$rupeeSymbol $value",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 24),
                                                            ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: Helper.width / 6,
                                          child: MaterialButton(
                                            onPressed: () =>
                                                // Helper.getApp(),
                                                Helper.pushNamed(
                                                    bookingaddress),
                                            // Helper.push(
                                            //     const BookingAddress()),
                                            elevation: 5.0,
                                            color: primaryColor,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 18, horizontal: 14),
                                            child: const Text("Use App",
                                                style: TextStyle(color: white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Helper.allowHeight(15),
                                    Expanded(
                                      child: Scrollbar(
                                        interactive: true,
                                        controller: yourScrollController,
                                        thumbVisibility: false,
                                        child: ListView(
                                          padding:
                                              const EdgeInsets.only(right: 26),
                                          controller: yourScrollController,
                                          children: [
                                            if (Initializer.serviceDetailedModel
                                                .data!.serviceTypes!.isNotEmpty)
                                              selectServiceView(),
                                            descriptionView(),
                                            if (Initializer
                                                    .serviceDetailedModel
                                                    .data!
                                                    .service!
                                                    .description!
                                                    .included!
                                                    .isNotEmpty ||
                                                Initializer
                                                    .serviceDetailedModel
                                                    .data!
                                                    .service!
                                                    .description!
                                                    .excluded!
                                                    .isNotEmpty)
                                              includedAndExcludedView(),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft, child: BackButton()),
                      Helper.allowHeight(30),
                      const Text("Something went wrong"),
                      Helper.allowHeight(30),
                    ],
                  )),
      ),
    );
  }

  Widget descriptionView() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Description",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: Helper.width / 4, child: const Divider()),
          Helper.allowHeight(10),
          Padding(
            padding: const EdgeInsets.only(right: 120),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Text(
                    Initializer
                        .serviceDetailedModel.data!.service!.description!.text!,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget includedAndExcludedView() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Helper.allowHeight(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (Initializer.serviceDetailedModel.data!.service!.description!
                  .included!.isNotEmpty)
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                            Initializer.serviceDetailedModel.data!.service!
                                .description!.included!.length,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.check,
                                          color: Colors.green,
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
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        )
                                      ],
                                    ),
                                    if (index != 8) Helper.allowHeight(5.0)
                                  ],
                                )),
                      )
                    ],
                  ),
                ),
              if (Initializer.serviceDetailedModel.data!.service!.description!
                  .included!.isNotEmpty)
                Helper.allowWidth(30),
              if (Initializer.serviceDetailedModel.data!.service!.description!
                  .excluded!.isNotEmpty)
                Expanded(
                  flex: 4,
                  child: Column(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.close_outlined,
                                          color: Colors.red,
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
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (index != 8) Helper.allowHeight(5.0)
                                  ],
                                )),
                      )
                    ],
                  ),
                )
            ],
          ),
        ],
      );

  Widget selectServiceView() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Select Services",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: Helper.width / 4, child: const Divider()),
          Helper.allowHeight(10),
          Container(
            margin: const EdgeInsets.only(left: 8, right: 18),
            width: Helper.width / 3,
            child: Wrap(
              runSpacing: 3.0,
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
                              builder: (context, value, child) => Radio<String>(
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
                            Helper.allowWidth(5),
                            Text(
                              Initializer.serviceDetailedModel.data!
                                  .serviceTypes![index].name!,
                            )
                          ],
                        ),
                      )),
            ),
          ),
          Helper.allowHeight(30),
        ],
      );

  continueBooking(
      {required BuildContext context, required String serviceName, serviceId}) {
    if (!Initializer.userModel.isLoggedIn!) {
      Helper.showAuthDialogue(context: context);
    } else {
      Helper.pushNamed("/bookingaddress?service=$serviceName&id=$serviceId");
    }
  }
}
