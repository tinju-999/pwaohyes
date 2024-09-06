import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwaohyes/bloc/myqbloc.dart';
import 'package:pwaohyes/bloc/servicebloc.dart';
import 'package:pwaohyes/common/footer.dart';
import 'package:pwaohyes/common/header.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/slotbooking/slotbookingwebview.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/routes.dart';

class ServiceHomeWebView extends StatelessWidget {
  final ProviderClass? providerClass;
  const ServiceHomeWebView({super.key, this.providerClass});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      body: BlocBuilder<ServiceBloc, ServiceState>(
        buildWhen: (previous, current) =>
            current is FetchingServices ||
            current is ServicesFetched ||
            current is ServicesNotFetched,
        builder: (context, state) => state is FetchingServices
            ? const Center(child: CupertinoActivityIndicator())
            : state is ServicesFetched || Initializer.serviceCategory.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Header(
                              removeBadge: false,
                            route: ServiceHomeWebView(
                                providerClass: providerClass),
                            scaffoldKey: scaffoldKey),
                        Helper.allowHeight(10),
                        ServicePageWeb(providerClass: providerClass),
                        Helper.allowHeight(10),
                        const Footer(),
                      ],
                    ),
                  )
                : const Center(child: Text("Something went wrong")),
      ),
    );
  }
}

class ServicePageWeb extends StatelessWidget {
  final ProviderClass? providerClass;
  const ServicePageWeb({super.key, required this.providerClass});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 18),
        color: white,
        child: services(context));
  }

  services(BuildContext context) => Column(
        key: const ValueKey('ohYesServices'),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Choose From Various Categories",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Text(
            "Explore a wide range of categories to find what you need",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey),
            textAlign: TextAlign.center,
          ),
          Helper.allowHeight(40),
          SizedBox(
            width: Helper.width / 1.5,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 26.0,
                runSpacing: 26.0,
                children: List.generate(
                    Initializer.serviceCategory.length,
                    (index) => InkWell(
                          onTap: () {
                            Navigator.pushNamed(context,
                                '/subServices?subServiceId=${Initializer.serviceCategory[index].sId!}');
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(28.0),
                                  // width: 120,
                                  // height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: white,
                                      border: Border.all(color: primaryColor)),
                                  child: CachedNetworkImage(
                                    imageUrl: Initializer
                                        .serviceCategory[index].image!,
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high,
                                    width: 60,
                                    height: 60,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )),
                              Helper.allowHeight(15),
                              SizedBox(
                                width: 140,
                                child: Text(
                                  Initializer.serviceCategory[index].name!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: quicksand,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
              ),
            ),
          ),
          if (Initializer.selectedAdddress!.cityId !=
              "663a875e79785516bb955401")
            BlocConsumer<MyQBloc, MyQState>(
                buildWhen: (previous, current) =>
                    current is GettingMyQCats ||
                    current is MyQCatsFetched ||
                    current is MyQCatsNotFetched ||
                    current is GettingMyQCatsError,
                listener: (context, state) {},
                builder: (context, state) => state is GettingMyQCats
                    ? const Center(child: CupertinoActivityIndicator())
                    : SlotBookingWebContent(
                        data: Initializer.myqpadCategoryModel)),

          // bookMySlotView(context),
        ],
      );

  noImageView(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          imageUrl:
              "https://cdn.vectorstock.com/i/500p/82/99/no-image-available-like-missing-picture-vector-43938299.jpg",
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      );

  Widget bookMySlotView(BuildContext context) => Column(
        children: [
          Helper.allowHeight(40),
          const Text(
            "Book My Slot",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Text(
            "Effortlessly book your appointment",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey),
            textAlign: TextAlign.center,
          ),
          Helper.allowHeight(40),
          InkWell(
            onTap: () => Helper.pushNamed(slotBooking),
            child: Container(
              clipBehavior: Clip.hardEdge,
              constraints: BoxConstraints(maxHeight: Helper.height / 2.5),
              width: Helper.width / 1.5,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Image.asset(
                slotbookingbanner,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );
}
