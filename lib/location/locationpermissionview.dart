import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/location/locationmobileview.dart';
import 'package:pwaohyes/location/locationwebview.dart';
import 'package:pwaohyes/utils/screensize.dart';

class LocationPermissionView extends StatefulWidget {
  final dynamic route;
  const LocationPermissionView({super.key, required this.route});

  @override
  State<LocationPermissionView> createState() => _LocationPermissionViewState();
}

class _LocationPermissionViewState extends State<LocationPermissionView> {
  @override
  void initState() {
    // Initializer.authBloc.fetchCities();
      context.read<AuthBloc>().add(FetchCities());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenSize(
      mobileView: const LocationMobileView(),
      tabView: LocationWebView(route: widget.route),
      webView: LocationWebView(route: widget.route),
    );
  }

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
}
