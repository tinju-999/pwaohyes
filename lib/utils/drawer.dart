import 'package:flutter/material.dart';
import 'package:pwaohyes/utils/constants.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: white,
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Image.asset(
                logo,
                fit: BoxFit.contain,
                width: 160,
                height: 80,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.phone,
              color: black,
            ),
            title: const Text(
              "Call +91 7034 4443 03",
              style: TextStyle(color: black),
            ),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(
              Icons.start,
              color: black,
            ),
            title: const Text(
              "Get Started",
              style: TextStyle(color: black),
            ),
            onTap: () => {},
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: black,
            ),
            title: const Text(
              "About Us",
              style: TextStyle(color: black),
            ),
            onTap: () => {},
          )
        ],
      ),
    );
  }
}
