import 'package:pwaohyes/auth/authscreen.dart';
import 'package:pwaohyes/booking/bookingweb.dart';
import 'package:pwaohyes/bookingaddress/bookingaddaddresswebpart2.dart';
import 'package:pwaohyes/bookingaddress/bookingaddressweb.dart';
import 'package:pwaohyes/location/locationpermissionview.dart';
import 'package:pwaohyes/service/servicehome.dart';
import 'package:pwaohyes/slotbooking/shopview/shopview.dart';
import 'package:pwaohyes/slotbooking/slotbookingview.dart';
import 'package:pwaohyes/slotbooking/slotbookingwebview.dart';

const String locationView = "/serviceLocation";
const String services = "/ohyesservices";
const String bookingOne = "/servicebooking";
const String confirmBooking = "/confirmBooking";
const String authUser = '/authUser';
const String addAddress = '/addAddress';
const String slotBooking = '/slotBooking';
const String slotBookingShop = '/slotBookingShop';

final routes = {
  locationView: (context) => const LocationPermissionView(route: null),
  services: (context) => const ServiceHome(),
  bookingOne: (context) => const BookingWeb(),
  confirmBooking: (context) => const BookingAddressWeb(),
  authUser: (context) => const AuthScreen(),
  addAddress: (context) => const AddAddressPageWeb(),
  slotBooking: (context) => const SlotBookingView(),
  slotBookingShop: (context) => const SlotShopView(id: ''),
};
