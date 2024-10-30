import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/apiservice/serverhelper.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/bloc/myqbloc.dart';
import 'package:pwaohyes/bloc/servicebloc.dart';
import 'package:pwaohyes/common/header.dart';
import 'package:pwaohyes/model/partnerreviewmodel.dart';
import 'package:pwaohyes/model/shopslotmodel.dart';
import 'package:pwaohyes/model/shopviewmodel.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/extensions.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class SlotBookingShopMobileView extends StatelessWidget {
  const SlotBookingShopMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Header(
            scaffoldKey: null,
            removeBadge: true,
          ),
          Helper.allowHeight(10),
          BlocConsumer<MyQBloc, MyQState>(
            buildWhen: (previous, current) =>
                current is GettingOneShop ||
                current is OneShopFetched ||
                current is OneShopNotFetched ||
                current is GettingOneShopError,
            listener: (context, state) {
              if (state is RreviewsFetched) {
                Helper.showLog('Reviews fetched');
                if (Initializer.userModel.isLoggedIn!) {
                  context.read<AuthBloc>().add(
                        GetMyReview(
                          partnerId: Initializer.shopViewModel.data!.sId,
                          phoneNo: Initializer.userModel.phone,
                        ),
                      );
                }
              }
              if (state is OneShopFetched) {
                context.read<MyQBloc>().add(GetRatingList(
                    page: "1",
                    limit: "100",
                    shopId: Initializer.shopViewModel.data!.sId));
                // Initializer.myQBloc.getRatingList(
                //     shopId: Initializer.shopViewModel.data!.sId);
                // if (Initializer.userModel.isLoggedIn!) {
                //   context.read<AuthBloc>().add(
                //         GetMyReview(
                //           partnerId: Initializer.shopViewModel.data!.sId,
                //           phoneNo: Initializer.userModel.phone,
                //         ),
                //       );
                // }
              }
            },
            builder: (context, state) => state is GettingOneShop
                ? const Center(child: CupertinoActivityIndicator())
                : state is OneShopFetched
                    ? SlotShopWebContent(
                        shopViewModel: Initializer.shopViewModel)
                    : Helper.shrink(),
          ),
          // Helper.allowHeight(10),
          // const Footer(),
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
    final formKey = GlobalKey<FormState>();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController otpController = TextEditingController();
    return Align(
      alignment: Alignment.center,
      child: Container(
          width: Helper.width,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
          color: white,
          child: Column(
            children: [
              shopTitle(shopViewModel, context),
              Helper.allowHeight(10),
              bookingButton(
                  shopViewModel, formKey, phoneController, otpController),
            ],
          )),
    );
  }

  Widget bookingButton(
          ShopViewModel? shopViewModel,
          GlobalKey<FormState> formKey,
          TextEditingController phoneController,
          TextEditingController otpController) =>
      BlocBuilder<MyQBloc, MyQState>(
        buildWhen: (previous, current) =>
            current is SlotShopFetched ||
            current is SlotShopNotFound ||
            current is SlotShopNotFetched ||
            current is GettingSlotShopError,
        builder: (context, state) => state is SlotShopFetched
            ? Column(
                children: [
                  SizedBox(
                    width: Helper.width,
                    child: MaterialButton(
                      onPressed: () {
                        if (Initializer.selectedShopServiceId != null) {
                          if (Initializer.selectedShopSlotId != null) {
                            if (!Initializer.userModel.isLoggedIn!) {
                              showAuthView(context, formKey, phoneController,
                                  otpController, true, shopViewModel);
                            } else {
                              context
                                  .read<ServiceBloc>()
                                  .add(BookService(data: {
                                    "name": Initializer.userModel.phone,
                                    "phone": Initializer.userModel.phone!,
                                    "service_id":
                                        Initializer.selectedShopServiceId,
                                    "slot_id": Initializer.selectedShopSlotId,
                                    "number_of_slots": "1",
                                    "booked_date": Initializer
                                        .seletedShopSlotDate
                                        .toString(),
                                    "booking_amount": Initializer
                                        .shopSlotModel.serviceInfo!.amount
                                        .toString(),
                                  }));
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
                          vertical: 18, horizontal: 18),
                      child: Text(
                          "\u{20B9} ${Initializer.shopSlotModel.serviceInfo!.amount}   Book Now",
                          style: const TextStyle(color: white, fontFamily: "")),
                    ),
                  ),
                  Helper.allowHeight(30),
                  reviewView(context, formKey, phoneController, otpController),
                ],
              )
            : Helper.shrink(),
      );

  Widget shopTitle(ShopViewModel? shopViewModel, BuildContext context) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Helper.allowHeight(20),
          Row(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(Helper.toTitleCase(shopViewModel!.data!.businessName!),
                        style: const TextStyle(fontSize: 24)),
                    Text(
                        Helper.toTitleCase(shopViewModel
                            .data!.businessCategory!.businessName!),
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        )),
                    Helper.allowHeight(5),
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
                            size: 15,
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
                                  fontSize: 12,
                                  color: Colors.blueGrey,
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Helper.allowWidth(15),
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
                  width: Helper.width / 2,
                  height: 90,
                ),
              ),
            ],
          ),
          Helper.allowHeight(15),
          const Text('Choose Date', style: TextStyle(fontSize: 14)),
          Helper.allowHeight(5),
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
                          secondary: const Color(0xffF46523).withOpacity(0.1)),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                width: Helper.width,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      Helper.setDateFormat(
                          dateTime: value, format: "dd/MM/yyyy"),
                      style: const TextStyle(
                          color: primaryColor,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                    Helper.allowWidth(10.0),
                    const Icon(
                      CupertinoIcons.calendar,
                      color: primaryColor,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
          ),
          Helper.allowHeight(15),
          const Text('Select Services', style: TextStyle(fontSize: 14)),
          Helper.allowHeight(5),
          Consumer<ProviderClass>(
            builder: (context, value, child) => Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                shopViewModel.services!.length,
                (index) => InkWell(
                  onTap: () {
                    if (!shopViewModel.services![index].isSelected!) {
                      Initializer.providerClass!.changeSlotShopService(index);
                    }
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                    decoration: BoxDecoration(
                      color: shopViewModel.services![index].isSelected!
                          ? primaryColor
                          : white,
                      border: Border.all(
                          color: shopViewModel.services![index].isSelected!
                              ? white
                              : primaryColor),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      Helper.toTitleCase(shopViewModel
                          .services![index].serviceCategoryId!.serviceName!),
                      style: TextStyle(
                          fontSize: 12,
                          color: shopViewModel.services![index].isSelected!
                              ? white
                              : black),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Helper.allowHeight(15),
          const Text('Select Service Slots', style: TextStyle(fontSize: 14)),
          Helper.allowHeight(15),
          BlocBuilder<MyQBloc, MyQState>(
            buildWhen: (previous, current) =>
                current is GettingSlotShop ||
                current is SlotShopFetched ||
                current is SlotShopNotFound ||
                current is SlotShopNotFetched ||
                current is GettingSlotShopError,
            builder: (context, state) => state is GettingSlotShop
                ? Helper.wrapperShimmer(width: 120, height: 30)
                : state is SlotShopFetched
                    ? Consumer<ProviderClass>(
                        builder: (context, value, child) => Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: List.generate(
                            Initializer.shopSlotModel.data!.length,
                            (index) => InkWell(
                              onTap: () {
                                if (Initializer
                                    .shopSlotModel.data![index].isAvailable!) {
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
                                    vertical: 8, horizontal: 14),
                                decoration: BoxDecoration(
                                  color: Initializer.shopSlotModel.data![index]
                                          .isSelected!
                                      ? primaryColor
                                      : white,
                                  border: Border.all(
                                      color: Initializer.shopSlotModel
                                              .data![index].isSelected!
                                          ? white
                                          : primaryColor),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  getText(
                                      Initializer.shopSlotModel.data![index]),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Initializer.shopSlotModel
                                                  .data![index].isSelected! ||
                                              !Initializer.shopSlotModel
                                                  .data![index].isAvailable!
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
                            child: Text(
                            "No Slots Found For This Service",
                            style: TextStyle(fontSize: 12),
                          ))
                        : Helper.shrink(),
          ),
          Helper.allowHeight(10),
        ],
      );

  showAuthView(
          BuildContext context,
          GlobalKey<FormState> formKey,
          TextEditingController phoneController,
          TextEditingController otpController,
          bool isBooking,
          ShopViewModel? shopViewModel) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Form(
            key: formKey,
            child: BlocConsumer<AuthBloc, AuthState>(
              listenWhen: (previous, current) =>
                  current is OTPNotVerified ||
                  current is OTPVerified ||
                  current is VerifyingOTPError,
              listener: (context, state) {
                if (state is OTPNotVerified || state is VerifyingOTPError) {
                  phoneController.clear();
                  otpController.clear();
                  Helper.pop();
                }
                if (state is OTPVerified) {
                  Helper.pop();
                  if (isBooking) {
                    context.read<ServiceBloc>().add(BookService(data: {
                          "name": phoneController.text,
                          "phone": phoneController.text,
                          "service_id": Initializer.selectedShopServiceId,
                          "slot_id": Initializer.selectedShopSlotId,
                          "number_of_slots": "1",
                          "booked_date":
                              Initializer.seletedShopSlotDate.toString(),
                          "booking_amount": Initializer
                              .shopSlotModel.serviceInfo!.amount
                              .toString(),
                        }));

                    phoneController.clear();
                    otpController.clear();
                  } else {
                    context.read<AuthBloc>().add(
                          GetMyReview(
                            partnerId: Initializer.shopViewModel.data!.sId,
                            phoneNo: Initializer.userModel.phone,
                          ),
                        );
                    // Helper.pushNamed(
                    //     '/addReviewPage?shopName=${shopViewModel!.data!.businessName}&shopCat=${shopViewModel.data!.businessCategoryName}&partnerId=${shopViewModel.data!.sId}');
                  }
                }
              },
              buildWhen: (previous, current) =>
                  current is VerifyingOTP ||
                  current is OTPVerified ||
                  current is OTPNotVerified ||
                  current is VerifyingOTPError ||
                  current is RequestingOTP ||
                  current is OTPRequested ||
                  current is OTPNotRequested ||
                  current is OTPNotRequested,
              builder: (context, state) => Container(
                decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0),
                    )),
                padding: const EdgeInsets.all(8),
                width: Helper.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Verify Now",
                      style: TextStyle(fontSize: 22),
                    ),
                    Helper.allowHeight(5),
                    const Text(
                      "Please enter your mobile number to verify",
                      style: TextStyle(
                        fontSize: 12,
                        color: grey,
                      ),
                    ),
                    Helper.allowHeight(10),
                    TextFormField(
                      autofocus: true,
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter mobile number";
                        } else {
                          return null;
                        }
                      },
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      buildCounter: (context,
                              {required currentLength,
                              required isFocused,
                              required maxLength}) =>
                          Helper.shrink(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 14),
                        hintText: "Mobile Number",
                        hintStyle: const TextStyle(fontSize: 13, color: grey),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    if (state is OTPRequested) Helper.allowHeight(10),
                    if (state is OTPRequested || otpController.text.isNotEmpty)
                      TextFormField(
                          autofocus: true,
                          controller: otpController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter a valid OTP";
                            } else {
                              return null;
                            }
                          },
                          maxLength: 4,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          buildCounter: (context,
                                  {required currentLength,
                                  required isFocused,
                                  required maxLength}) =>
                              Helper.shrink(),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 14),
                            hintText: "OTP",
                            hintStyle:
                                const TextStyle(fontSize: 13, color: grey),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: grey),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          )),
                    Helper.allowHeight(10),
                    SizedBox(
                      width: Helper.width,
                      child: MaterialButton(
                        onPressed: () {
                          if (state is! RequestingOTP ||
                              state is! VerifyingOTP) {
                            if (state is OTPRequested) {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(VerifyOtp(
                                      otp: otpController.text,
                                      phone: phoneController.text,
                                    ));
                              }
                            } else {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                    VerifyPhone(phone: phoneController.text));
                              }
                            }
                          }
                        },
                        elevation: 5.0,
                        color: primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 6),
                        child: state is RequestingOTP || state is VerifyingOTP
                            ? const Center(
                                child: CupertinoActivityIndicator(
                                    color: Colors.white))
                            : state is OTPRequested
                                ? const Text("Verify OTP",
                                    style: TextStyle(color: white))
                                : const Text("Send OTP",
                                    style: TextStyle(color: white)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  void resetFeilds() {}

  String getText(ShopSlotModelData shopSlotModelData) {
    if (!shopSlotModelData.isAvailable!) {
      return "${Helper.timeConversion(time24: shopSlotModelData.slotStartTime)} - ${Helper.timeConversion(time24: shopSlotModelData.slotEndTime)} (Booked)";
    } else {
      return "${Helper.timeConversion(time24: shopSlotModelData.slotStartTime)} - ${Helper.timeConversion(time24: shopSlotModelData.slotEndTime)}";
    }
  }

  Widget reviewView(
          BuildContext context,
          GlobalKey<FormState> formKey,
          TextEditingController phoneController,
          TextEditingController otpController) =>
      Column(
        children: [
          Container(
            width: Helper.width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 0.2,
                  spreadRadius: 0.2,
                )
              ],
              color: Colors.white,
              // border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RatingBarIndicator(
                          rating: Initializer.partnerReviewModel.partnerDetails!
                                  .averageRating ??
                              0.0,
                          itemSize: 32,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.yellow[600],
                          ),
                        ),
                        Helper.allowHeight(5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "${Initializer.partnerReviewModel.partnerDetails != null ? Initializer.partnerReviewModel.partnerDetails!.averageRating!.toStringAsFixed(1) : "0.0"} Average Rating",
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: ''),
                            ),
                            Helper.allowHeight(2.5),
                            Text(
                              Initializer.partnerReviewModel.partnerDetails !=
                                      null
                                  ? "${Initializer.partnerReviewModel.partnerDetails!.totalRating} Total Ratings"
                                  : "0 Total Ratings",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: '',
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Helper.allowHeight(20),
                BlocConsumer<AuthBloc, AuthState>(
                  // listenWhen: (previous, current) =>
                  //     current is MyReviewsFetched || current is GettingMyReview,
                  listener: (context, state) {
                    // if (state is MyReviewsFetched) {
                    //   MyQBloc().add(GetRatingList(
                    //       page: "1",
                    //       limit: "100",
                    //       shopId: Initializer.shopViewModel.data!.sId));
                    //   // if (!Initializer.myReviewModel.review!) {
                    //   //   Helper.pushNamed(
                    //   //       '/addReviewPage?shopName=${shopViewModel!.data!.businessName}&shopCat=${shopViewModel!.data!.businessCategoryName}&partnerId=${shopViewModel!.data!.sId}');
                    //   // }
                    // }
                  },
                  builder: (context, state) => GestureDetector(
                    onTap: () {
                      if (!Initializer.userModel.isLoggedIn!) {
                        showAuthView(context, formKey, phoneController,
                            otpController, false, shopViewModel);
                      } else {
                        Helper.pushNamed(
                            '/addReviewPage?shopName=${shopViewModel!.data!.businessName}&shopCat=${shopViewModel!.data!.businessCategoryName}&partnerId=${shopViewModel!.data!.sId}');
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      width: Helper.width,
                      child: state is MyReviewsFetched &&
                              Initializer.myReviewModel.review!
                          ? myReiewView(Initializer.myReviewModel.data!)
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: primaryColor)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Icon(
                                    Icons.rate_review_rounded,
                                    color: primaryColor,
                                    size: 18,
                                  ),
                                  Helper.allowWidth(10),
                                  const Text("Write a review",
                                      style: TextStyle(
                                          color: primaryColor, fontFamily: "")),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Helper.allowHeight(15),
          Selector<ProviderClass, bool>(
            selector: (p0, p1) => p1.showAllReviewsStatus,
            builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      "All Reviews",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          Initializer.providerClass?.showAllReviews(value),
                      icon: Icon(
                        value
                            ? CupertinoIcons.chevron_up
                            : CupertinoIcons.chevron_down,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                if (value) Helper.allowHeight(10),
                if (value)
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 14),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => reviewTileView(
                        Initializer.partnerReviewModel.data![index], false),
                    separatorBuilder: (context, index) => Column(
                      children: [
                        Helper.allowHeight(10),
                        const Divider(
                          color: Colors.grey,
                          thickness: 0.2,
                        ),
                        Helper.allowHeight(10),
                      ],
                    ),
                    itemCount: Initializer.partnerReviewModel.data!.length,
                  ),
              ],
            ),
          ),
        ],
      );

  myReiewView(PartnerReviewData myReviewModel) => Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: reviewTileView(myReviewModel, true));

  Widget reviewTileView(
          PartnerReviewData partnerReviewData, bool isMyComment) =>
      SizedBox(
        width: Helper.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    Helper.allowWidth(15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          partnerReviewData.customerName!.toTitleCase(),
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          Helper.getTimeAgo(
                              DateTime.tryParse(partnerReviewData.createDate!)),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Helper.allowWidth(15),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "${partnerReviewData.rating ?? 0}",
                            style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Helper.allowWidth(2.0),
                          const Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                if (isMyComment) Helper.allowWidth(10),
                if (isMyComment)
                  IconButton(
                      onPressed: () {
                        Helper.pushNamed(
                            '/addReviewPage?commentId=${partnerReviewData.sId}&comment=${partnerReviewData.review ?? ""}&rating=${partnerReviewData.rating}&shopName=${shopViewModel!.data!.businessName}&shopCat=${shopViewModel!.data!.businessCategoryName}&partnerId=${shopViewModel!.data!.sId}');
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 16,
                        color: Colors.grey,
                      ))
              ],
            ),
            if ((partnerReviewData.review ?? "").isNotEmpty)
              Helper.allowHeight(15),
            if ((partnerReviewData.review ?? "").isNotEmpty)
              Text(partnerReviewData.review!)
          ],
        ),
      );
}
