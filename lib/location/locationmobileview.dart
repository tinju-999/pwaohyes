import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/common/footer.dart';
import 'package:pwaohyes/common/header.dart';
import 'package:pwaohyes/model/citiesmodel.dart';
import 'package:pwaohyes/model/selectedaddressmodel.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/drawer.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/preferences.dart';
import 'package:pwaohyes/utils/routes.dart';

class LocationMobileView extends StatefulWidget {
  const LocationMobileView({super.key});

  @override
  State<LocationMobileView> createState() => _LocationMobileViewState();
}

class _LocationMobileViewState extends State<LocationMobileView> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const CustomDrawer(),
      key: scaffoldKey,
      body: ListView(
        children: [
          Header(scaffoldKey: scaffoldKey),
          Helper.allowHeight(10),
          BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (previous, current) =>
                  current is FetchingCitiesData ||
                  current is CitiesDataFetched ||
                  current is CitiesDataNotFetched ||
                  current is FetchingCitiesDataError,
              builder: (context, state) => state is CitiesDataFetched ||
                      Initializer.citiesModel.data!.isNotEmpty
                  ? LocationMobileContentView(
                      data: Initializer.citiesModel.data!,
                      // route: widget.route,
                    )
                  : state is FetchingCitiesData &&
                          Initializer.citiesModel.data!.isEmpty
                      ? const Center(child: CupertinoActivityIndicator())
                      : Helper.shrink()),
          Helper.allowHeight(10),
          const Footer(),
        ],
      ),
    );
  }
}

class LocationMobileContentView extends StatelessWidget {
  final List<CityData>? data;
  // final dynamic route;
  //required this.route
  const LocationMobileContentView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 18),
      color: white,
      child: Column(
        children: [
          const Text(
            "Choose From Popular Cities",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const Text(
            "Select a city for provide out cutting edge service to you",
            style: TextStyle(
                fontSize: 14,
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
                  spacing: 30.0,
                  runSpacing: 14.0,
                  children: List.generate(
                      data!.length,
                      (index) => InkWell(
                            onTap: () async {
                              Initializer.selectedAdddress =
                                  SelectedAddressModel(
                                      locationName: data![index].name,
                                      loadingState: LoadingState.success,
                                      cityId: data![index].sId,
                                      latLng: LatLng(
                                          double.parse(data![index].lat!),
                                          double.parse(data![index].lng!)));
                              await Preferences.setLocation(jsonEncode(
                                  Initializer.selectedAdddress!.toJson()));
                              Helper.pushReplacementNamed(services);
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
                                      maxHeight: 90,
                                      maxWidth: 90,
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
                                          width: 140,
                                          height: 140,
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
        ],
      ),
    );
  }
}
