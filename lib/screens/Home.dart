import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:finalspace/build/build_appBar.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  String ?selectedType;
  String ?selectedVariety;
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
            child: SingleChildScrollView(child: Column(children: [
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
                        flex : 1,
                        child: Column(
                          children: [
                            Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:17,bottom:8,top: 8),
                                child: GestureDetector(
                                  onTap:()=> Navigator.pop(context),
                                  child: BuildBar(
                                    iconUrl: "assets/lottie/backward.json",
                                    func: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text("Kenya Space Agency",style: GoogleFonts.redressed(fontSize:25,color: Colors.indigo)),
                              Padding(
                                padding: const EdgeInsets.only(left:20,bottom:8,top: 8),
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
             Stack(
                        children: [
                          Material(
                            elevation: 10,
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
                                borderRadius: BorderRadius.circular(20), color: Colors.white),
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
                                icon: Icon(
                                  Icons.add_a_photo,
                                  size: 30,
                                  color: image !=  null ? Colors.white : Colors.black
                            )
                       )
                   )
                ],
              ),
              
            ]
          )
        )
      )
    );
  }
}
