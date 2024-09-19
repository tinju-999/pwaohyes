import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/bookingaddress/bookingaddaddresswebpart2.dart';
import 'package:pwaohyes/common/footer.dart';
import 'package:pwaohyes/common/header.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class BookingAddressWeb extends StatefulWidget {
  const BookingAddressWeb({super.key});

  @override
  State<BookingAddressWeb> createState() => _BookingAddressWebState();
}

class _BookingAddressWebState extends State<BookingAddressWeb> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    Helper.setDateAndTimings();
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
                route: const BookingAddressWeb(),
                scaffoldKey: scaffoldKey),
            Helper.allowHeight(10),
            Selector<ProviderClass, bool>(
              selector: (p0, p1) => p1.isAddAddressVisible!,
              builder: (context, value, child) => value
                  ? const AddAddressPageWeb()
                  : const BookingAddressWebPage(),
            ),
            Helper.allowHeight(10),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class BookingAddressWebPage extends StatefulWidget {
  const BookingAddressWebPage({super.key});

  @override
  State<BookingAddressWebPage> createState() => _BookingAddressWebPageState();
}

class _BookingAddressWebPageState extends State<BookingAddressWebPage> {
  final yourScrollController = ScrollController();
  final _now = DateTime.now();

  get onDateTimeChanged => null;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
      color: white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 8,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
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
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Schedule & Confirm Booking",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 28),
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
                              "Lights Service & Repair",
                              style: TextStyle(fontSize: 16, color: grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Helper.allowHeight(15),
                    mainView(context),
                  ],
                )),
          ),
          Helper.allowWidth(10),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.0)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        // onTap: () async => await launchUrl(
                        //     Uri.parse('https://ohyesworld.com/')),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                              color: white,
                              border: Border.all(color: primaryColor),
                              borderRadius: BorderRadius.circular(
                                8.0,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.discount_rounded,
                                color: primaryColor,
                                size: 16,
                              ),
                              Helper.allowWidth(10),
                              const Text(
                                "Coupon & Promo code",
                                style: TextStyle(
                                    fontSize: 12, color: primaryColor),
                              )
                            ],
                          ),
                        ),
                      ),
                      Helper.allowHeight(10),
                      const Text(
                        "Payment Summary",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 22),
                      ),
                      Helper.allowHeight(10),
                      amountView("Total Amount", "- Rs 199"),
                      amountView("Membership Offer", "- Rs 99"),
                      amountView("Coupon & Promo Code", "Rs 39"),
                      amountView("Platform Fee", "Rs 39"),
                      Helper.allowHeight(20),
                      const Divider(),
                      amountView("Total", "Rs 901"),
                      Helper.allowHeight(30),
                      const Text(
                        "You have Saved ₹ 298 on this bill",
                        style: TextStyle(color: primaryColor),
                      )
                    ],
                  ),
                ),
                Helper.allowHeight(10),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8.0)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
                  child: const Text(
                      "Note If you cancelled within 1 hour of placing your service a 100% refund will be issued. No refund for cancellation made after 1 hour."),
                )
              ],
            ),
            // Container(
            //     clipBehavior: Clip.hardEdge,
            //     decoration: BoxDecoration(
            //       color: primaryColor,
            //       borderRadius: BorderRadius.circular(18.0),
            //     ),
            //     child: Image.asset(
            //       'assets/images/bg2.jpeg',
            //       fit: BoxFit.fitHeight,
            //     )),
          ),
        ],
      ),
    );
  }

  Widget mainView(BuildContext context) => Expanded(
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
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Choose a day and time for the service your booking",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w100),
                    ),
                    SizedBox(width: Helper.width / 4, child: const Divider()),
                    Helper.allowHeight(10),
                    Container(
                      margin: const EdgeInsets.only(left: 8, right: 18),
                      width: Helper.width / 2.5,
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
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
                                                .providerClass
                                                ?.selectServiceDateIndex(
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
                                                Initializer.providerClass
                                                    ?.selectServiceDate(value);
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
                      margin: const EdgeInsets.only(left: 8, right: 18),
                      width: Helper.width / 1.5,
                      child: Wrap(
                          spacing: 8.0,
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
                  ],
                ),
              ),
              Helper.allowHeight(30),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Service Address",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(width: Helper.width / 4, child: const Divider()),
                  Helper.allowHeight(10),
                  Padding(
                    padding: const EdgeInsets.only(right: 120),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () => Initializer.providerClass
                              ?.addAddressVisibility(true),
                          child: addressCustomfield(
                            context,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const Icon(CupertinoIcons.add,
                                    color: primaryColor),
                                Helper.allowWidth(15),
                                const Text(
                                  'ADD A NEW ADDRESS',
                                  style: TextStyle(
                                    color: primaryColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Helper.allowHeight(15.0),
                        // addressCustomfield(
                        //   context,
                        //   Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         mainAxisSize: MainAxisSize.max,
                        //         children: [
                        //           Container(
                        //             padding: const EdgeInsets.symmetric(
                        //                 vertical: 4, horizontal: 14),
                        //             decoration: BoxDecoration(
                        //                 color: Colors.grey[200],
                        //                 borderRadius:
                        //                     BorderRadius.circular(4.0)),
                        //             child: const Text(
                        //               "Home",
                        //               style: TextStyle(fontSize: 10),
                        //             ),
                        //           ),
                        //           PopupMenuButton(
                        //             padding: EdgeInsets.zero,
                        //             iconSize: 18,
                        //             itemBuilder: (context) =>
                        //                 <PopupMenuEntry<String>>[
                        //               const PopupMenuItem<String>(
                        //                 value: 'Option 1',
                        //                 child: Text('Edit'),
                        //               ),
                        //               const PopupMenuItem<String>(
                        //                 value: 'Option 2',
                        //                 child: Text('Delete'),
                        //               ),
                        //             ],
                        //           )
                        //         ],
                        //       ),
                        //       // Helper.allowHeight(5.0),
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           const Text("Aju Alex"),
                        //           Helper.allowWidth(10.0),
                        //           const Text("8129322316")
                        //         ],
                        //       ),
                        //       Helper.allowHeight(0.5),
                        //       const Text(
                        //           "Amal Jyothi College of Engineering, Koovappally, Kottayam, Kerala - 686518"),
                        //       //
                        //     ],
                        //   ),
                        // ),
                        // Helper.allowHeight(10.0),

                        // Flexible(
                        //   child: Text(
                        //     "Interdum et malesuada fames ac ante ipsum primis in faucibus. Etiam eu nibh elementum, accumsan ona neque ac, aliquet nunc. In eu ipsum fringilla, accumsan purus vel, pellentesque risus. Vivamus vehicula nl purus at eros interdum, in dignissim nullaInterdum et malesuada fames ac ante ipsum primis in faucibus. Etiam eu nibh elementum, accumsan ona neque.",
                        //     textAlign: TextAlign.justify,
                        //     style: TextStyle(fontSize: 14),
                        //   ),
                        // ),
                      ],
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
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(width: Helper.width / 4, child: const Divider()),
                  Helper.allowHeight(10),
                  Padding(
                      padding: const EdgeInsets.only(right: 120),
                      child: TextFormField(
                        maxLines: 6,
                        maxLength: 500,
                        decoration: InputDecoration(
                          hintText: "Add description about work...",
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
                  Checkbox(
                    value: true,
                    onChanged: (_) {},
                    activeColor: primaryColor,
                  ),
                  Helper.allowWidth(15),
                  const Text("Agree the terms and conditions"),
                ],
              ),
              Helper.allowHeight(20),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: Helper.width / 4,
                  child: MaterialButton(
                    onPressed: () => {},
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

  void showInvalidTime(String title, String content) =>
      showCupertinoDialog(
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
        decoration: BoxDecoration(
            // color: black,
            border: Border.all(color: Colors.grey.withOpacity(0.4))),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
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
            Expanded(
              flex: 5,
              child: Container(
                height: Helper.height / 1.5,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8.0)),
                child: GoogleMap(
                  initialCameraPosition:
                      const CameraPosition(target: LatLng(10.1926, 76.3869)),
                  onMapCreated: (controller) {},
                ),
              ),
            ),
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
}

clickChip({
  required BuildContext? context,
  required String? title,
  required bool? active,
  required bool? needIcon,
}) =>
    Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 22),
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
