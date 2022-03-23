// ignore_for_file: unused_local_variable, deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:finalspace/build/build_appBar.dart';
import 'package:finalspace/build/lottie_contain.dart';
import 'package:finalspace/build/lottie_container.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' hide ServiceStatus;
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' hide LocationAccuracy;
import 'package:lottie/lottie.dart' hide Marker;
import 'package:permission_handler/permission_handler.dart';
import 'package:location_permissions/location_permissions.dart'
    hide PermissionStatus;
import 'package:restart_app/restart_app.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime? today;
  DateTime? plantation;

  final heights = TextEditingController();
  final variety = TextEditingController();
  final row = TextEditingController();
  final column = TextEditingController();

  bool loading = false;
  GoogleMapController? newGoogleMapController;
  Completer<GoogleMapController> _controller = Completer();
  // double latitude = -122.085749655962;
  // double longitude = 37.42796133580664;
  // double lat = -122.085749655962;
  // double long = 37.42796133580664;
  double? latitude;
  double? longitude;
  double? lat;
  double? long;
  Location location = Location();

  // LatLng ltPosition = LatLng(latitude!, longitude!);
  //function to get the current location of the user
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
      return Future.error(ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Location services are disabled.'),
          duration: Duration(milliseconds: 600))));
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Location permissions are denied'),
            duration: Duration(milliseconds: 600))));
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.'),
          duration: Duration(milliseconds: 600))));
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var locate = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // var locate = await Geolocator.getCurrentPosition(
    //   desiredAccuracy: LocationAccuracy.best,
    // );
    // print(locate.longitude);
    latitude = locate.latitude;
    longitude = locate.longitude;
    lat = locate.latitude;
    long = locate.longitude;
    print(latitude);
    print(longitude);
    setState(() {
      var latlong = LatLng(locate.latitude, locate.longitude);
      var _cameraPosition = CameraPosition(target: latlong, zoom: 10.0);
      if (_controller != null)
        newGoogleMapController
            ?.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
    });
  }

  // getLocation() {
  //   getPermission().then((locate) {
  //     print(longitude);
  //     print(latitude);
  //     LatLng ltPosition = LatLng(latitude!, longitude!);
  //     CameraPosition cameraPosition =
  //         CameraPosition(target: ltPosition, zoom: 10);
  //     // ignore: unused_local_variable
  //     newGoogleMapController
  //         ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  //   });
  // }

  //create a marker fot the map
  // ignore: prefer_final_fields
  List<Marker> _markers = [
    Marker(
        markerId: MarkerId('marker_2'),
        position: LatLng(36.959988288487104, -0.398163985596978),
        draggable: true),
  ];
  // _markers.add(
  //     Marker(
  //       markerId: MarkerId('marker_2'),
  //       position: LatLng(_position.target.latitude, _position.target.longitude),
  //       draggable: true,
  //       icon: bitmapIcon,
  //     ),
  //   );

