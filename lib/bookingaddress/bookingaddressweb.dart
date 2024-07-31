import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pwaohyes/common/webfooter.dart';
import 'package:pwaohyes/common/webheader.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

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
                    Expanded(
                      child: Scrollbar(
                        interactive: true,
                        controller: yourScrollController,
                        thumbVisibility: false,
                        child: ListView(
                          padding: const EdgeInsets.only(right: 26),
                          controller: yourScrollController,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Time & Date For Service",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "Choose a day and time for the service your booking",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[400],
                                      fontWeight: FontWeight.w100),
                                ),
                                SizedBox(
                                    width: Helper.width / 4,
                                    child: const Divider()),
                                Helper.allowHeight(10),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 8, right: 18),
                                  width: Helper.width / 3,
                                  child: Wrap(
                                    spacing: 8.0,
                                    runSpacing: 3.0,
                                    children: [
                                      clickChip(
                                        context: context,
                                        title: "Today",
                                        active: true,
                                        needIcon: false,
                                      ),
                                      clickChip(
                                        context: context,
                                        title: "Tommorrow",
                                        active: false,
                                        needIcon: false,
                                      ),
                                      InkWell(
                                        onTap: () => showBoardDateTimePicker(
                                          context: context,
                                          initialDate: _now,
                                          minimumDate: _now,
                                          // maximumDate: DateTime(_now.year + 1),
                                          pickerType:
                                              DateTimePickerType.datetime,
                                          options: const BoardDateTimeOptions(
                                            activeTextColor: white,
                                            activeColor: primaryColor,
                                            weekend: BoardPickerWeekendOptions(
                                              saturdayColor: primaryColor,
                                            ),
                                          ),
                                        ),
                                        child: clickChip(
                                          context: context,
                                          title: "Select Date",
                                          active: false,
                                          needIcon: true,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Helper.allowHeight(10),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 8, right: 18),
                                  width: Helper.width / 2.5,
                                  child: Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: List.generate(
                                        Initializer
                                            .bookingTimeSuggestions.length,
                                        (index) => clickChip(
                                          context: context,
                                          title: Initializer
                                                  .bookingTimeSuggestions[index]
                                              ['label'],
                                          active: Initializer
                                                  .bookingTimeSuggestions[index]
                                              ['selected'],
                                          needIcon: false,
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
                            Helper.allowHeight(30),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Description",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                    width: Helper.width / 4,
                                    child: const Divider()),
                                Helper.allowHeight(10),
                                const Padding(
                                  padding: EdgeInsets.only(right: 120),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                        ),
                                                        Helper.allowWidth(30),
                                                        const Flexible(
                                                          child: Text(
                                                            "Reloaded 1 of 850 libraries in 832ms (compile: 72 ms, reload: 228 ms, reassemble: 306 ms).",
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    if (index != 8)
                                                      Helper.allowHeight(5.0)
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        const Icon(
                                                          Icons.close_outlined,
                                                          color: Colors.red,
                                                        ),
                                                        Helper.allowWidth(30),
                                                        const Flexible(
                                                          child: Text(
                                                            "Reloaded 1 of 850 libraries in 832ms (compile: 72 ms, reload: 228 ms, reassemble: 306 ms).",
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    if (index != 8)
                                                      Helper.allowHeight(5.0)
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
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
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
            const Icon(
              CupertinoIcons.chevron_down,
              color: primaryColor,
              size: 16,
            )
        ],
      ),
    );
