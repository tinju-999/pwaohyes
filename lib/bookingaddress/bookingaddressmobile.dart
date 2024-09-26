import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/common/footer.dart';
import 'package:pwaohyes/common/header.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class BookingAddressMobile extends StatefulWidget {
  const BookingAddressMobile({super.key});

  @override
  State<BookingAddressMobile> createState() => _BookingAddressMobileState();
}

class _BookingAddressMobileState extends State<BookingAddressMobile> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bookingButton(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Header(
                  removeBadge: false,
                  route: const BookingAddressMobile(),
                  scaffoldKey: scaffoldKey),
              Helper.allowHeight(10),
              const BookingAddressMobilePage(),
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
        margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        width: Helper.width / 2,
        child: MaterialButton(
          onPressed: () => {},
          elevation: 5.0,
          color: primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          child: const Text("Book Now", style: TextStyle(color: white)),
        ),
      );
}

class BookingAddressMobilePage extends StatelessWidget {
  const BookingAddressMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final yourScrollController = ScrollController();
    return Container(
        width: Helper.width,
        color: white,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: primaryColor),
              width: Helper.width,
              height: 140,
              constraints: BoxConstraints(maxHeight: Helper.height / 6.5),
            ),
            Helper.allowHeight(15),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Light Service & Repair",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                Helper.allowHeight(2.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      "Rs 1199",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Helper.allowWidth(10),
                    const Text(
                      "1.3 Reviews",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),

            //servicesview
            Helper.allowHeight(15),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Select Services",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: Helper.width / 2, child: const Divider()),
                Helper.allowHeight(10),
                Wrap(
                  runSpacing: 1.0,
                  children: List.generate(
                      Initializer.chooseService.length,
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
                                      value: Initializer.chooseService[index]
                                          ['value'],
                                      groupValue: value,
                                      activeColor: primaryColor,
                                      focusColor: grey,
                                      // title: const Text("Title"),
                                      onChanged: (value) => Initializer
                                          .providerClass!
                                          .chooseService(value!, index),
                                    ),
                                  ),
                                ),
                                Helper.allowWidth(5),
                                const Text(
                                  "Repair",
                                  style: TextStyle(fontSize: 13),
                                )
                              ],
                            ),
                          )),
                ),
              ],
            ),
            //descriptionview
            Helper.allowHeight(15),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(width: Helper.width / 2, child: const Divider()),
                Helper.allowHeight(10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Text(
                        "Interdum et malesuada fames ac ante ipsum primis in faucibus. Etiam eu nibh elementum, accumsan ona neque ac, aliquet nunc. In eu ipsum fringilla, accumsan purus vel, pellentesque risus. Vivamus vehicula nl purus at eros interdum, in dignissim nullaInterdum et malesuada fames ac ante ipsum primis in faucibus. Etiam eu nibh elementum, accumsan ona neque.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            //includes&excludesview
            Helper.allowHeight(15),
            Column(
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.check,
                                    color: Colors.green,
                                    size: 22,
                                  ),
                                  Helper.allowWidth(30),
                                  const Flexible(
                                    child: Text(
                                      "Reloaded 1 of 850 libraries in 832ms (compile: 72 ms, reload: 228 ms, reassemble: 306 ms).",
                                      style: TextStyle(fontSize: 12),
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
            Helper.allowHeight(15),
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
                  children: List.generate(
                      3,
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
                                  const Flexible(
                                    child: Text(
                                      "Reloaded 1 of 850 libraries in 832ms (compile: 72 ms, reload: 228 ms, reassemble: 306 ms).",
                                      style: TextStyle(fontSize: 12),
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
          ],
        ));
  }
}
