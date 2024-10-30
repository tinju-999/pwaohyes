import 'package:pwaohyes/auth/authscreen.dart';
import 'package:pwaohyes/booking/bookinghome.dart';
import 'package:pwaohyes/booking/bookingweb.dart';
import 'package:pwaohyes/bookingaddress/bookingaddaddresswebpart2.dart';
import 'package:pwaohyes/bookingaddress/bookingaddresshome.dart';
import 'package:pwaohyes/bookingaddress/bookingaddressweb.dart';
import 'package:pwaohyes/location/locationpermissionview.dart';
import 'package:pwaohyes/service/servicehome.dart';
import 'package:pwaohyes/review/addreviewpage.dart';
import 'package:pwaohyes/slotbooking/shopview/shopview.dart';
import 'package:pwaohyes/slotbooking/slotbookingview.dart';
import 'package:pwaohyes/subservice/subservicehome.dart';

const String locationView = "/chooselocation";
const String allservices = "/allservices";
const String bookingOne = "/servicebooking";
const String confirmbooking = "/confirmbooking";
const String authuser = '/authuser';
const String addaddress = '/addaddress';
const String slotbooking = '/slotbooking';
const String slotbookingshop = '/slotbookingshop';
const String bookingHome = '/booking';
const String subservices = '/subservices';
const String bookingaddress = '/bookingaddress';
const String addReviewPage = '/addReviewPage';

final routes = {
  locationView: (context) => const LocationPermissionView(route: null),
  allservices: (context) => const ServiceHome(),
  bookingOne: (context) => const BookingWeb(),
  confirmbooking: (context) => const BookingAddressWeb(),
  authuser: (context) => const AuthScreen(),
  addaddress: (context) => const AddAddressPageWeb(),
  slotbooking: (context) => const SlotBookingView(),
  slotbookingshop: (context) => const SlotShopView(),
  bookingHome: (context) => const BookingHome(catId: '', title: ''),
  subservices: (context) => const SubServiceHome(),
  bookingaddress: (context) => const BookingAddress(),
  addReviewPage: (context) => const AddReviewPage(),
};
