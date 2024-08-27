import 'package:pwaohyes/bloc/authbloc.dart';
import 'package:pwaohyes/bloc/locationbloc.dart';
import 'package:pwaohyes/bloc/servicebloc.dart';
import 'package:pwaohyes/model/bookingdatemodel.dart';
import 'package:pwaohyes/model/citiesmodel.dart';
import 'package:pwaohyes/model/otpverifiedmodel.dart';
import 'package:pwaohyes/model/selectedaddressmodel.dart';
import 'package:pwaohyes/model/servicedetailedmodel.dart';
import 'package:pwaohyes/model/servicemodel.dart';
import 'package:pwaohyes/model/subcatmodel.dart';
import 'package:pwaohyes/model/usermodel.dart';
import 'package:pwaohyes/provider/provider.dart';

class Initializer {
  //models
  static CitiesModel citiesModel = CitiesModel(data: []);
  static OtpVerifiedModel otpVerifiedModel = OtpVerifiedModel();
  static ServiceDetailedModel serviceDetailedModel = ServiceDetailedModel();
  static ServiceModel serviceModel = ServiceModel();
  static SubCatModel subCatModel = SubCatModel();
  static List<CategoryItems> serviceCategory = <CategoryItems>[];
  static List<String> carouselItems = [
    "https://scholarlykitchen.sspnet.org/wp-content/uploads/2017/12/iStock-629383254.jpg",
    "https://img.freepik.com/free-vector/digital-marketing-banner_157027-1372.jpg",
    "https://disenowebakus.net/en/images/articles/traditional-online-marketing.jpg",
    "https://static.vecteezy.com/system/resources/previews/001/750/581/non_2x/digital-marketing-and-social-media-banner-vector.jpg",
  ];
  static List<String> serviceImageUrls = [
    "https://images.unsplash.com/photo-1519125323398-675f0ddb6308", // Office setup
    "https://images.unsplash.com/photo-1521791136064-7986c2920216", // Coffee shop
    "https://images.unsplash.com/photo-1485217988980-11786ced9454", // Spa
    "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d", // Barber shop
    "https://images.unsplash.com/photo-1526948128573-703ee1aeb6fa", // Plumber service
    "https://images.unsplash.com/photo-1544005313-94ddf0286df2", // Electrician service
    "https://images.unsplash.com/photo-1516979187457-637abb4f9353", // Wedding planning
    "https://images.unsplash.com/photo-1515378791036-0648a3ef77b2", // Tailoring service
    // "https://images.unsplash.com/photo-1517841905240-472988babdf9", // Security service
    // "https://images.unsplash.com/photo-1542744173-8e7e53415bb0", // Handyman service
  ];

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

  static UserModel userModel = UserModel();

  static AuthBloc authBloc = AuthBloc();

  static SelectedAddressModel? selectedAdddress =
      SelectedAddressModel(loadingState: LoadingState.initial, latLng: null);

  static LocationBloc locationBloc = LocationBloc();
}

class AddresstypeModel {
  String? title;
  bool? isSelected;
  AddresstypeModel({this.title, this.isSelected});
}
