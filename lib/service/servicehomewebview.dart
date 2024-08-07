import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/bloc/servicebloc.dart';
import 'package:pwaohyes/booking/bookingweb.dart';
import 'package:pwaohyes/common/animation.dart';
import 'package:pwaohyes/common/webfooter.dart';
import 'package:pwaohyes/common/webheader.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';

class ServiceHomeWebView extends StatelessWidget {
  final ProviderClass? providerClass;
  const ServiceHomeWebView({super.key, this.providerClass});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ServiceBloc, ServiceState>(
        buildWhen: (previous, current) =>
            current is FetchingServices ||
            current is ServicesFetched ||
            current is ServicesNotFetched,
        builder: (context, state) => state is FetchingServices
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : state is ServicesFetched || Initializer.serviceCategory.isNotEmpty
                ? SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const WebHeader(),
                        Helper.allowHeight(20),
                        ServicePageWeb(providerClass: providerClass),
                        Helper.allowHeight(20),
                        const WebFooter(),
                      ],
                    ),
                  )
                : const Center(
                    child: Text("Something went wrong services"),
                  ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Expanded(
          //   flex: 4,
          //   child: Container(
          //       clipBehavior: Clip.hardEdge,
          //       height: Helper.height / 1.5,
          //       // padding:
          //       //     const EdgeInsets.symmetric(vertical: 18, horizontal: 26),
          //       decoration: BoxDecoration(
          //         color: primaryColor,
          //         borderRadius: BorderRadius.circular(18.0),
          //         // border: Border.all(color: primaryColor)
          //         // boxShadow: <BoxShadow>[
          //         //   // BoxShadow(
          //         //   //   color: primaryColor.withOpacity(0.2),
          //         //   //   spreadRadius: 1.5,
          //         //   //   blurRadius: 2,
          //         //   //   offset: const Offset(6, 0),
          //         //   // )
          //         // ],
          //       ),
          //       child: Image.asset(
          //         'assets/images/bg2.jpeg',
          //         fit: BoxFit.contain,
          //       )),
          // ),
          // Helper.allowWidth(30),
          Expanded(
            child: Container(
              // height: Helper.height / 1.5,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              // decoration: const BoxDecoration(
              //   color: Colors.blue,
              // ),
              child: Selector<ProviderClass, bool>(
                selector: (p0, p1) => p1.showSubServices!,
                builder: (context, value, child) =>
                    value ? subServices(context) : services(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget subServices(BuildContext context) => Column(
        key: const ValueKey('ohYesServices'),
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Sub Categories",
            style: TextStyle(fontSize: 26),
          ),
          Helper.allowHeight(5),
          SizedBox(
            width: Helper.width / 4,
            child: Divider(
              color: Colors.grey[200],
            ),
          ),
          Helper.allowHeight(20),
          BlocBuilder<ServiceBloc, ServiceState>(
            builder: (context, state) => state is FetchingSubServices
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : state is SubServicesFetched ||
                        Initializer.subCatModel.data!.services!.isNotEmpty
                    ? Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 26.0,
                        runSpacing: 26.0,
                        children: List.generate(
                            Initializer.subCatModel.data!.services!.length,
                            (index) => InkWell(
                                  onTap: () => Helper.push(const BookingWeb()),
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
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              color: white,
                                              border: Border.all(
                                                  color: primaryColor)),
                                          child: Initializer.subCatModel.data!
                                                      .services![index].image !=
                                                  null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: CachedNetworkImage(
                                                    imageUrl: Initializer
                                                        .subCatModel
                                                        .data!
                                                        .services![index]
                                                        .image!,
                                                    width: 120,
                                                    height: 120,
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "https://cdn.vectorstock.com/i/500p/82/99/no-image-available-like-missing-picture-vector-43938299.jpg",
                                                    width: 120,
                                                    height: 120,
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                )),
                                      Helper.allowHeight(15),
                                      SizedBox(
                                        // width: 120,
                                        child: Text(
                                          Initializer.subCatModel.data!
                                              .services![index].title!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: quicksand,
                                          ),
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
              width: Helper.width / 4,
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
            "Categories",
            style: TextStyle(fontSize: 26),
          ),
          Helper.allowHeight(5),
          SizedBox(
            width: Helper.width / 4,
            child: Divider(
              color: Colors.grey[200],
            ),
          ),
          Helper.allowHeight(20),
          Flexible(
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
                            providerClass!.showSubSerives(true);
                            Initializer.serviceBloc.getSubServices(
                                Initializer.serviceCategory[index].sId!);
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
                                  child: Image.network(
                                    Initializer.serviceCategory[index].image!,
                                    fit: BoxFit.contain,
                                    filterQuality: FilterQuality.high,
                                    width: 60,
                                    height: 60,
                                  )),
                              Helper.allowHeight(15),
                              SizedBox(
                                // width: 120,
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
          )
        ],
      );
}
