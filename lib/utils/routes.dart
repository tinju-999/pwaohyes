import 'package:pwaohyes/location/locationpermissionview.dart';
import 'package:pwaohyes/service/servicehome.dart';

const String LocationView = "/serviceLocation";
const String Services = "/ohyesservices";

final routes = {
  LocationView: (context) => const LocationPermissionView(route: null),
  Services: (context) => const ServiceHome(),
};
