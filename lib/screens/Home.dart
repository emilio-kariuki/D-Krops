import 'dart:io';
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:finalspace/build/build_appBar.dart';
import 'package:finalspace/build/lottie_contain.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

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
  List<String> itemz = [
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
  String? selectedVariety;
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
            child: SingleChildScrollView(
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
                  height: size.height * 0.13,
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
                            SizedBox(width: 10),
                            Text("Kenya Space Agency",
                                style: GoogleFonts.redressed(
                                    fontSize: 25, color: Colors.indigo)),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, bottom: 8, top: 8),
                              child: BuildBar(
                                iconUrl: "assets/lottie/seetings.json",
                                func: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              WavyAnimatedText(
                                'Date',
                                textStyle: GoogleFonts.redressed(
                                    fontSize: 29,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.w600),
                                speed: const Duration(milliseconds: 400),
                              ),
                            ],
                            totalRepeatCount: 100,
                            pause: const Duration(milliseconds: 1000),
                            displayFullTextOnTap: true,
                            stopPauseOnTap: true,
                          ),
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
          ]),
          Lottie.asset(
            "assets/lottie/calendar_date.json",
            animate: true,
            height: size.height * 0.17,
            width: size.width * 0.5,
            fit: BoxFit.fill,
          ),
          
        ]
        )
        )
        ));
  }
}
