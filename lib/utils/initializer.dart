import 'package:pwaohyes/bloc/servicebloc.dart';
import 'package:pwaohyes/model/bookingdatemodel.dart';
import 'package:pwaohyes/model/servicemodel.dart';
import 'package:pwaohyes/model/subcatmodel.dart';
import 'package:pwaohyes/provider/provider.dart';

class Initializer {
  //models
  static ServiceModel serviceModel = ServiceModel();
   static SubCatModel subCatModel = SubCatModel();
  static List<CategoryItems> serviceCategory = <CategoryItems>[];
  //blocs
  static ServiceBloc serviceBloc = ServiceBloc();
  static DateTime now = DateTime.now();
  static DateTime selectedServiceDate = now;
  static DateTime selectedServiceTime = now;
  static List<BookingDateTimeModel> bookingTimeSuggestions = [];
  static List<BookingDateTimeModel> bookingDateSuggestions = [];
  static List<AddresstypeModel> addressTypes = [
    AddresstypeModel(
      title: "Home",
      isSelected: true,
    ),
    AddresstypeModel(
      title: "Work",
      isSelected: false,
    ),
    AddresstypeModel(
      title: "Other",
      isSelected: false,
    ),
  ];

  static List chooseService = [
    {"title": "Installation", "value": "0"},
    {"title": "Repair", "value": "1"},
    {"title": "Support", "value": "2"},
    {"title": "Installation & Support", "value": "3"}
  ];
  static List<String> services = [
    "Home Builders",
    "Electrician",
    "Plumber",
    "AC Mechanic",
    "Appliances Repair",
    "Gardening",
    "Painting",
    "Cleaning And Pest",
    "Interior",
  ];
  static List<String> subServices = [
    "Sub Service",
    "Sub Service",
    "Sub Service",
    "Sub Service",
    "Sub Service",
    "Sub Service",
    "Sub Service",
    "Sub Service",
    "Sub Service",
  ];

  static ProviderClass? providerClass;


}

class AddresstypeModel {
  String? title;
  bool? isSelected;
  AddresstypeModel({this.title, this.isSelected});
}
