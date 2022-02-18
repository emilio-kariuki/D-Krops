import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:finalspace/build/build_appBar.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                      height: size.height * 0.15,
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
                              SizedBox(width: 20),
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
            ]))));
  }
}
