// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:finalspace/build/build_appBar.dart';
import 'package:finalspace/build/lottie_contain.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' hide ServiceStatus;
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:location_permissions/location_permissions.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  GoogleMapController? newGoogleMapController;
  double? latitude;
  double? longitude;
  // LatLng ltPosition = LatLng(latitude!, longitude!);
  getPermission() async {
    PermissionStatus permission = await LocationPermissions().requestPermissions();
    ServiceStatus serviceStatus = await LocationPermissions().checkServiceStatus();
    bool isOpened = await LocationPermissions().openAppSettings();
    bool isShown = await LocationPermissions().shouldShowRequestPermissionRationale();
    var locate = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    // print(locate.longitude);
    latitude = locate.latitude;
    longitude = locate.longitude;
  }

  getLocation() {
    getPermission().then((locate) {
      print(longitude);
      print(latitude);
      LatLng ltPosition = LatLng(latitude!, longitude!);
      CameraPosition cameraPosition =
          CameraPosition(target: ltPosition, zoom: 10);
      // ignore: unused_local_variable
      newGoogleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    });
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  List<String> items = [
    'Emilio',
    "Kariuki",
    "Gichuru",
    "Jane",
    "Rosie",
    "Joy",
    "Kennedy",
    "Peter",
    "Rachel"
  ];
  

  String? selectedType;
  // String? selectedVariety;
  File? image;
  ImagePicker picker = ImagePicker();

  void takePhoto(ImageSource source) async {
    final image = await picker.pickImage(source: source);
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 36, 47, 53),
        body: SafeArea(
            child: Column(children: [
          Stack(children: [
            Material(
            elevation: 20,
            shadowColor: Color.fromARGB(255, 97, 94, 94),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
            child: Container(
              height: size.height * 0.14,
              width: size.width,
              decoration: BoxDecoration(
                // border: Border(bottom: BorderSide(color: Colors.blueGrey![800])),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                color: Colors.white,
                shape: BoxShape.rectangle,
              ),
              child: Expanded(
                flex: 1,
                child: Column(
                  children: [
                    SizedBox(height:size.height* 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 17, bottom: 8, top: 8),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: BuildBar(
                              iconUrl: "assets/lottie/backward.json",
                              func: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        SizedBox(width:size.width * 0.06),
                        Column(
                          children: [
                            SizedBox(height:size.height * 0.06),
                            Text("Kenya Space Agency",
                                style: GoogleFonts.redressed(
                                    fontSize: size.width* 0.074, color: Colors.indigo)),
                          ],
                        ),
                        SizedBox(width:size.width * 0.06),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 7, top: 8),
                          child: BuildBar(
                            iconUrl: "assets/lottie/seetings.json",
                            func: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                    
                  ],
                ),
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
          ]
          ),
          SizedBox(height: 5),
          Expanded(
            child: Material(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:Radius.circular(30))),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:  BorderRadius.circular(30),
                ),
                height:size.height * 0.18,
                width: size.width,
                child: Lottie.asset(
                  "assets/lottie/calendar_date.json",
                  animate: true,
                  height: size.height * 0.18,
                  width: size.width * 0.6,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Material(
            elevation: 30,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))),
            child: Container(
              height: size.height*0.5 ,
              width: size.width,
              decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromARGB(255, 224, 149, 243), Color.fromARGB(255, 255, 58, 255)]),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
              ),
              child: Scaffold(
                backgroundColor: Color.fromARGB(255, 255, 255, 255),              
                body: SingleChildScrollView(
                child: Column(
                          children: [
                Padding(
                padding: const EdgeInsets.only(left:8,right: 8,top: 20),
                child: Stack(
                      children: [
                Material(
                elevation: 20,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  //  color: Colors.grey,
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
                        : Text("Select Image"),
                  ),
                  height: size.height * 0.3,
                  width: size.width,
                  decoration: BoxDecoration(
                      boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 163, 165, 165).withOpacity(0.6),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
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
                                //border: Border.all(color: Color.fromARGB(255, 182, 36, 116),width:1 ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
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
                                              takePhoto(ImageSource.gallery);
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
                          size: 30,
                          color: image != null ? Colors.white : Colors.black)))
                      ],
                    ),
                          ),
                
                    //the code to add the dropdown menu in the app
                    Container(
                      decoration: BoxDecoration(
                         boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 163, 165, 165).withOpacity(0.4),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 5),
                        child: Material(
                          elevation:20,
                          // shadowColor: Color.fromARGB(255, 34, 43, 48),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                          child: Container(
                                    decoration:
                            BoxDecoration(
                             
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
                                        fontSize: 22, color: Colors.indigo)),
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
                                color: Color.fromARGB(255, 0, 0, 0),
                                height: 5,
                                thickness: 0.4,
                              )),
                        ),
                      ],
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 20, bottom: 8, top: 5),
                      child: Row(
                        children: [
                          LottieContain(lottieUrl: "assets/lottie/select.json"),
                          SizedBox(width: size.width * 0.06),
                          DropdownButton2(
                            value: selectedType,
                            onChanged: (value) {
                              setState(() {
                                selectedType = value as String;
                                print(selectedType);
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
                            buttonPadding:
                                const EdgeInsets.only(left: 14, right: 14),
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
                            itemPadding:
                                const EdgeInsets.only(left: 14, right: 14),
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
                ],
                            ),
                ),
                        ),
                      ),
                    ),
                    //the code to add the map\
                    Padding(
                      padding: const EdgeInsets.only(left:8,right:8,top:5),
                      child: Material(
                        elevation: 20,
                        shadowColor: Color.fromARGB(255, 163, 165, 165),
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
                              fontSize: 22, color: Colors.indigo)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Divider(
                            color: Color.fromARGB(255, 0, 0, 0),
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
                        mapType: MapType.hybrid,
                        myLocationEnabled: true,
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: true,
                        initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                          getLocation();
                        },
                      ),
                    )),
                    height: size.height * 0.3,
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
                )
                ),
                ),
                SizedBox(height: size.height * 0.02),
                SizedBox(
                          height: size.height * 0.06,
                          width: size.width* 0.5,
                          child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                  color: Color.fromARGB(255, 1, 160, 160), 
                                  width: 2.0,
                              ),
                          ),
                      ),
                  ),
                  child: Text('Submit'),
                  onPressed: _makeGetRequest,
                        ),
                ),
                SizedBox(height: size.height * 0.02),
                ],
                ),
              )
              )
            ),
          ),
          
        ]
        )
        )
        );
  }
  _makeGetRequest() async {
    final url = Uri.parse(_localhost());
    Response response = await post(url,
    headers: {"content-type":"application/json"},
    body: jsonEncode({
          "type": selectedType,
          "x_coordinate": latitude,
          "y_coordinate": longitude
   })
    );
  }
  String _localhost() {
    if (Platform.isAndroid)
      return 'http://127.0.0.1:5000/';
    else // for iOS simulator
      return 'http://localhost:5000/';
  }
}
