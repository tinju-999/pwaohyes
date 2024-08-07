import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/bookingaddress/bookingaddresshome.dart';
import 'package:pwaohyes/common/webfooter.dart';
import 'package:pwaohyes/common/webheader.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class BookingWeb extends StatefulWidget {
  const BookingWeb({super.key});

  @override
  State<BookingWeb> createState() => _BookingWebState();
}

class _BookingWebState extends State<BookingWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const WebHeader(),
            Helper.allowHeight(20),
            const BookingWebPage(),
            Helper.allowHeight(20),
            const WebFooter(),
          ],
        ),
      ),
    );
  }
}

class BookingWebPage extends StatefulWidget {
  const BookingWebPage({super.key});

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
      child: Column(
        children: [
          const Align(alignment: Alignment.centerLeft, child: BackButton()),
          Helper.allowHeight(30),
          Row(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Text(
                                      "Light Service & Repair",
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
                                    const Text(
                                      "Rs, 1199",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Helper.allowWidth(15),
                                    const Text(
                                      "1.3 Reviews",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: Helper.width / 6,
                              child: MaterialButton(
                                onPressed: () =>
                                    Helper.push(const BookingAddress()),
                                elevation: 5.0,
                                color: primaryColor,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 14),
                                child: const Text("Book Now",
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
                                      "Select Services",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                        width: Helper.width / 4,
                                        child: const Divider()),
                                    Helper.allowHeight(10),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 8, right: 18),
                                      width: Helper.width / 3,
                                      child: Wrap(
                                        runSpacing: 3.0,
                                        children: List.generate(
                                            Initializer.chooseService.length,
                                            (index) => Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 18),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Selector<ProviderClass,
                                                          String>(
                                                        selector: (p0, p1) => p1
                                                            .selectedServiceId,
                                                        builder: (context,
                                                                value, child) =>
                                                            Radio<String>(
                                                          value: Initializer
                                                                  .chooseService[
                                                              index]['value'],
                                                          groupValue: value,
                                                          activeColor:
                                                              primaryColor,
                                                          focusColor: grey,
                                                          // title: const Text("Title"),
                                                          onChanged: (value) =>
                                                              Initializer
                                                                  .providerClass!
                                                                  .chooseService(
                                                                      value!,
                                                                      index),
                                                        ),
                                                      ),
                                                      Helper.allowWidth(5),
                                                      const Text(
                                                          "Installation & Repair")
                                                    ],
                                                  ),
                                                )),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                            Helper.allowWidth(
                                                                30),
                                                            const Flexible(
                                                              child: Text(
                                                                "Reloaded 1 of 850 libraries in 832ms (compile: 72 ms, reload: 228 ms, reassemble: 306 ms).",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        if (index != 8)
                                                          Helper.allowHeight(
                                                              5.0)
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                              Icons
                                                                  .close_outlined,
                                                              color: Colors.red,
                                                            ),
                                                            Helper.allowWidth(
                                                                30),
                                                            const Flexible(
                                                              child: Text(
                                                                "Reloaded 1 of 850 libraries in 832ms (compile: 72 ms, reload: 228 ms, reassemble: 306 ms).",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        if (index != 8)
                                                          Helper.allowHeight(
                                                              5.0)
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
        ],
      ),
    );
  }
}
