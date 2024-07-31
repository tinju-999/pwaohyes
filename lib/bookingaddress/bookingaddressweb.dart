import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/common/webfooter.dart';
import 'package:pwaohyes/common/webheader.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class BookingAddressWeb extends StatefulWidget {
  const BookingAddressWeb({super.key});

  @override
  State<BookingAddressWeb> createState() => _BookingAddressWebState();
}

class _BookingAddressWebState extends State<BookingAddressWeb> {
  @override
  void initState() {
    Helper.setTimings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const WebHeader(),
            Helper.allowHeight(20),
            const BookingAddressWebPage(),
            Helper.allowHeight(20),
            const WebFooter(),
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
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 18),
      color: white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Image.asset(
                  'assets/images/bg2.jpeg',
                  fit: BoxFit.fitHeight,
                )),
          ),
          Helper.allowWidth(30),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                      fontWeight: FontWeight.w600,
                                      fontSize: 28),
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
                        SizedBox(
                          width: Helper.width / 6,
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
                      ],
                    ),
                    Helper.allowHeight(15),
                    mainView(context),
                  ],
                )),
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
            padding: const EdgeInsets.only(right: 26),
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
                      width: Helper.width / 3,
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
                                                ?.selectServiceDateIndex(index),
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
                      width: Helper.width / 2,
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
                                              hour: _now.hour,
                                              minute: _now.minute),
                                        ).then((value) {
                                          if (value != null) {
                                            if (value.hour <= 20 &&
                                                value.hour >= 8) {
                                              Initializer.providerClass
                                                  ?.changeServiceTime(value);
                                            } else {
                                              showInvalidTime(context);
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
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: Helper.width / 4, child: const Divider()),
                  Helper.allowHeight(10),
                  const Padding(
                    padding: EdgeInsets.only(right: 120),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          child: Text(
                            "Interdum et malesuada fames ac ante ipsum primis in faucibus. Etiam eu nibh elementum, accumsan ona neque ac, aliquet nunc. In eu ipsum fringilla, accumsan purus vel, pellentesque risus. Vivamus vehicula nl purus at eros interdum, in dignissim nullaInterdum et malesuada fames ac ante ipsum primis in faucibus. Etiam eu nibh elementum, accumsan ona neque.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Helper.allowHeight(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
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
                          children: List.generate(
                              4,
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
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                          Helper.allowWidth(30),
                                          const Flexible(
                                            child: Text(
                                              "Reloaded 1 of 850 libraries in 832ms (compile: 72 ms, reload: 228 ms, reassemble: 306 ms).",
                                              style: TextStyle(fontSize: 14),
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
                  Helper.allowWidth(30),
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
                          children: List.generate(
                              3,
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
                                          const Flexible(
                                            child: Text(
                                              "Reloaded 1 of 850 libraries in 832ms (compile: 72 ms, reload: 228 ms, reassemble: 306 ms).",
                                              style: TextStyle(fontSize: 14),
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
          ),
        ),
      );

  void showInvalidTime(BuildContext context) => showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: const Text("Oops! Time Out of Bounds"),
            content: const Text(
                "Please choose a time between 8:00 AM and 8:00 PM to proceed with your booking"),
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
