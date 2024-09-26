// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/bloc/bookingbloc.dart';
import 'package:pwaohyes/bloc/servicebloc.dart';
import 'package:pwaohyes/provider/locationprovider.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/routes.dart';

class AddAddressPageMobileNew extends StatefulWidget {
  const AddAddressPageMobileNew({super.key});

  @override
  State<AddAddressPageMobileNew> createState() =>
      _AddAddressPageMobileNewState();
}

class _AddAddressPageMobileNewState extends State<AddAddressPageMobileNew> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final houseController = TextEditingController();
  final landmarkController = TextEditingController();
  final contactController = TextEditingController();

  @override
  void initState() {
    Initializer.locationProvider.getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 30),
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                BackButton(
                  onPressed: () =>
                      Initializer.providerClass?.addAddressVisibility(false),
                ),
                Helper.allowWidth(15),
                const Text(
                  "Add New Address",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )
              ],
            ),
            Helper.allowHeight(10),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const Icon(
            //       Icons.location_on,
            //       color: Colors.black,
            //     ),
            //     Helper.allowWidth(20),
            //     Expanded(
            //       child: Consumer<LocationProvider>(
            //         builder: (context, value, child) => Text(
            //           Initializer.selectedAdddress2!.locationName ?? "",
            //           style: const TextStyle(
            //             fontSize: 16,
            //             fontWeight: FontWeight.w500,
            //           ),
            //           maxLines: 2,
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // Helper.allowHeight(30),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return "This field is required";
                } else {
                  return null;
                }
              },
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            Helper.allowHeight(10),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: houseController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "This field is required";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                hintText: "House/Flat Number",
                border: OutlineInputBorder(),
              ),
            ),
            Helper.allowHeight(10),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: landmarkController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "This field is required";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                hintText: "Landmark",
                border: OutlineInputBorder(),
              ),
            ),
            Helper.allowHeight(10),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: contactController,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              maxLength: 10,
              buildCounter: (context,
                      {required currentLength,
                      required isFocused,
                      required maxLength}) =>
                  Helper.shrink(),
              validator: (value) {
                if (value!.isEmpty) {
                  return "This field is required";
                } else if (value.length != 10) {
                  return "Please enter a valid mobile number";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                hintText: "Contact Number",
                border: OutlineInputBorder(),
              ),
            ),
            Helper.allowHeight(15),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(
                  Initializer.addressTypes.length,
                  (index) => InkWell(
                        onTap: () {
                          Initializer.addressTypes
                              .forEach((e) => e.isSelected = false);
                          Initializer.addressTypes[index].isSelected = true;
                          Initializer.providerClass!.justChange();
                        },
                        child: Consumer<ProviderClass>(
                          builder: (context, value, child) => Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 6.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Initializer
                                            .addressTypes[index].isSelected!
                                        ? white
                                        : primaryColor),
                                color:
                                    Initializer.addressTypes[index].isSelected!
                                        ? primaryColor
                                        : white,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (Initializer.addressTypes[index].isSelected!)
                                  const Icon(
                                    Icons.check,
                                    color: white,
                                    size: 18,
                                  ),
                                if (Initializer.addressTypes[index].isSelected!)
                                  Helper.allowWidth(5),
                                Text(
                                  Initializer.addressTypes[index].title!,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Initializer
                                              .addressTypes[index].isSelected!
                                          ? white
                                          : primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
            ),
            Helper.allowHeight(30),
            SizedBox(
              width: Helper.width / 4,
              child: BlocConsumer<ServiceBloc, ServiceState>(
                buildWhen: (previous, current) =>
                    current is AddingAddress ||
                    current is AddressAdded ||
                    current is AddressAddingFailed ||
                    current is AddressNotAdded,
                listener: (context, state) {
                  if (state is AddressAdded) {
                    // Helper.pushReplacementNamed(confirmbooking);
                    Initializer.providerClass?.addAddressVisibility(false);
                    context.read<BookingBloc>().add(GetSelectedServiceDetails(
                        id: Initializer.selectedServiceId));
                  }
                },
                builder: (context, state) => MaterialButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (Initializer.userModel.isLoggedIn!) {
                        Map data = {
                          "title": Initializer.addressTypes
                              .where((e) => e.isSelected!)
                              .first
                              .title,
                          "landmark": landmarkController.text,
                          "latitude": Initializer
                              .selectedAdddress2!.latLng!.latitude
                              .toString(),
                          "longitude": Initializer
                              .selectedAdddress2!.latLng!.longitude
                              .toString(),
                          "name": nameController.text,
                          "address_line_1": houseController.text,
                          "contact_number": contactController.text,
                          "city": '',
                        };

                        context.read<ServiceBloc>().add(AddAddress(data: data));
                      } else {
                        Helper.pushReplacementNamed(authuser);
                      }

                      // Initializer.providerClass
                      //     ?.addAddressVisibility(false);
                    }
                  },
                  elevation: 5.0,
                  color: primaryColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
                  child: state is AddingAddress
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CupertinoActivityIndicator(color: white))
                      : const Text("Save Address",
                          style: TextStyle(color: white)),
                ),
              ),
            ),
            Helper.allowHeight(30),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(8.0)),
              height: Helper.height / 1.5,
              child: Consumer<LocationProvider>(
                builder: (context, value, child) => GoogleMap(
                  zoomControlsEnabled: true,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  onMapCreated: (controller) {},
                  initialCameraPosition: CameraPosition(
                      target: Initializer.selectedAdddress2!.latLng!,
                      zoom: 16,
                      bearing: 6.0,
                      tilt: 6.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
