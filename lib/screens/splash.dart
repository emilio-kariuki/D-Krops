import 'package:background_location/background_location.dart';
import 'package:finalspace/screens/Home.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Fluttertoast.showToast(
          backgroundColor: Colors.red,
          msg: "Location Services are disabled.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Fluttertoast.showToast(
            backgroundColor: Colors.red,
            msg: "Location permissions denied.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Fluttertoast.showToast(
          backgroundColor: Colors.red,
          msg:
              "Location permissions are permanently denied, we cannot request permissions.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var locate = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void location() async {
    BackgroundLocation.setAndroidNotification(
      title: 'Background service is running',
      message: 'Background location in progress',
      icon: 'asssets/images/logo.png',
    );
    //await BackgroundLocation.setAndroidConfiguration(1000);
    await BackgroundLocation.startLocationService(distanceFilter: 20);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      location();
      //getLocation();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: ((context) => Home())));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(239, 35, 156, 255),
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        Lottie.asset("assets/lottie/update_splash.json",
            width: size.width, height: size.height * 2),
        Positioned.fill(
          top: size.height * 0.31,
          // right: size.width * 0.40,
          child: Align(
            alignment: Alignment.center,
            child: Text("D-krops",
                style: GoogleFonts.roboto(
                    fontSize: MediaQuery.of(context).size.width * 0.07,
                    color: Colors.white)),
          ),
        ),
      ]),
    );
  }
}
