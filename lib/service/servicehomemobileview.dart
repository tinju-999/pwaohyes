import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwaohyes/bloc/myqbloc.dart';
import 'package:pwaohyes/bloc/servicebloc.dart';
import 'package:pwaohyes/common/footer.dart';
import 'package:pwaohyes/common/header.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/slotbooking/slotbookinmobileview.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/routes.dart';

class ServiceHomeMobileView extends StatelessWidget {
  final ProviderClass? providerClass;
  const ServiceHomeMobileView({super.key, this.providerClass});

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
                            route: ServiceHomeMobileView(
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
      width: Helper.width,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 4),
      color: white,
      child: services(context),
    );
  }

  Widget subServices(BuildContext context) => Column(
        key: const ValueKey('ohYesServices'),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Discover\nSubcategories",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          // const Text(
          //   "Dive Deeper Into Our Subcategories To\nFind More Specific Options\nTailored To Your Needs",
          //   style: TextStyle(
          //       fontSize: 16,
          //       fontWeight: FontWeight.w500,
          //       color: Colors.blueGrey),
          //   textAlign: TextAlign.center,
          // ),
          Helper.allowHeight(15),
          BlocBuilder<ServiceBloc, ServiceState>(
            builder: (context, state) => state is FetchingSubServices
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : state is SubServicesFetched ||
                        Initializer.subCatModel.data!.services!.isNotEmpty
                    ? Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 18.0,
                        runSpacing: 18.0,
                        children: List.generate(
                            Initializer.subCatModel.data!.services!.length,
                            (index) => InkWell(
                                  onTap: () => Navigator.pushNamed(context,
                                      '/booking?catId=${Initializer.subCatModel.data!.services![index].sId}&title=${Initializer.subCatModel.data!.services![index].title}'),
                                  // Initializer.providerClass?.getLocation(),
                                  //     Helper.pushNamed(bookingOne, {
                                  //   "catId": Initializer
                                  //       .subCatModel.data!.services![index].sId,
                                  //   "title": Initializer.subCatModel.data!
                                  //       .services![index].title
                                  // }),
                                  // Helper.pushNamed(BookingWeb(
                                  //     catId: Initializer.subCatModel.data!
                                  //         .services![index].sId)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        clipBehavior: Clip.hardEdge,
                                        constraints: const BoxConstraints(
                                          maxHeight: 120,
                                          maxWidth: 120,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 9, horizontal: 7),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: white,
                                            border: Border.all(
                                                color: primaryColor)),
                                        child: Initializer.subCatModel.data!
                                                    .services![index].image !=
                                                null
                                            ? CachedNetworkImage(
                                                imageUrl: Initializer
                                                    .subCatModel
                                                    .data!
                                                    .services![index]
                                                    .image!,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(
                                                          Icons.error,
                                                          color: black,
                                                        ))
                                            : noImageView(context),
                                      ),
                                      Helper.allowHeight(10),
                                      SizedBox(
                                        width: Helper.width / 4,
                                        child: Text(
                                          Initializer.subCatModel.data!
                                              .services![index].title!,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: quicksand,
                                              fontSize: 14,
                                              overflow: TextOverflow.visible),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                      )
                    : const Center(
                        child: Text("Something went wrong"),
                      ),
          ),
          Helper.allowHeight(30),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: Helper.width / 2,
              child: MaterialButton(
                onPressed: () => providerClass!.showSubSerives(false),
                elevation: 0.0,
                color: primaryColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(CupertinoIcons.arrow_left, color: white),
                    Helper.allowWidth(15),
                    const Text(
                      "Go Back",
                      style: TextStyle(color: white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  // subServices(BuildContext context) => showDialog(
  //       barrierColor: Colors.white70,
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         elevation: 0.0,
  //         backgroundColor: Colors.transparent,
  //         content: Container(
  //           decoration: BoxDecoration(
  //               color: white,
  //               border: Border.all(color: primaryColor),
  //               borderRadius: BorderRadius.circular(8.0)),
  //           padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
  //           // width: Helper.width / 1.5,

  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisSize: MainAxisSize.max,
  //                 children: [
  //                   const Text(
  //                     "Choose Sub Services For Electrician",
  //                     style: TextStyle(
  //                       fontFamily: quicksand,
  //                       fontSize: 26,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   IconButton(
  //                       onPressed: () => Helper.pop(),
  //                       icon: const Icon(CupertinoIcons.clear_circled_solid),
  //                       color: black)
  //                 ],
  //               ),
  //               Helper.allowHeight(30),
  //               Wrap(
  //                 alignment: WrapAlignment.start,
  //                 spacing: 18.0,
  //                 runSpacing: 16.0,
  //                 children: List.generate(
  //                     10,
  //                     (index) => InkWell(
  //                           onTap: () => showDialog(
  //                             barrierColor: Colors.white70,
  //                             context: context,
  //                             builder: (context) => AlertDialog(
  //                               elevation: 0.0,
  //                               backgroundColor: Colors.transparent,
  //                               content: Container(
  //                                 decoration: BoxDecoration(
  //                                     color: white,
  //                                     border: Border.all(color: primaryColor),
  //                                     borderRadius: BorderRadius.circular(8.0)),
  //                                 padding: const EdgeInsets.symmetric(
  //                                     vertical: 18, horizontal: 36),
  //                                 // width: Helper.width / 1.5,

  //                                 child: const Column(
  //                                   mainAxisAlignment: MainAxisAlignment.start,
  //                                   crossAxisAlignment:
  //                                       CrossAxisAlignment.start,
  //                                   mainAxisSize: MainAxisSize.min,
  //                                   children: [
  //                                     // sd
  //                                     // Text(
  //                                     //   "Choose Sub Services",
  //                                     //   style: TextStyle(
  //                                     //     fontFamily: quicksand,
  //                                     //     fontSize: 26,
  //                                     //     fontWeight: FontWeight.bold,
  //                                     //   ),
  //                                     // ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               Container(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 width: 60,
  //                                 height: 60,
  //                                 decoration: BoxDecoration(
  //                                     color: primaryColor,
  //                                     shape: BoxShape.circle,
  //                                     border: Border.all(color: primaryColor)),
  //                                 child: const Icon(
  //                                   CupertinoIcons.home,
  //                                   color: Colors.white,
  //                                 ),
  //                               ),
  //                               Helper.allowHeight(15),
  //                               const Text(
  //                                 "Electritian",
  //                                 style: TextStyle(
  //                                   fontWeight: FontWeight.bold,
  //                                   fontFamily: quicksand,
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                         )),
  //               ),
  //               Helper.allowHeight(30),
  //               Align(
  //                 alignment: Alignment.centerRight,
  //                 child: SizedBox(
  //                   width: Helper.width / 4,
  //                   child: MaterialButton(
  //                     onPressed: () {},
  //                     elevation: 0.0,
  //                     color: primaryColor,
  //                     padding: const EdgeInsets.symmetric(
  //                         vertical: 18, horizontal: 14),
  //                     child: const Text(
  //                       "Continue",
  //                       style: TextStyle(color: white),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );

  // ohYesServices(BuildContext context, List<String> services) => Column(
  //       key: const ValueKey('ohYesServices'),
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         const Text(
  //           "Services",
  //           style: TextStyle(
  //             fontFamily: quicksand,
  //             fontSize: 32,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         // Helper.allowHeight(10),
  //         Helper.allowHeight(5),
  //         SizedBox(
  //             width: Helper.width / 4,
  //             child: const Divider(
  //               color: primaryColor,
  //               thickness: 1.0,
  //             )),
  //         Helper.allowHeight(30),
  //         Flexible(
  //           child: SingleChildScrollView(
  //             padding: const EdgeInsets.only(left: 18, right: 18),
  //             child: Center(
  //               child: Wrap(
  //                 alignment: WrapAlignment.center,
  //                 spacing: -16.0,
  //                 runSpacing: 18.0,
  //                 children: List.generate(
  //                     services.length,
  //                     (index) => InkWell(
  //                           onTap: () => providerClass!.showSubSerives(true),
  //                           child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             crossAxisAlignment: CrossAxisAlignment.center,
  //                             mainAxisSize: MainAxisSize.min,
  //                             children: [
  //                               Container(
  //                                 padding: const EdgeInsets.all(8.0),
  //                                 width: 75,
  //                                 height: 75,
  //                                 decoration: BoxDecoration(
  //                                     color: index == 0 ? primaryColor : white,
  //                                     shape: BoxShape.circle,
  //                                     border: Border.all(color: primaryColor)),
  //                                 child: Icon(
  //                                   CupertinoIcons.home,
  //                                   color: index != 0 ? primaryColor : white,
  //                                 ),
  //                               ),
  //                               Helper.allowHeight(15),
  //                               SizedBox(
  //                                 width: 120,
  //                                 child: Text(
  //                                   services[index],
  //                                   textAlign: TextAlign.center,
  //                                   style: const TextStyle(
  //                                     fontWeight: FontWeight.bold,
  //                                     fontFamily: quicksand,
  //                                   ),
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                         )),
  //               ),
  //             ),
  //           ),
  //         )
  //       ],
  //     );

  services(BuildContext context) => Column(
        key: const ValueKey('ohYesServices'),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Choose From\nVarious Categories",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, height: 1.2),
            textAlign: TextAlign.center,
          ),
          Helper.allowHeight(10),
          const Text(
            "Explore A Wide Range Of\nCategories To Find What You Need",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.2,
              color: Colors.blueGrey,
            ),
            textAlign: TextAlign.center,
          ),
          Helper.allowHeight(20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(
                Initializer.serviceCategory.length,
                (index) => InkWell(
                      onTap: () {
                        Navigator.pushNamed(context,
                            '/subServices?subServiceId=${Initializer.serviceCategory[index].sId!}');

                        // providerClass!.showSubSerives(true);
                        // Initializer.serviceBloc.getSubServices(
                        //     Initializer.serviceCategory[index].sId!);
                      },
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 22),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: white,
                                border: Border.all(color: primaryColor)),
                            child: CachedNetworkImage(
                              imageUrl:
                                  Initializer.serviceCategory[index].image!,
                              fit: BoxFit.contain,
                              filterQuality: FilterQuality.high,
                              width: 35,
                              height: 35,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Helper.allowHeight(10),
                          SizedBox(
                            width: Helper.width / 4,
                            child: Text(
                              Initializer.serviceCategory[index].name!,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: quicksand,
                                  fontSize: 12,
                                  overflow: TextOverflow.visible),
                            ),
                          ),
                        ],
                      ),
                    )),
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
                    : SlotBookingMobileContent(
                        data: Initializer.myqpadCategoryModel)),
        ],
      );

  noImageView(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          imageUrl:
              "https://cdn.vectorstock.com/i/500p/82/99/no-image-available-like-missing-picture-vector-43938299.jpg",
          width: 100,
          height: 100,
          fit: BoxFit.contain,
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
