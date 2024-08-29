import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/apiservice/serverhelper.dart';
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
          const Header(scaffoldKey: null),
          Helper.allowHeight(10),
          BlocConsumer<MyQBloc, MyQState>(
            buildWhen: (previous, current) =>
                current is GettingOneShop ||
                current is OneShopFetched ||
                current is OneShopNotFetched ||
                current is GettingOneShopError,
            listener: (context, state) {},
            builder: (context, state) => state is GettingOneShop
                ? const Center(child: CircularProgressIndicator())
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
    return Align(
      alignment: Alignment.center,
      child: Container(
          width: Helper.width,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 200),
          color: white,
          child: Column(
            children: [
              shopTitle(shopViewModel, context),
              Helper.allowHeight(20),
              bookingButton(shopViewModel),
            ],
          )),
    );
  }

  Widget bookingButton(ShopViewModel? shopViewModel) => SizedBox(
        width: Helper.width / 1.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              "\u{20B9} 250 Onwards",
              style: TextStyle(
                  fontFamily: "",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.green),
            ),
            Helper.allowHeight(20),
            Container(
              color: white,
              child: MaterialButton(
                onPressed: () => {},
                elevation: 5.0,
                color: primaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Book Now", style: TextStyle(color: white)),
                    Helper.allowWidth(15),
                    const Icon(Icons.arrow_outward_rounded, color: Colors.white)
                  ],
                ),
              ),
            )
          ],
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
                              fontSize: 16, fontWeight: FontWeight.w300)),
                      Helper.allowHeight(5),
                      Text(
                          Helper.toTitleCase(shopViewModel.data!.addressLine1!),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14)),
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
            Row(
              children: [
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 26),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: primaryColor)
                          // borderRadius: BorderRadius.circular(4.0),
                          ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Choose Date",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                          Helper.allowWidth(15.0),
                          Text(
                            Helper.setDateFormat(
                                dateTime: value, format: "dd/MM/yy"),
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Helper.allowWidth(20),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 26),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: primaryColor)
                        // borderRadius: BorderRadius.circular(4.0),
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Direction",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                        Helper.allowWidth(15.0),
                        const Icon(
                          Icons.directions,
                          color: primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ],
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
                    onTap: () =>
                        Initializer.providerClass!.changeSlotShopService(index),
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
            const Text(
              'Service Slots',
              style: TextStyle(fontSize: 16),
            ),
            Helper.allowHeight(10),
            BlocBuilder<MyQBloc, MyQState>(
              buildWhen: (previous, current) =>
                  current is GettingSlotShop ||
                  current is SlotShopFetched ||
                  current is SlotShopNotFound ||
                  current is SlotShopNotFetched ||
                  current is GettingSlotShopError,
              builder: (context, state) => state is SlotShopFetched
                  ? Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      children: List.generate(
                        state.data!.length,
                        (index) => Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          decoration: BoxDecoration(
                            color: index == 0 ? primaryColor : white,
                            border: Border.all(
                                color: index == 0 ? white : primaryColor),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          child: Text(
                            "${state.data![index].slotStartTime} - ${state.data![index].slotEndTime}",
                            style: TextStyle(color: index == 0 ? white : black),
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
