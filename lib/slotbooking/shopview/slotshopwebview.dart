import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/apiservice/serverhelper.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/bloc/myqbloc.dart';
import 'package:pwaohyes/common/footer.dart';
import 'package:pwaohyes/common/header.dart';
import 'package:pwaohyes/model/shopviewmodel.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class SlotBookingShopWebView extends StatelessWidget {
  const SlotBookingShopWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Header(removeBadge: false, scaffoldKey: null),
          Helper.allowHeight(10),
          BlocConsumer<MyQBloc, MyQState>(
            buildWhen: (previous, current) =>
                current is GettingOneShop ||
                current is OneShopFetched ||
                current is OneShopNotFetched ||
                current is GettingOneShopError,
            listener: (context, state) {},
            builder: (context, state) => state is GettingOneShop
                ? const Center(child: CupertinoActivityIndicator())
                : state is OneShopFetched
                    ? SlotShopWebContent(
                        shopViewModel: Initializer.shopViewModel)
                    : Helper.shrink(),
          ),
          Helper.allowHeight(10),
          const Footer(),
        ],
      ),
    );
  }
}

class SlotShopWebContent extends StatelessWidget {
  final ShopViewModel? shopViewModel;
  const SlotShopWebContent({super.key, required this.shopViewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Helper.width,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 200),
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            shopTitle(shopViewModel, context),
            Helper.allowHeight(20),
            bookingButton(shopViewModel),
          ],
        ));
  }

  Widget bookingButton(ShopViewModel? shopViewModel) =>
      BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            current is OTPNotVerified ||
            current is OTPVerified ||
            current is VerifyingOTPError,
        listener: (context, state) {
          if (state is OTPNotVerified || state is VerifyingOTPError) {
            Initializer.phoneController.clear();
            Initializer.otpController.clear();
            Helper.pop();
          }
          if (state is OTPVerified) {
            Helper.pop();
            Initializer.serviceBloc.bookService({
              "name": Initializer.phoneController.text,
              "phone": Initializer.phoneController.text,
              "service_id": Initializer.selectedShopServiceId,
              "slot_id": Initializer.selectedShopSlotId,
              "number_of_slots": "1",
              "booked_date": Initializer.seletedShopSlotDate.toString(),
              "booking_amount":
                  Initializer.shopSlotModel.serviceInfo!.amount.toString(),
            });
            Initializer.phoneController.clear();
            Initializer.otpController.clear();
          }
        },
        child: BlocBuilder<MyQBloc, MyQState>(
          buildWhen: (previous, current) =>
              current is SlotShopFetched ||
              current is SlotShopNotFound ||
              current is SlotShopNotFetched ||
              current is GettingSlotShopError,
          builder: (context, state) => state is SlotShopFetched
              ? SizedBox(
                  width: Helper.width / 4,
                  child: MaterialButton(
                    onPressed: () {
                      if (Initializer.selectedShopServiceId != null) {
                        if (Initializer.selectedShopSlotId != null) {
                          if (!Initializer.userModel.isLoggedIn!) {
                            Helper.showAuthDialogue(context: context);
                          } else {
                            Initializer.serviceBloc.bookService({
                              "name": Initializer.userModel.phone,
                              "phone": Initializer.userModel.phone!,
                              "service_id": Initializer.selectedShopServiceId,
                              "slot_id": Initializer.selectedShopSlotId,
                              "number_of_slots": "1",
                              "booked_date":
                                  Initializer.seletedShopSlotDate.toString(),
                              "booking_amount": Initializer
                                  .shopSlotModel.serviceInfo!.amount
                                  .toString(),
                            });
                          }
                        } else {
                          Helper.showSnack("Please select a slot");
                        }
                      } else {
                        Helper.showSnack("Please select a service");
                      }
                    },
                    elevation: 5.0,
                    color: primaryColor,
                    padding: const EdgeInsets.symmetric(
                        vertical: 22, horizontal: 120),
                    child: Text(
                        "\u{20B9} ${Initializer.shopSlotModel.serviceInfo!.amount}   Book Now",
                        style: const TextStyle(color: white, fontFamily: "")),
                  ),
                )
              : Helper.shrink(),
        ),
      );

  Widget shopTitle(ShopViewModel? shopViewModel, BuildContext context) =>
      SizedBox(
        width: Helper.width / 1.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Helper.allowHeight(20),
            Row(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          Helper.toTitleCase(
                              shopViewModel!.data!.businessName!),
                          style: const TextStyle(fontSize: 34)),
                      Text(
                          Helper.toTitleCase(shopViewModel
                              .data!.businessCategory!.businessName!),
                          style: const TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w300)),
                      Helper.allowHeight(15),
                      InkWell(
                        onTap: () => Helper.openMap(
                            lat: shopViewModel.data!.location!.last,
                            lon: shopViewModel.data!.location!.first),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              CupertinoIcons.map_pin_ellipse,
                              color: Colors.green,
                              size: 24,
                            ),
                            Helper.allowWidth(10.0),
                            Flexible(
                              child: Text(
                                  Helper.toTitleCase(
                                      shopViewModel.data!.addressLine1!),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    color: Colors.blueGrey,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Helper.allowHeight(15),
                    ],
                  ),
                ),
                Helper.allowWidth(60),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl:
                        ServerHelper.myQPadUrlImage + shopViewModel.data!.logo!,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.image_not_supported_rounded),
                    progressIndicatorBuilder: (context, url, progress) =>
                        const Center(
                      child: CupertinoActivityIndicator(
                        color: Colors.grey,
                      ),
                    ),
                    fit: BoxFit.cover,
                    width: 400,
                    height: 160,
                  ),
                ),
              ],
            ),
            Helper.allowHeight(20),
            const Text('Choose Date', style: TextStyle(fontSize: 16)),
            Helper.allowHeight(10),
            Selector<ProviderClass, DateTime>(
              selector: (p0, p1) => p1.serviceTime,
              builder: (context, value, child) => InkWell(
                onTap: () => showDatePicker(
                  context: context,
                  initialDate: value,
                  firstDate: Initializer.now,
                  builder: (context, child) => Theme(
                      data: ThemeData.light().copyWith(
                        primaryColor: primaryColor,
                        colorScheme: ColorScheme.light(
                            primary: primaryColor,
                            secondary:
                                const Color(0xffF46523).withOpacity(0.1)),
                      ),
                      child: child!),
                  lastDate: DateTime(Initializer.now.year + 2),
                ).then((value) {
                  // value
                  if (value != null) {
                    Initializer.providerClass!.selectSlotServiceDate(value);
                  }
                }),
                child: Container(
                  width: Helper.width / 4,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 26),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: primaryColor)
                      // borderRadius: BorderRadius.circular(4.0),
                      ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        Helper.setDateFormat(
                            dateTime: value, format: "dd/MM/yyyy"),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Helper.allowWidth(10.0),
                      const Icon(
                        CupertinoIcons.calendar,
                        color: primaryColor,
                        size: 22,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Helper.allowHeight(20),
            const Text('Select Services', style: TextStyle(fontSize: 16)),
            Helper.allowHeight(10),
            Consumer<ProviderClass>(
              builder: (context, value, child) => Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: List.generate(
                  shopViewModel.services!.length,
                  (index) => InkWell(
                    onTap: () {
                      if (!shopViewModel.services![index].isSelected!) {
                        Initializer.providerClass!.changeSlotShopService(index);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 26),
                      decoration: BoxDecoration(
                        color: shopViewModel.services![index].isSelected!
                            ? primaryColor
                            : white,
                        border: Border.all(
                            color: shopViewModel.services![index].isSelected!
                                ? white
                                : primaryColor),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      child: Text(
                        Helper.toTitleCase(shopViewModel
                            .services![index].serviceCategoryId!.serviceName!),
                        style: TextStyle(
                            color: shopViewModel.services![index].isSelected!
                                ? white
                                : black),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Helper.allowHeight(20),
            const Text('Service Slots', style: TextStyle(fontSize: 16)),
            Helper.allowHeight(10),
            BlocBuilder<MyQBloc, MyQState>(
              buildWhen: (previous, current) =>
                  current is GettingSlotShop ||
                  current is SlotShopFetched ||
                  current is SlotShopNotFound ||
                  current is SlotShopNotFetched ||
                  current is GettingSlotShopError,
              builder: (context, state) => state is GettingSlotShop
                  ? Helper.wrapperShimmer(width: 180, height: 50)
                  : state is SlotShopFetched
                      ? Consumer<ProviderClass>(
                          builder: (context, value, child) => Wrap(
                            spacing: 16.0,
                            runSpacing: 16.0,
                            children: List.generate(
                              Initializer.shopSlotModel.data!.length,
                              (index) => InkWell(
                                onTap: () {
                                  if (Initializer.shopSlotModel.data![index]
                                      .isAvailable!) {
                                    if (!state.data![index].isSelected!) {
                                      Initializer.providerClass!
                                          .changeShopServiceSlot(index);
                                    }
                                  } else {
                                    Helper.showSnack("Slot Already Booked");
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24),
                                  decoration: BoxDecoration(
                                    color: Initializer.shopSlotModel
                                            .data![index].isSelected!
                                        ? primaryColor
                                        : white,
                                    border: Border.all(
                                        color: Initializer.shopSlotModel
                                                .data![index].isSelected!
                                            ? white
                                            : primaryColor),
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                  child: Text(
                                    "${Helper.timeConversion(time24: Initializer.shopSlotModel.data![index].slotStartTime)} - ${Helper.timeConversion(time24: Initializer.shopSlotModel.data![index].slotEndTime)}",
                                    style: TextStyle(
                                        color: Initializer.shopSlotModel
                                                .data![index].isSelected!
                                            ? white
                                            : black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : state is SlotShopNotFound
                          ? const Center(
                              child: Text("No Slots Found For This Service"))
                          : Helper.shrink(),
            ),
            Helper.allowHeight(20),
          ],
        ),
      );
}