//the method to update the location in the marker

  void _updatePosition(CameraPosition _position) async {
    latitude = _position.target.latitude;
    longitude = _position.target.longitude;
    print(latitude);
    print(longitude);
    print(
        'inside updatePosition ${_position.target.latitude} ${_position.target.longitude}');
    Marker marker =
        _markers.firstWhere((p) => p.markerId == MarkerId('marker_2'));

    final bitmapIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(4, 4)), "assets/lottie/loc.png");
    _markers.remove(marker);
    _markers.add(
      Marker(
        markerId: MarkerId('marker_2'),
        position: LatLng(_position.target.latitude, _position.target.longitude),
        draggable: true,
        // icon: bitmapIcon,
      ),
    );
    setState(() {});
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(36.959988288487104, -0.398163985596978),
    zoom: 14.4746,
  );
  List<String> items = [
    'arrow-roots',
    'avocado',
    'bananas',
    "beans",
    "cabbage",
    'capcicum',
    'coriander',
    "carrots",
    'coffee',
    'forest',
    "green grams",
    "kales",
    'maize',
    'napier grass',
    "onions",
    "peas",
    "potatoes",
    'pumpkins',
    "spinach",
    "sorghum",
    'sweet-potatoes',
    'tomatoes',
    'tea',
    'other'
  ];
  List<String> itemz = [
    'Agro-forestry',
    "Broadcasting",
    "Fallowing",
    "Tranplanting",
    "Direct-seeding",
    "ploughing",
    "Harrowing",
  ];

  String? selectedType;
  String? selectedMethod;
  File? image;
  ImagePicker picker = ImagePicker();
  bool isActivated = false;
  bool isValidate = false;

  void takePhoto(ImageSource source) async {
    final image = await picker.pickImage(
        source: source, maxHeight: 480, maxWidth: 640, imageQuality: 50);
    try {
      if (image == null) return;

      final imageTempo = File(image.path);
      setState(() {
        this.image = imageTempo;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    // ignore: todo
    // TODO: implement initState
    super.initState();
    setState(() {
      print('Refreshed');
    });
  }

  @override
  Widget build(BuildContext context) {
    // final DateFormat formatter_1 = DateFormat('yyyy-MM-dd');
    // final String formatted_1 = formatter_1.format(today!);
    // FocusManager.instance.primaryFocus!.unfocus();
    // SystemChannels.textInput.invokeMethod('TextInput.hide');
    // setState(() {
    // });
    final size = MediaQuery.of(context).size;
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
        // backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
            child: SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(children: [
          Stack(children: [
            Material(
                elevation: 20,
                // shadowColor: Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Container(
                  height: size.height * 0.07,
                  width: size.width,
                  decoration: BoxDecoration(
                    // // border: Border(bottom: BorderSide(color: Colors.blueGrey![800])),
                    // borderRadius: BorderRadius.only(
                    //     bottomLeft: Radius.circular(20),
                    //     bottomRight: Radius.circular(20)),
                    color: Color.fromARGB(255, 14, 14, 20),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    children: [
                      // SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(
                          //       left: 18, bottom: 8, top: 8),
                          //   child: GestureDetector(
                          //     onTap: () => Navigator.pop(context),
                          //     child: BuildBar(
                          //       iconUrl: "assets/lottie/backward.json",
                          //       func: () {
                          //         Navigator.pop(context);
                          //       },
                          //     ),
                          //   ),
                          // ),

                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: size.height * 0.015),
                                Text("D-Krops",
                                    style: GoogleFonts.redressed(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 33,
                                        color: Color.fromARGB(
                                            255, 224, 225, 228))),
                              ],
                            ),
                          ),
                          // SizedBox(width: 10),
                          // Padding(
                          //   padding: const EdgeInsets.only(bottom: 7, top: 8,right:10),
                          //   child: BuildBar(
                          //     iconUrl: "assets/lottie/seetings.json",
                          //     func: () {
                          //       Navigator.pop(context);
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                )),
            Positioned(
              top: 3,
              right: 25,
              child: Lottie.asset("assets/lottie/celebration.json",
                  height: 200.1, width: 100.1, animate: true),
            ),
            Positioned(
              top: 3,
              left: 25,
              child: Lottie.asset("assets/lottie/celebration.json",
                  height: 200.1, width: 100.1, animate: true),
            ),
          ]),
          SizedBox(height: 10),
          // Expanded(
          //   child: Material(
          //     color: Colors.blueGrey[800],
          //     elevation: 10,
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(30),
          //             topRight: Radius.circular(30))),
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.blueGrey[800],
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //       height: size.height * 0.1,
          //       width: size.width,
          //       child: Lottie.asset(
          //         "assets/lottie/calendar_date.json",
          //         animate: true,
          //         height: size.height * 0.02,
          //         width: size.width * 0.4,
          //         fit: BoxFit.fill,
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 5),
          // Material(
          //   elevation: 30,
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.only(
          //           topLeft: Radius.circular(30),
          //           topRight: Radius.circular(30))),
          //   child: Container(
          //       height: size.height * 0.5,
          //       width: size.width,
          //       decoration: BoxDecoration(
          //           // gradient: LinearGradient(
          //           //     begin: Alignment.topLeft,
          //           //     end: Alignment.bottomRight,
          //           //     colors: [
          //           //       Color.fromARGB(255, 224, 149, 243),
          //           //       Color.fromARGB(255, 255, 58, 255)
          //           //     ]),
          //           borderRadius: BorderRadius.only(
          //               topLeft: Radius.circular(30),
          //               topRight: Radius.circular(30))),
          //       child: Scaffold(
          //           backgroundColor: Color.fromARGB(255, 206, 206, 206),
          //           body: SingleChildScrollView(
          //             child:
          //           ))),
          // ),
          //Lottie.asset('assets/lottie/line.json',height:10,width:size.width),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 6),
                child: Stack(
                  children: [
                    Material(
                      color: Color.fromARGB(255, 36, 47, 53),
                      elevation: 20,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        //  color: Colors.grey,
                        // color: Color.fromARGB(255, 36, 47, 53),
                        child: Center(
                          child: image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    image!,
                                    width: size.width,
                                    height: size.height * 0.32,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Text("Select Image",
                                  style: GoogleFonts.roboto(
                                      fontSize: 20, color: Colors.white)),
                        ),
                        height: size.height * 0.3,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[800],
                          // boxShadow: [
                          //   BoxShadow(
                          //     color:
                          //         Color.fromARGB(255, 255, 255, 255)
                          //             .withOpacity(0.6),
                          //     spreadRadius: 5,
                          //     blurRadius: 7,
                          //     offset: Offset(0,
                          //         3), // changes position of shadow
                          //   ),
                          // ],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Color.fromARGB(255, 14, 14, 20), width: 1),
                        ),
                        // image: image
                      ),
                    ),
                    Positioned(
                        top: 5,
                        right: 5,
                        child: IconButton(
                            onPressed: () {
                              // takePhoto(ImageSource.camera);
                              setState(() {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => Container(
                                    width: size.width,
                                    height: size.height * 0.2,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Color.fromARGB(255, 14, 14, 20),
                                          width: 1),
                                      //border: Border.all(color: Color.fromARGB(255, 182, 36, 116),width:1 ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      contentPadding: EdgeInsets.all(5),
                                      title: const Text('choose image from: '),
                                      content: SingleChildScrollView(
                                        child: ListBody(children: [
                                          ListTile(
                                            selectedColor: Colors.grey,
                                            onTap: () {
                                              takePhoto(ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                            leading: Icon(Icons.camera,
                                                color: Colors.blueGrey[900]),
                                            title: Text("Camera"),
                                          ),
                                          ListTile(
                                            selectedColor: Colors.grey,
                                            onTap: () {
                                              setState(() {
                                                takePhoto(ImageSource.gallery);
                                                Navigator.pop(context);
                                              });
                                            },
                                            leading: Icon(Icons.layers,
                                                color: Colors.blueGrey[900]),
                                            title: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    takePhoto(
                                                        ImageSource.gallery);
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Text("Gallery")),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                );
                              });
                            },
                            icon: Icon(Icons.add_a_photo,
                                size: 35,
                                color: image != null
                                    ? Colors.white
                                    : Colors.black)))
                  ],
                ),
              ),

              //the code to add the dropdown menu in the app
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                  child: Material(
                    elevation: 20,
                    // shadowColor: Color.fromARGB(255, 34, 43, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 14, 14, 20), width: 1),
                          color: Colors.blueGrey[800],
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, bottom: 4),
                                  child: Text("Type of crop",
                                      style: GoogleFonts.redressed(
                                          fontSize: 23, color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Divider(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      height: 5,
                                      thickness: 0.4,
                                    )),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, bottom: 8, top: 5),
                            child: Row(
                              children: [
                                LottieContain(
                                    lottieUrl: "assets/lottie/select.json"),
                                SizedBox(width: size.width * 0.06),
                                DropdownButton2(
                                  hint: Text("Select",
                                      style: GoogleFonts.roboto(
                                          color:
                                              Color.fromARGB(255, 49, 49, 49))),
                                  value: selectedType,
                                  onChanged: (value) {
                                    setState(() {
                                      getLocation();
                                      selectedType = value as String;
                                      print(selectedType);
                                      isActivated = true;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 18,
                                  iconEnabledColor: Colors.indigo,
                                  iconDisabledColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  buttonHeight: size.height * 0.06,
                                  buttonWidth: size.width * 0.65,
                                  items: items
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: GoogleFonts.notoSerif(
                                                  fontSize: 18,
                                                  color: Colors.indigo,
                                                  fontWeight: FontWeight.w600),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  buttonPadding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1,
                                      color: Color.fromARGB(255, 180, 182, 184),
                                    ),
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  buttonElevation: 5,
                                  itemHeight: 40,
                                  itemPadding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  dropdownMaxHeight: 200,
                                  dropdownWidth: 200,
                                  dropdownPadding: EdgeInsets.only(top: 3),
                                  dropdownDecoration: BoxDecoration(
                                    color: Color.fromARGB(255, 238, 235, 235),
                                  ),
                                  dropdownElevation: 5,
                                  scrollbarRadius: const Radius.circular(20),
                                  scrollbarThickness: 10,
                                  scrollbarAlwaysShow: true,
                                  offset: const Offset(18, -50),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, bottom: 8, top: 5),
                            child: Row(
                              children: [
                                LottieContain(
                                    lottieUrl: "assets/lottie/balls.json"),
                                SizedBox(width: size.width * 0.06),
                                Flexible(
                                  flex: 1,
                                  child: TextFormField(
                                    //keyboardType: TextInputType.multiline,
                                    // style: TextStyle(height:10),

                                    decoration: InputDecoration(
                                        errorText: isValidate
                                            ? 'Value Can\'t Be Empty'
                                            : null,
                                        isDense: true,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(15, 20, 15, 15),
                                        // contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        // icon: Icon(Icons.person,size:30,color: Colors.black),
                                        filled: true,
                                        hintStyle:
                                            TextStyle(color: Colors.grey[800]),
                                        focusColor: Colors.red,
                                        hintText: "Identify",
                                        // suffixText: "10",
                                        // prefixIcon: Icon(Icons.mail,color: Colors.blueGrey[900]),
                                        fillColor: Colors.grey[200]),
                                    controller: variety,
                                  ),
                                ),
                                SizedBox(width: 15),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, bottom: 4),
                                  child: Text("Spacing",
                                      style: GoogleFonts.redressed(
                                          fontSize: 23, color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Divider(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      height: 5,
                                      thickness: 0.4,
                                    )),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, bottom: 8, top: 5),
                            child: Row(
                              children: [
                                LottieContain(
                                    lottieUrl: "assets/lottie/row.json"),
                                SizedBox(width: size.width * 0.06),
                                Flexible(
                                  flex: 1,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    // keyboardType: TextInputType.multiline,
                                    // style: TextStyle(height:10),

                                    decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(15, 20, 15, 15),
                                        // contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        // icon: Icon(Icons.person,size:30,color: Colors.black),
                                        filled: true,
                                        hintStyle:
                                            TextStyle(color: Colors.grey[800]),
                                        focusColor: Colors.red,
                                        hintText: "Row",
                                        // suffixText: "10",
                                        // prefixIcon: Icon(Icons.mail,color: Colors.blueGrey[900]),
                                        fillColor: Colors.grey[200]),
                                    controller: row,
                                  ),
                                ),
                                SizedBox(width: 15),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, bottom: 8, top: 5),
                            child: Row(
                              children: [
                                LottieContain(
                                    lottieUrl: "assets/lottie/columns.json"),
                                SizedBox(width: size.width * 0.06),
                                Flexible(
                                  flex: 1,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ], //
                                    // keyboardType: TextInputType.multiline,
                                    // style: TextStyle(height:10),

                                    decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(15, 20, 15, 15),
                                        // contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        // icon: Icon(Icons.person,size:30,color: Colors.black),
                                        filled: true,
                                        hintStyle:
                                            TextStyle(color: Colors.grey[800]),
                                        focusColor: Colors.red,
                                        hintText: "Column",
                                        // suffixText: "10",
                                        // prefixIcon: Icon(Icons.mail,color: Colors.blueGrey[900]),
                                        fillColor: Colors.grey[200]),
                                    controller: column,
                                  ),
                                ),
                                SizedBox(width: 15),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 20, bottom: 4),
                                  child: Text("Features",
                                      style: GoogleFonts.redressed(
                                          fontSize: 23, color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    child: Divider(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      height: 5,
                                      thickness: 0.4,
                                    )),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, bottom: 8, top: 5),
                            child: Row(
                              children: [
                                LottieContain(
                                    lottieUrl: "assets/lottie/shovel.json"),
                                SizedBox(width: size.width * 0.06),
                                DropdownButton2(
                                  hint: Text("Planting method",
                                      style: GoogleFonts.roboto(
                                          color:
                                              Color.fromARGB(255, 49, 49, 49))),
                                  value: selectedMethod,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedMethod = value as String;
                                      print(selectedMethod);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  iconSize: 18,
                                  iconEnabledColor: Colors.indigo,
                                  iconDisabledColor:
                                      Color.fromARGB(255, 255, 255, 255),
                                  buttonHeight: size.height * 0.06,
                                  buttonWidth: size.width * 0.65,
                                  items: itemz
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: GoogleFonts.notoSerif(
                                                  fontSize: 18,
                                                  color: Colors.indigo,
                                                  fontWeight: FontWeight.w600),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  buttonPadding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      width: 1,
                                      color: Color.fromARGB(255, 180, 182, 184),
                                    ),
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  buttonElevation: 5,
                                  itemHeight: 40,
                                  itemPadding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  dropdownMaxHeight: 200,
                                  dropdownWidth: 200,
                                  dropdownPadding: EdgeInsets.only(top: 3),
                                  dropdownDecoration: BoxDecoration(
                                    color: Color.fromARGB(255, 238, 235, 235),
                                  ),
                                  dropdownElevation: 5,
                                  scrollbarRadius: const Radius.circular(20),
                                  scrollbarThickness: 10,
                                  scrollbarAlwaysShow: true,
                                  offset: const Offset(18, -50),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, bottom: 8, top: 5),
                            child: Row(
                              children: [
                                LottieContain(
                                    lottieUrl: "assets/lottie/height.json"),
                                SizedBox(width: size.width * 0.06),
                                Flexible(
                                  flex: 1,
                                  child: TextFormField(
                                    // focusNode:FocusManager.instance.primaryFocus!.unfocus(),

                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ], //
                                    // keyboardType: TextInputType.multiline,
                                    // style: TextStyle(height:10),

                                    decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                            EdgeInsets.fromLTRB(15, 20, 15, 15),
                                        // contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        // icon: Icon(Icons.person,size:30,color: Colors.black),
                                        filled: true,
                                        hintStyle:
                                            TextStyle(color: Colors.grey[800]),
                                        focusColor: Colors.red,
                                        hintText: "Height",
                                        // suffixText: "10",
                                        // prefixIcon: Icon(Icons.mail,color: Colors.blueGrey[900]),
                                        fillColor: Colors.grey[200]),
                                    controller: heights,
                                  ),
                                ),
                                SizedBox(width: 15),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //the code to add the map\
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                child: Material(
                    color: Colors.blueGrey[800],
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 20),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text("Plantation Date",
                                      style: GoogleFonts.redressed(
                                          fontSize: 22, color: Colors.white)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20.0, right: 20.0),
                                      child: Divider(
                                        color:
                                            Color.fromARGB(255, 247, 247, 247),
                                        height: 5,
                                        thickness: 0.4,
                                      )),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 20),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Text("Pick Date",
                                        style: GoogleFonts.redressed(
                                            fontSize: 22, color: Colors.white)),
                                  ),
                                  SizedBox(width: size.width * 0.15),
                                  Icon(Icons.forward, color: Colors.white),
                                  SizedBox(width: size.width * 0.15),
                                  LottieContainer(
                                      func: () {
                                        HapticFeedback.lightImpact();
                                        setState(() {
                                          showDatePicker(
                                                  builder: (context, child) {
                                                    return Theme(
                                                      data: Theme.of(context)
                                                          .copyWith(
                                                        colorScheme:
                                                            ColorScheme.light(
                                                          primary: Color.fromARGB(
                                                              255,
                                                              221,
                                                              165,
                                                              9), // header background color
                                                          onPrimary: Colors
                                                              .black, // header text color
                                                          onSurface: Color.fromARGB(
                                                              255,
                                                              0,
                                                              0,
                                                              0), // body text color
                                                        ),
                                                        textButtonTheme:
                                                            TextButtonThemeData(
                                                          style: TextButton
                                                              .styleFrom(
                                                            primary: Colors
                                                                .red, // button text color
                                                          ),
                                                        ),
                                                      ),
                                                      child: child!,
                                                    );
                                                  },
                                                  context: context,
                                                  initialDate:
                                                      today ?? DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2023))
                                              .then((value) {
                                            setState(() {
                                              today = value;
                                              today = DateFormat.yMMM()
                                                  .format(today!) as DateTime?;
                                            });
                                          });
                                        });
                                      },
                                      lottieUrl: "assets/lottie/icon.json"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {});
                                },
                                child: Text(today.toString(),
                                    style: GoogleFonts.redressed(
                                        fontSize: 22, color: Colors.white)),
                              ),
                            ),
                          ],
                        ))),
              ),
              //the code to show the map
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                child: Material(
                    color: Colors.blueGrey[800],
                    elevation: 20,
                    // shadowColor: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 20),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text("Choose Location",
                                      style: GoogleFonts.redressed(
                                          fontSize: 22, color: Colors.white)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      margin: const EdgeInsets.only(
                                          left: 20.0, right: 20.0),
                                      child: Divider(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        height: 5,
                                        thickness: 0.4,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                //  color: Colors.grey,
                                child: Center(
                                    child: Scaffold(
                                  body: GoogleMap(
                                    gestureRecognizers: <
                                        Factory<OneSequenceGestureRecognizer>>{
                                      Factory<OneSequenceGestureRecognizer>(
                                        () => EagerGestureRecognizer(),
                                      ),
                                    },
                                    onCameraMove: ((_position) =>
                                        _updatePosition(_position)),
                                    markers: Set<Marker>.of(_markers),
                                    mapType: MapType.hybrid,
                                    myLocationButtonEnabled: true,
                                    myLocationEnabled: true,
                                    tiltGesturesEnabled: true,
                                    // zoomControlsEnabled: true,
                                    zoomGesturesEnabled: false,
                                    initialCameraPosition: _kGooglePlex,
                                    onMapCreated:
                                        (GoogleMapController controller) {
                                      _controller.complete(controller);
                                      // getLocation();
                                      // getPermission();
                                    },
                                  ),
                                )),
                                height: size.height * 0.33,
                                width: size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white),
                                // image: image
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 5,
                          left: 15,
                          child: Lottie.asset("assets/lottie/celebration.json",
                              height: 200.1, width: 100.1, animate: true),
                        ),
                      ],
                    )),
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.06,
                    width: size.width * 0.36,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 14, 14, 20)),
                        // MaterialStateProperty<Color?>?
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                              color: Color.fromARGB(255, 14, 14, 20),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      child: Text('Close',
                          style: GoogleFonts.roboto(fontSize: 20)),
                      onPressed: () => exit(0),
                    ),
                  ),
                  SizedBox(width: size.width * 0.08),
                  loading
                      ? CircularProgressIndicator()
                      //the code to show the dialog box
                      : SizedBox(
                          height: size.height * 0.06,
                          width: size.width * 0.36,
                          child: ElevatedButton(
                            // disabledColor: isActivated ? Colors.grey : Color.fromARGB(255, 14, 14, 20),
                            // color: Color.fromARGB(255, 14, 14, 20),
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(30)),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 14, 14, 20)),
                              // MaterialStateProperty<Color?>?
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: BorderSide(
                                    color: Color.fromARGB(255, 14, 14, 20),
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            child: Text('Submit',
                                style: GoogleFonts.roboto(
                                    fontSize: 20, color: Colors.white)),
                            onPressed: () async {
                              if (selectedType == null &&
                                  image == null &&
                                  today == null) {
                                Fluttertoast.showToast(
                                    backgroundColor: Colors.red,
                                    msg: "Ensure all the fields are filled",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    fontSize: 16.0);
                              } else {
                                setState(() {
                                  loading = true;
                                });
                                await _makeGetRequest();
                                loading
                                    ? CircularProgressIndicator()
                                    : await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            title: Text(""),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Lottie.asset(
                                                    "assets/lottie/successful.json",
                                                    height: size.height * 0.21),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  },
                                                  child: Text('Successful',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 27,
                                                          color: Colors.black)),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                // Future.delayed(const Duration(milliseconds: 1670),
                                //     () => Navigator.of(context).pop());
                                setState(() {
                                  loading = false;
                                });
                                selectedType = null;
                                selectedMethod = null;
                              }
                            },
                          ),
                        ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ]),
      ),
    )));
  }

  _makeGetRequest() async {
    final String variety_1 = variety.text;
    final String row_1 = row.text;
    final String column_1 = column.text;
    final String height_1 = heights.text;
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(today!);
    final String date_1 = today.toString();

    final bytes = image?.readAsBytesSync();
    String imageEncoded = base64Encode(bytes!);
    var dio = Dio();
    var formData = FormData.fromMap({
      //coordinates for the map
      "x_coordinate": latitude,
      "y_coordinate": longitude,
      // coordinates for the geometry
      "latitude": latitude,
      "longitude": longitude,
      //the image taken in the application
      "image": imageEncoded,
      //the crop type choosen
      "type": selectedType,
      //the variety of the crop taken
      "variety": variety_1,
      //the height of the crop
      "height": height_1,
      //the plantation method
      "plantation_method": selectedMethod,
      //the spacing of the crops in the field
      "row": row_1,
      "column": column_1,
      //the date of plantation of the crop in the field
      "date_of_plantation": formatted,
    });
    //api that sends the data to the server
    var response = await dio
        .post('https://iggresapps.dkut.ac.ke/crop_mapping.php', data: formData);
    print(response);
    // getLocation();
    loading = false;
  }
}
