import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/bloc/bookingbloc.dart';
import 'package:pwaohyes/bookingaddress/addaddresspagemobilenew.dart';
import 'package:pwaohyes/common/footer.dart';
import 'package:pwaohyes/common/header.dart';
import 'package:pwaohyes/model/selectedservicedetailedmodel.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class BookingAddressMobileNew extends StatefulWidget {
  final String? serviceTitle;
  const BookingAddressMobileNew({super.key, this.serviceTitle});

  @override
  State<BookingAddressMobileNew> createState() =>
      _BookingAddressMobileNewState();
}

class _BookingAddressMobileNewState extends State<BookingAddressMobileNew> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    Helper.setDateAndTimings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BookingBloc, BookingState>(
        buildWhen: (previous, current) =>
            current is SelectedServiceDetailsFetched ||
            current is GettingSelectedServiceDetails ||
            current is SelectedServiceDetailsNotFetched ||
            current is GettingSelectedServiceDetailsError,
        listener: (context, state) => {},
        builder: (context, state) => state is SelectedServiceDetailsFetched
            ? SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Header(
                        removeBadge: false,
                        route: BookingAddressMobileNew(
                            serviceTitle: widget.serviceTitle),
                        scaffoldKey: scaffoldKey),
                    Helper.allowHeight(10),
                    Selector<ProviderClass, bool>(
                      selector: (p0, p1) => p1.isAddAddressVisible!,
                      builder: (context, value, child) => value
                          ? const AddAddressPageMobileNew()
                          : BookingAddressMobileNewPage(
                              serviceTitle: widget.serviceTitle),
                    ),
                    Helper.allowHeight(10),
                    const Footer(),
                  ],
                ),
              )
            : state is GettingSelectedServiceDetailsError
                ? const Center(
                    child: Text(
                      "Error loading content",
                    ),
                  )
                : Helper.shrink(),
      ),
    );
  }
}

class BookingAddressMobileNewPage extends StatefulWidget {
  final String? serviceTitle;
  const BookingAddressMobileNewPage({super.key, required this.serviceTitle});

  @override
  State<BookingAddressMobileNewPage> createState() =>
      _BookingAddressMobileNewPageState();
}

