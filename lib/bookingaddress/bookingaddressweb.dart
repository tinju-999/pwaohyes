import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/bloc/bookingbloc.dart';
import 'package:pwaohyes/bookingaddress/bookingaddaddresswebpart2.dart';
import 'package:pwaohyes/common/footer.dart';
import 'package:pwaohyes/common/header.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class BookingAddressWeb extends StatefulWidget {
  final String? serviceTitle;
  const BookingAddressWeb({super.key, this.serviceTitle});

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
                        route: BookingAddressWeb(
                            serviceTitle: widget.serviceTitle),
                        scaffoldKey: scaffoldKey),
                    Helper.allowHeight(10),
                    Selector<ProviderClass, bool>(
                      selector: (p0, p1) => p1.isAddAddressVisible!,
                      builder: (context, value, child) => value
                          ? const AddAddressPageWeb()
                          : BookingAddressWebPage(
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

class BookingAddressWebPage extends StatefulWidget {
  final String? serviceTitle;
  const BookingAddressWebPage({super.key, required this.serviceTitle});

  @override
  State<BookingAddressWebPage> createState() => _BookingAddressWebPageState();
}

class _BookingAddressWebPageState extends State<BookingAddressWebPage> {
  final yourScrollController = ScrollController();
  var descriptionController = TextEditingController();
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
                              widget.serviceTitle!,
                              style: const TextStyle(fontSize: 16, color: grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Helper.allowHeight(15),
                    mainView(context, descriptionController),
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
                      amountView("Total Amount", getPrice("Free")),
                      amountView("Membership Offer", getPrice("Rs. 0")),
                      amountView("Coupon & Promo Code", getPrice("Rs. 0")),
                      amountView("Platform Fee", getPrice("Rs. 0")),
                      Helper.allowHeight(20),
                      const Divider(),
                      amountView("Total", getPrice("Free")),
                      // Helper.allowHeight(30),

                      // const Text(
                      //   "You have Saved ₹ 298 on this bill",
                      //   style: TextStyle(color: primaryColor),
                      // )
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
                  if (Initializer.selectedServiceDetailsModel.data!.address !=
                      null)
                    addressCustomfield(
                      context,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(Initializer.selectedServiceDetailsModel.data!
                                  .address!.name!),
                              Text(
                                  "${Initializer.selectedServiceDetailsModel.data!.address!.addressLine1!}, ${Initializer.selectedServiceDetailsModel.data!.address!.city!}"),
                              Text(Initializer.selectedServiceDetailsModel.data!
                                  .address!.contactNumber!),
                              //                       "address": {
                              //   "name": "Ajomon George ",
                              //   "is_selected": true,
                              //   "title": "Work",
                              //   "landmark": "angamaly ",
                              //   "address_line_1": "122",
                              //   "city": "Karayamparambu, Karukutty, Kerala, India, 683572",
                              //   "contact_number": "9744833812",
                              //   "latitude": 10.215235781055455,
                              //   "longitude": 76.37865364551544,
                              //   "_id": "66c6c58f22ce49d2ed939625"
                              // },
                            ],
                          ),
                          const Icon(Icons.check_circle, color: Colors.green)
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(CupertinoIcons.arrow_right,
                                  color: primaryColor),
                              Helper.allowWidth(15),
                              const Text(
                                'CHANGE ADDRESS',
                                style: TextStyle(
                                  color: primaryColor,
                                ),
                              )
                            ],
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(CupertinoIcons.add, color: primaryColor),
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
                        controller: descriptionController,
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
                  Selector<ProviderClass, bool>(
                    selector: (p0, p1) => p1.agreed,
                    builder: (context, value, child) => Checkbox(
                      value: value,
                      onChanged: (value) =>
                          Initializer.providerClass?.setAgreement(value),
                      activeColor: primaryColor,
                    ),
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
                    onPressed: () {
                      if (Initializer.providerClass!.agreed) {
                        context.read<BookingBloc>().add(ConfirmBooking(
                              serviceId: Initializer.selectedServiceId,
                              description: descriptionController.text,
                            ));
                      } else {
                        Helper.showSnack("Please agree terms and conditions ");
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
        width: Helper.width / 1.5,
        constraints: BoxConstraints(maxWidth: Helper.width / 3),
        decoration: BoxDecoration(
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

  String getPrice(String content) {
    if (int.tryParse(Initializer.providerClass!.selectedServiceAmount) != 0) {
      return Initializer.providerClass!.selectedServiceAmount;
    } else {
      return content;
    }
  }

  showAllAddressView() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Change Address"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextButton(
                  onPressed: () {}, child: const Text("Add New Address")),
            )
          ],
          content: BlocBuilder<BookingBloc, BookingState>(
            buildWhen: (previous, current) =>
                current is GettingUserAddress ||
                current is UserAddressFetched ||
                current is UserAddressNotFetched ||
                current is GettingUserAddressError,
            builder: (context, state) => state is GettingUserAddress
                ? const Center(child: CupertinoActivityIndicator())
                : state is UserAddressFetched ||
                        Initializer.userAllAddressModel.data!.isNotEmpty
                    ? Container(
                        width: Helper.width / 4,
                        color: white,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount:
                              Initializer.userAllAddressModel.data!.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) => Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Initializer.userAllAddressModel
                                        .data![index].isSelected!
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              Helper.allowWidth(15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(Initializer
                                      .userAllAddressModel.data![index].name!),
                                  Text(
                                      "${Initializer.userAllAddressModel.data![index].addressLine1!}, ${Initializer.userAllAddressModel.data![index].city!}"),
                                  Text(Initializer.userAllAddressModel
                                      .data![index].contactNumber!),
                                ],
                              ),
                              const Spacer(),
                              InkWell(
                                  onTap: () => context.read<BookingBloc>().add(DeleteAddress(id: Initializer.userAllAddressModel.data![index].sId)),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.grey,
                                  )),
                              Helper.allowWidth(20)
                            ],
                          ),
                        ))
                    : const Text("Error Loading User Addresses"),
          ),
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
