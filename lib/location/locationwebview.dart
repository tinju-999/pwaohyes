import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/bloc/locationbloc.dart';
import 'package:pwaohyes/common/webfooter.dart';
import 'package:pwaohyes/common/webheader.dart';
import 'package:pwaohyes/model/citiesmodel.dart';
import 'package:pwaohyes/model/selectedaddressmodel.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/service/servicehome.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/preferences.dart';

class LocationWebView extends StatefulWidget {
  final dynamic route;
  const LocationWebView({super.key, required this.route});

  @override
  State<LocationWebView> createState() => _LocationWebViewState();
}

class _LocationWebViewState extends State<LocationWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const WebHeader(
              // route: LocationWebView(
              //   route: widget.route,
              // ),
              ),
          Helper.allowHeight(10),
          BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (previous, current) =>
                  current is FetchingCitiesData ||
                  current is CitiesDataFetched ||
                  current is CitiesDataNotFetched ||
                  current is FetchingCitiesDataError,
              builder: (context, state) => state is CitiesDataFetched ||
                      Initializer.citiesModel.data!.isNotEmpty
                  ? LocationWebContentView(
                      data: Initializer.citiesModel.data!,
                      route: widget.route,
                    )
                  : state is FetchingCitiesData &&
                          Initializer.citiesModel.data!.isEmpty
                      ? const Center(child: CupertinoActivityIndicator())
                      : Helper.shrink()),
          Helper.allowHeight(10),
          const WebFooter(),
        ],
      ),
    );
  }
}

class LocationWebContentView extends StatelessWidget {
  final List<Data>? data;
  final dynamic route;
  const LocationWebContentView({super.key, this.data, required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 60),
      color: white,
      child: Column(
        children: [
          const Text(
            "Choose From Popular Cities",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Text(
            "Select a city for provide out cutting edge service to you",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey),
            textAlign: TextAlign.center,
          ),
          Helper.allowHeight(30),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 36.0,
                  runSpacing: 26.0,
                  children: List.generate(
                      data!.length,
                      (index) => InkWell(
                            onTap: () async {
                              Initializer.selectedAdddress =
                                  SelectedAddressModel(
                                      locationName: data![index].name,
                                      latLng: LatLng(
                                          double.parse(data![index].lat!),
                                          double.parse(data![index].lng!)));
                              await Preferences.setLocation(jsonEncode(
                                  Initializer.selectedAdddress!.toJson()));
                              Helper.pushReplacement(
                                  route ?? const ServiceHome());
                            },

                            // Helper.push(BookingWeb(
                            //     catId: Initializer.subCatModel.data!
                            //         .services![index].sId)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                    clipBehavior: Clip.hardEdge,
                                    constraints: const BoxConstraints(
                                      maxHeight: 120,
                                      maxWidth: 120,
                                    ),
                                    padding: const EdgeInsets.all(26.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: white,
                                        border:
                                            Border.all(color: primaryColor)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: CachedNetworkImage(
                                          imageUrl: data![index].icon!,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) {
                                            return const Icon(
                                              Icons.error,
                                              color: black,
                                            );
                                          }),
                                    )),
                                Helper.allowHeight(15),
                                SizedBox(
                                  // width: 120,
                                  child: Text(
                                    data![index].name!,
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
                ),
              ),
            ],
          ),
          Helper.allowHeight(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Helper.width / 3,
                child: const Divider(),
              ),
              Helper.allowWidth(10),
              const Text("OR"),
              Helper.allowWidth(10),
              SizedBox(
                width: Helper.width / 3,
                child: const Divider(),
              ),
            ],
          ),
          Helper.allowHeight(30),
          const Text(
            "Find Nearby Services",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Helper.allowHeight(20),
          SizedBox(
            width: Helper.width / 3,
            child: Text(
              "We use your location to provide nearby services tailored for you. Please enable location services in your browser settings to allow us to fetch your location and enhance your experience.",
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey.shade600),
              textAlign: TextAlign.center,
            ),
          ),
          Helper.allowHeight(20),
          BlocConsumer<LocationBloc, LocationState>(
            buildWhen: (previous, current) =>
                current is GettingLocation ||
                current is LocationFetched ||
                current is LocationNotFetched,
            listenWhen: (previous, current) => current is LocationFetched,
            listener: (context, state) async {
              if (state is LocationFetched) {
                await Future.delayed(const Duration(milliseconds: 1200)).then(
                    (value) =>
                        Helper.pushReplacement(route ?? const ServiceHome()));
              }
            },
            builder: (context, state) =>
                Selector<ProviderClass, SelectedAddressModel>(
                    selector: (p0, p1) => p1.selectedAddressModel,
                    builder: (context, value, child) {
                      return MaterialButton(
                        onPressed: () {
                          if (state is! GettingLocation) {
                            Initializer.locationBloc.getLocation();
                          }
                        },
                        minWidth: Helper.width / 3.5,
                        elevation: 5.0,
                        color: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: state is GettingLocation
                            ? const SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(
                                  color: white,
                                ),
                              )
                            : state is LocationFetchingError ||
                                    state is LocationNotFetched
                                ? const Text("Geolocation is blocked",
                                    style: TextStyle(color: white))
                                : const Text("Enable Location Services",
                                    style: TextStyle(color: white)),
                      );
                    }),
          ),
        ],
      ),
    );
  }
}