class _BookingAddressMobileNewPageState
    extends State<BookingAddressMobileNewPage> {
  final yourScrollController = ScrollController();
  var descriptionController = TextEditingController();
  final _now = DateTime.now();

  get onDateTimeChanged => null;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      color: white,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Schedule & Confirm Booking",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 22),
                      ),
                    ],
                  ),
                  // Helper.allowHeight(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        widget.serviceTitle!,
                        style: const TextStyle(fontSize: 14, color: grey),
                      ),
                    ],
                  ),
                ],
              ),
              Helper.allowHeight(10),
              mainView(context, descriptionController),
            ],
          )),

      //  Row(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Expanded(
      //       flex: 8,
      //       child: Container(
      //           padding:
      //               const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
      //           clipBehavior: Clip.hardEdge,
      //           height: Helper.height / 1.3,
      //           decoration: BoxDecoration(
      //             // color: primaryColor,
      //             borderRadius: BorderRadius.circular(18.0),
      //           ),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisSize: MainAxisSize.max,
      //             children: [
      //               Column(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: [
      //                   const Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     mainAxisSize: MainAxisSize.max,
      //                     children: [
      //                       Text(
      //                         "Schedule & Confirm Booking",
      //                         style: TextStyle(
      //                             fontWeight: FontWeight.w600, fontSize: 28),
      //                       ),
      //                     ],
      //                   ),
      //                   // Helper.allowHeight(5),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.start,
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     mainAxisSize: MainAxisSize.max,
      //                     children: [
      //                       Text(
      //                         widget.serviceTitle!,
      //                         style: const TextStyle(fontSize: 16, color: grey),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //               Helper.allowHeight(15),
      //               mainView(context, descriptionController),
      //             ],
      //           )),
      //     ),
      //     Helper.allowWidth(10),
      //     Expanded(
      //       flex: 6,
      //       child: Column(
      //         children: [
      //           Container(
      //             decoration: BoxDecoration(
      //                 color: Colors.grey[100],
      //                 borderRadius: BorderRadius.circular(8.0)),
      //             padding:
      //                 const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 InkWell(
      //                   // onTap: () async => await launchUrl(
      //                   //     Uri.parse('https://ohyesworld.com/')),
      //                   child: Container(
      //                     padding: const EdgeInsets.symmetric(
      //                         horizontal: 16, vertical: 8),
      //                     decoration: BoxDecoration(
      //                         color: white,
      //                         border: Border.all(color: primaryColor),
      //                         borderRadius: BorderRadius.circular(
      //                           8.0,
      //                         )),
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       mainAxisSize: MainAxisSize.min,
      //                       children: [
      //                         const Icon(
      //                           Icons.discount_rounded,
      //                           color: primaryColor,
      //                           size: 16,
      //                         ),
      //                         Helper.allowWidth(10),
      //                         const Text(
      //                           "Coupon & Promo code",
      //                           style: TextStyle(
      //                               fontSize: 12, color: primaryColor),
      //                         )
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //                 Helper.allowHeight(10),
      //                 const Text(
      //                   "Payment Summary",
      //                   style: TextStyle(
      //                       fontWeight: FontWeight.w600, fontSize: 22),
      //                 ),
      //                 Helper.allowHeight(10),
      //                 amountView("Total Amount", getPrice("Free")),
      //                 amountView("Membership Offer", "Rs. 0"),
      //                 amountView("Coupon & Promo Code", "Rs. 0"),
      //                 amountView("Platform Fee", "Rs. 0"),
      //                 Helper.allowHeight(20),
      //                 const Divider(),
      //                 amountView("Total", getPrice("Free")),
      //                 // Helper.allowHeight(30),

      //                 // const Text(
      //                 //   "You have Saved ₹ 298 on this bill",
      //                 //   style: TextStyle(color: primaryColor),
      //                 // )
      //               ],
      //             ),
      //           ),
      //           Helper.allowHeight(10),
      //           Container(
      //             decoration: BoxDecoration(
      //                 color: Colors.grey[100],
      //                 borderRadius: BorderRadius.circular(8.0)),
      //             padding:
      //                 const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
      //             child: const Text(
      //                 "Note If you cancelled within 1 hour of placing your service a 100% refund will be issued. No refund for cancellation made after 1 hour."),
      //           )
      //         ],
      //       ),
      //       // Container(
      //       //     clipBehavior: Clip.hardEdge,
      //       //     decoration: BoxDecoration(
      //       //       color: primaryColor,
      //       //       borderRadius: BorderRadius.circular(18.0),
      //       //     ),
      //       //     child: Image.asset(
      //       //       'assets/images/bg2.jpeg',
      //       //       fit: BoxFit.fitHeight,
      //       //     )),
      //     ),

      //   ],
      // ),
    );
  }

  Widget mainView(
          BuildContext context, TextEditingController descriptionController) =>
      Expanded(
        child: Scrollbar(
          interactive: true,
          controller: yourScrollController,
          thumbVisibility: false,
          child: ListView(
            controller: yourScrollController,
            children: [
              Consumer<ProviderClass>(
                builder: (context, value, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Time & Date For Service",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Choose a day and time for the service your booking",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w100),
                    ),
                    Helper.allowHeight(10),
                    Container(
                      margin: const EdgeInsets.only(left: 4, right: 12),
                      width: Helper.width,
                      child: Wrap(
                        spacing: 4.0,
                        runSpacing: 4.0,
                        children: List.generate(
                            Initializer.bookingDateSuggestions.length,
                            (index) => Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    index !=
                                            Initializer.bookingDateSuggestions
                                                    .length -
                                                1
                                        ? InkWell(
                                            onTap: () => Initializer
                                                .providerClass!
                                                .selectServiceDateIndex(
                                                    index,
                                                    Initializer
                                                            .bookingDateSuggestions[
                                                        index]),
                                            child: clickChip(
                                              context: context,
                                              title: Initializer
                                                  .bookingDateSuggestions[index]
                                                  .label,
                                              active: Initializer
                                                  .bookingDateSuggestions[index]
                                                  .isSelected,
                                              needIcon: false,
                                            ))
                                        : InkWell(
                                            onTap: () => showDatePicker(
                                              context: context,
                                              initialDate: _now,
                                              firstDate: _now,
                                              builder: (context, child) =>
                                                  Theme(
                                                      data: ThemeData.light()
                                                          .copyWith(
                                                        primaryColor:
                                                            primaryColor,
                                                        colorScheme: ColorScheme.light(
                                                            primary:
                                                                primaryColor,
                                                            secondary: const Color(
                                                                    0xffF46523)
                                                                .withOpacity(
                                                                    0.1)),
                                                      ),
                                                      child: child!),
                                              lastDate: DateTime(_now.year + 2),
                                            ).then((value) {
                                              // value
                                              if (value != null) {
                                                Initializer.providerClass!
                                                    .selectServiceDate(value);
                                              }
                                            }),
                                            child: clickChip(
                                              context: context,
                                              title: Initializer
                                                      .bookingDateSuggestions[
                                                          index]
                                                      .isSelected!
                                                  ? Helper.setDateFormat(
                                                      dateTime: Initializer
                                                          .bookingDateSuggestions[
                                                              index]
                                                          .date,
                                                      format: "dd/MM/yyyy")
                                                  : "Select Date",
                                              active: Initializer
                                                  .bookingDateSuggestions[index]
                                                  .isSelected,
                                              needIcon: true,
                                            ),
                                          )
                                  ],
                                )),
                      ),
                    ),
                    Helper.allowHeight(10),
                    Container(
                      margin: const EdgeInsets.only(left: 4, right: 12),
                      width: Helper.width / 1.5,
                      child: Wrap(
                          spacing: 4.0,
                          runSpacing: 8.0,
                          children: List.generate(
                            Initializer.bookingTimeSuggestions.length,
                            (index) => Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                index !=
                                        Initializer
                                                .bookingTimeSuggestions.length -
                                            1
                                    ? InkWell(
                                        onTap: () => Initializer.providerClass
                                            ?.selectServiceTimeIndex(index),
                                        child: clickChip(
                                          context: context,
                                          title: Initializer
                                              .bookingTimeSuggestions[index]
                                              .label,
                                          active: Initializer
                                              .bookingTimeSuggestions[index]
                                              .isSelected,
                                          needIcon: false,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () => showTimePicker(
                                          context: context,
                                          initialEntryMode:
                                              TimePickerEntryMode.dial,
                                          builder: (context, child) => Theme(
                                              data: ThemeData.light().copyWith(
                                                primaryColor: primaryColor,
                                                colorScheme: ColorScheme.light(
                                                    primary: primaryColor,
                                                    onSecondary: primaryColor,
                                                    secondary:
                                                        const Color(0xffF46523)
                                                            .withOpacity(0.1)),
                                              ),
                                              child: child!),
                                          initialTime: TimeOfDay(
                                            hour: DateTime.now().hour,
                                            minute: DateTime.now().minute,
                                          ),
                                        ).then((value) {
                                          Initializer.now = DateTime.now();
                                          if (value != null) {
                                            if (value.hour <= 20 &&
                                                value.hour >= 8) {
                                              TimeOfDay adjustedTime =
                                                  adjustTime(
                                                      Initializer.now, value);
                                              Initializer.providerClass!
                                                  .changeServiceTime(
                                                      adjustedTime);
                                            } else {
                                              showInvalidTime(
                                                  "Oops! Time Out of Bounds",
                                                  "Please choose a time between 8:00 AM and 8:00 PM to proceed with your booking");
                                            }
                                          }
                                        }),
                                        child: clickChip(
                                          context: context,
                                          title: Initializer
                                              .bookingTimeSuggestions[index]
                                              .label,
                                          active: Initializer
                                              .bookingTimeSuggestions[index]
                                              .isSelected,
                                          needIcon: true,
                                        ),
                                      )
                              ],
                            ),
                          )
                          // [

                          // InkWell(
                          //   onTap: () => showBoardDateTimePicker(
                          //     context: context,
                          //     initialDate: _now,
                          //     minimumDate: _now,
                          //     // maximumDate: DateTime(_now.year + 1),
                          //     pickerType:
                          //         DateTimePickerType.datetime,
                          //     options: const BoardDateTimeOptions(
                          //       activeTextColor: white,
                          //       activeColor: primaryColor,
                          //       weekend: BoardPickerWeekendOptions(
                          //         saturdayColor: primaryColor,
                          //       ),
                          //     ),
                          //   ),
                          //   child: clickChip(
                          //     context: context,
                          //     title: "Select Time",
                          //     active: false,
                          //     needIcon: true,
                          //   ),
                          // )
                          // ],
                          ),
                    ),
                    if (Initializer.bookingDateSuggestions.first.isSelected! &&
                        Initializer.selectedServiceDetailsModel.data!
                            .servicePartners!.isNotEmpty)
                      showTechnitionView()
                  ],
                ),
              ),
              Helper.allowHeight(15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Service Address",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  Helper.allowHeight(5),
                  if (Initializer.selectedServiceDetailsModel.data!.address !=
                      null)
                    addressCustomfield(
                      context,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${Initializer.selectedServiceDetailsModel.data!.address!.name!}  - ${Initializer.selectedServiceDetailsModel.data!.address!.contactNumber!}",
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "${Initializer.selectedServiceDetailsModel.data!.address!.addressLine1!}, ${Initializer.selectedServiceDetailsModel.data!.address!.city!}",
                                  overflow: TextOverflow.visible,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Helper.allowWidth(15),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 18,
                          )
                        ],
                      ),
                    ),
                  if (Initializer.selectedServiceDetailsModel.data!.address !=
                      null)
                    Helper.allowHeight(15),
                  if (Initializer.selectedServiceDetailsModel.data!.address !=
                      null)
                    Padding(
                      padding: const EdgeInsets.only(right: 120),
                      child: InkWell(
                        onTap: () => showAllAddressView(),
                        child: addressCustomfield(
                          context,
                          const Text(
                            'CHANGE ADDRESS',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: primaryColor, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  Helper.allowHeight(15),
                  Padding(
                    padding: const EdgeInsets.only(right: 120),
                    child: InkWell(
                      onTap: () =>
                          Initializer.providerClass?.addAddressVisibility(true),
                      child: addressCustomfield(
                        context,
                        const Text(
                          'ADD A NEW ADDRESS',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: primaryColor, fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Helper.allowHeight(20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Add Description",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  Helper.allowHeight(10),
                  Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: TextFormField(
                        maxLines: 6,
                        controller: descriptionController,
                        maxLength: 500,
                        decoration: InputDecoration(
                          hintText: "Add description about work...",
                          hintStyle: const TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      )),
                ],
              ),
              // Helper.allowHeight(10),
              Row(
                children: [
                  Selector<ProviderClass, bool>(
                    selector: (p0, p1) => p1.agreed,
                    builder: (context, value, child) => Checkbox(
                      value: value,
                      onChanged: (value) =>
                          Initializer.providerClass?.setAgreement(value),
                      activeColor: primaryColor,
                    ),
                  ),
                  // Helper.allowWidth(10),
                  InkWell(
                    onTap: () => Helper.openPage(
                        'https://ohyesworld.com/terms-conditions/'),
                    child: const Text(
                      "Agree the terms and conditions",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 12,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              Helper.allowHeight(20),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: Helper.width / 2,
                  child: MaterialButton(
                    onPressed: () {
                      if (Initializer
                              .bookingDateSuggestions.first.isSelected! &&
                          Initializer
                              .providerClass!.selectedServicePartner.isEmpty) {
                        Helper.showSnack("Please select a service partner");
                      } else {
                        if (Initializer.providerClass!.agreed) {
                          context.read<BookingBloc>().add(ConfirmBooking(
                                serviceId: Initializer.selectedServiceId,
                                description: descriptionController.text,
                                selectedServiceDate:
                                    Initializer.selectedServiceDate,
                                selectedServiceTime:
                                    Initializer.selectedServiceTime,
                              ));
                        } else {
                          Helper.showSnack(
                              "Please agree terms and conditions ");
                        }
                      }
                    },
                    elevation: 5.0,
                    color: primaryColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 14),
                    child: const Text("Confirm Booking",
                        style: TextStyle(color: white)),
                  ),
                ),
              ),
              Helper.allowHeight(20),
            ],
          ),
        ),
      );

  void showInvalidTime(String title, String content) => showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              CupertinoButton(
                child: const Text(
                  "Ok",
                  style: TextStyle(color: primaryColor),
                ),
                onPressed: () => Helper.pop(),
              )
            ],
          ));

  TimeOfDay adjustTime(DateTime currentTime, TimeOfDay selectedTime) {
    int minute = selectedTime.minute;
    int hour = selectedTime.hour;

    // Round to the nearest 30-minute interval
    if (minute > 0 && minute <= 30) {
      minute = 30;
    } else if (minute > 30) {
      minute = 0;
      hour = (hour + 1) % 24;
    }

    TimeOfDay adjustedTime = TimeOfDay(hour: hour, minute: minute);

    // Ensure the adjusted time is not before the current time
    while (adjustedTime.hour < currentTime.hour ||
        (adjustedTime.hour == currentTime.hour &&
            adjustedTime.minute <= currentTime.minute)) {
      minute = adjustedTime.minute;
      hour = adjustedTime.hour;

      if (minute == 0) {
        minute = 30;
      } else {
        minute = 0;
        hour = (hour + 1) % 24;
      }

      adjustedTime = TimeOfDay(hour: hour, minute: minute);
    }

    // Ensure the time is between 8:00 AM and 8:00 PM
    if (adjustedTime.hour < 8) {
      adjustedTime = const TimeOfDay(hour: 8, minute: 0);
    } else if (adjustedTime.hour >= 20 && adjustedTime.minute > 0) {
      adjustedTime = const TimeOfDay(hour: 20, minute: 0);
    }

    return adjustedTime;
  }

  Widget addressCustomfield(BuildContext context, Widget child) => Container(
        width: Helper.width,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.4))),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: child,
      );

  amountView(String title, String value) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Helper.allowHeight(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(title),
              Text(value),
            ],
          ),
        ],
      );

  Widget addAddressView(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 36),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded(
            //   flex: 5,
            //   child: Container(
            //     height: Helper.height / 1.5,
            //     decoration: BoxDecoration(
            //         color: Colors.grey,
            //         borderRadius: BorderRadius.circular(8.0)),
            //     child: GoogleMap(
            //       initialCameraPosition:
            //           const CameraPosition(target: LatLng(10.1926, 76.3869)),
            //       onMapCreated: (controller) {},
            //     ),
            //   ),
            // ),
            Helper.allowWidth(20.0),
            Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => Helper.pop(),
                      child: const Text(
                        "Add New Address",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                    ),
                    Helper.allowHeight(20),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Helper.allowHeight(10),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "House/Flat Number",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Helper.allowHeight(10),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Landmark",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      );

  String getPrice(String content) {
    if (int.tryParse(Initializer.providerClass!.selectedServiceAmount) != 0) {
      return "Rs. ${Initializer.providerClass!.selectedServiceAmount}";
    } else {
      return content;
    }
  }

  showAllAddressView() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextButton(
                  onPressed: () {
                    Helper.pop();
                    Initializer.providerClass?.addAddressVisibility(true);
                  },
                  child: const Text("Add New Address")),
            )
          ],
          content: BlocBuilder<BookingBloc, BookingState>(
            buildWhen: (previous, current) =>
                current is GettingUserAddress ||
                current is UserAddressFetched ||
                current is AddressChanged ||
                current is UserAddressNotFetched ||
                current is GettingUserAddressError,
            builder: (context, state) => state is UserAddressFetched ||
                    Initializer.userAllAddressModel.data!.isNotEmpty
                ? Container(
                    width: Helper.width / 4,
                    color: white,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: Initializer.userAllAddressModel.data!.length,
                      separatorBuilder: (context, index) =>
                          Helper.allowHeight(15),
                      itemBuilder: (context, index) => Container(
                        width: Helper.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 18),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 0.2,
                                spreadRadius: 0.2,
                              )
                            ],
                            color: white,
                            border: Border.all(
                                color: Initializer.userAllAddressModel
                                        .data![index].isSelected!
                                    ? primaryColor
                                    : grey),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Helper.showLog(
                                      "the selected add id -----> ${Initializer.userAllAddressModel.data![index].sId}");
                                  if (!Initializer.userAllAddressModel
                                      .data![index].isSelected!) {
                                    context.read<BookingBloc>().add(
                                        ChangeAddress(
                                            id: Initializer.userAllAddressModel
                                                .data![index].sId));
                                  } else {
                                    Helper.showSnack("Address alredy selected");
                                  }
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${Initializer.userAllAddressModel.data![index].name!}  - ${Initializer.userAllAddressModel.data![index].contactNumber!}",
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      "${Initializer.userAllAddressModel.data![index].addressLine1!}, ${Initializer.userAllAddressModel.data![index].city!}",
                                      overflow: TextOverflow.visible,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Helper.allowWidth(15),
                            if (!Initializer
                                .userAllAddressModel.data![index].isSelected!)
                              InkWell(
                                  onTap: () => context.read<BookingBloc>().add(
                                      DeleteAddress(
                                          id: Initializer.userAllAddressModel
                                              .data![index].sId)),
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.red.withOpacity(0.8)),
                                  )),
                          ],
                        ),
                      ),
                    ))
                : const Text("Error Loading User Addresses"),
          ),
        ),
      );

  showTechnitionView() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Helper.allowHeight(20),
          const Text(
            "Select Service Partner",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Text(
            "Choose your preferred service provider",
            style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontWeight: FontWeight.w100),
          ),
          Helper.allowHeight(10),
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Selector<ProviderClass, bool>(
              selector: (p0, p1) => p1.isServiceParnterSelected,
              builder: (context, value, child) => value &&
                      Initializer
                          .providerClass!.selectedServicePartner.isNotEmpty
                  ? partnerView(
                      partner: Initializer
                          .selectedServiceDetailsModel.data!.servicePartners!
                          .where(
                            (e) =>
                                e.sId ==
                                Initializer
                                    .providerClass!.selectedServicePartner,
                          )
                          .first,
                      closing: true)
                  : InkWell(
                      onTap: () => showServicePartner(),
                      child: addressCustomfield(
                        context,
                        const Text(
                          'SELECT SERVICE PARTNER',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: primaryColor, fontSize: 14),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      );

  showServicePartner() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            actions: [
              Selector<ProviderClass, String>(
                selector: (p0, p1) => p1.selectedServicePartner,
                builder: (context, value, child) => Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextButton(
                    onPressed: () {
                      if (value.isNotEmpty) {
                        Helper.pop();
                        Initializer.providerClass!.confirmServicePartner(true);
                      }
                    },
                    child: Text(
                      "Confirm Technician",
                      style: TextStyle(
                          color: value.isNotEmpty ? primaryColor : Colors.grey),
                    ),
                  ),
                ),
              )
            ],
            content: Selector<ProviderClass, String>(
              selector: (p0, p1) => p1.selectedServicePartner,
              builder: (context, value, child) => Container(
                  width: Helper.width,
                  color: white,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: Initializer.selectedServiceDetailsModel.data!
                        .servicePartners!.length,
                    separatorBuilder: (context, index) =>
                        Helper.allowHeight(15),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        if (!Initializer.selectedServiceDetailsModel.data!
                            .servicePartners![index].isSelected!) {
                          Initializer.providerClass!.changeServicePartner(
                              Initializer.selectedServiceDetailsModel.data!
                                  .servicePartners![index].sId);
                        }
                      },
                      child: partnerView(
                        partner: Initializer.selectedServiceDetailsModel.data!
                            .servicePartners![index],
                        closing: false,
                      ),
                    ),
                  )),
            )),
      );

  Widget partnerView(
          {required ServicePartners partner, required bool closing}) =>
      Container(
        width: Helper.width,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
                color: partner.isSelected! ? primaryColor : Colors.grey,
                width: partner.isSelected! ? 2.0 : 1.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey)),
              child: partner.profilePicture != null
                  ? CachedNetworkImage(
                      imageUrl: partner.profilePicture!,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image_not_supported_rounded))
                  : const Icon(Icons.image_not_supported_rounded),
            ),
            Helper.allowWidth(15),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          Helper.toTitleCase(partner.userName!),
                          style: const TextStyle(fontSize: 16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (closing)
                        InkWell(
                            onTap: () => Initializer.providerClass!
                                .confirmServicePartner(false),
                            child: const Icon(CupertinoIcons.clear))
                    ],
                  ),
                  Helper.allowHeight(5),
                  Row(
                    children: [
                      Helper.checkAndGetPrice(partner),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              partner.rating!.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 12,
                                color: white,
                              ),
                            ),
                            if (partner.rating! > 0) Helper.allowWidth(5),
                            if (partner.rating! > 0)
                              AnimatedRatingStars(
                                  initialRating: partner.rating!,
                                  starSize: 3,
                                  onChanged: (_) {},
                                  filledColor: white,
                                  emptyColor: Colors.grey,
                                  customFilledIcon: CupertinoIcons.star_fill,
                                  customHalfFilledIcon:
                                      CupertinoIcons.star_lefthalf_fill,
                                  customEmptyIcon: CupertinoIcons.star)
                          ],
                        ),
                      ),
                    ],
                  ),
                  Helper.allowHeight(5),
                  Text(
                    "${partner.paidBookingCount} Completed Services",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Helper.allowHeight(2.5),
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.location_fill,
                        color: Colors.blue,
                        size: 14,
                      ),
                      Helper.allowWidth(5),
                      Helper.convertToKm(partner),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
}

clickChip({
  required BuildContext? context,
  required String? title,
  required bool? active,
  required bool? needIcon,
}) =>
    Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.0),
          color: active! ? primaryColor : white,
          border: Border.all(color: active ? white : primaryColor)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title!,
            style: TextStyle(
              fontSize: 12,
              color: active ? white : primaryColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          if (needIcon!) Helper.allowWidth(5.0),
          if (needIcon)
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: active ? white : primaryColor,
              size: 14,
            )
        ],
      ),
    );
