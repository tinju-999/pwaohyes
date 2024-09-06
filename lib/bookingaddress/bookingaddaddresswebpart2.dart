// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pwaohyes/bloc/servicebloc.dart';
import 'package:pwaohyes/provider/provider.dart';
import 'package:pwaohyes/utils/constants.dart';
import 'package:pwaohyes/utils/helper.dart';
import 'package:pwaohyes/utils/initializer.dart';
import 'package:pwaohyes/utils/routes.dart';

class AddAddressPageWeb extends StatefulWidget {
  const AddAddressPageWeb({super.key});

  @override
  State<AddAddressPageWeb> createState() => _AddAddressPageWebState();
}

class _AddAddressPageWebState extends State<AddAddressPageWeb> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final houseController = TextEditingController();
  final landmarkController = TextEditingController();
  final contactController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 30),
        color: white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      BackButton(
                        onPressed: () => Initializer.providerClass
                            ?.addAddressVisibility(false),
                      ),
                      Helper.allowWidth(15),
                      const Text(
                        "Add New Address",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      )
                    ],
                  ),
                  Helper.allowHeight(30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.black,
                      ),
                      Helper.allowWidth(20),
                      const Expanded(
                        child: Text(
                          "Karukutty, Angamali - 686512",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Helper.allowHeight(30),
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
                                Initializer.addressTypes[index].isSelected =
                                    true;
                                Initializer.providerClass!.justChange();
                              },
                              child: Consumer<ProviderClass>(
                                builder: (context, value, child) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18, vertical: 6.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Initializer.addressTypes[index]
                                                  .isSelected!
                                              ? white
                                              : primaryColor),
                                      color: Initializer
                                              .addressTypes[index].isSelected!
                                          ? primaryColor
                                          : white,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      if (Initializer
                                          .addressTypes[index].isSelected!)
                                        const Icon(
                                          Icons.check,
                                          color: white,
                                          size: 18,
                                        ),
                                      if (Initializer
                                          .addressTypes[index].isSelected!)
                                        Helper.allowWidth(5),
                                      Text(
                                        Initializer.addressTypes[index].title!,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Initializer
                                                    .addressTypes[index]
                                                    .isSelected!
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
                          Helper.pushReplacementNamed(confirmBooking);
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
                                "latitude": '',
                                "longitude": '',
                                "name": nameController.text,
                                "address_line_1": houseController.text,
                                "contact_number": contactController.text,
                                "city": '',
                              };
                              Initializer.serviceBloc.addAddress(data);
                            } else {
                              Helper.pushReplacementNamed(authUser);
                            }

                            // Initializer.providerClass
                            //     ?.addAddressVisibility(false);
                          }
                        },
                        elevation: 5.0,
                        color: primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 14),
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
                ],
              ),
            ),
            Helper.allowWidth(20),
            Expanded(
              flex: 6,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(8.0)),
                  height: Helper.height / 1.5,
                  child: Container()
                  // GoogleMap(
                  //   mapType: MapType.hybrid,
                  //   onMapCreated: (controller) {},
                  //   initialCameraPosition:
                  //       const CameraPosition(target: LatLng(10.1926, 76.3869)),
                  // ),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
