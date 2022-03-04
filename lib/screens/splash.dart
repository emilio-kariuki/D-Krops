import 'package:finalspace/screens/Home.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            ));
            
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
        Positioned(
            bottom: size.height * 0.31,
            right: size.width * 0.1,
            child:
              Text("Small Scale Crop Mapping",
                  style: GoogleFonts.roboto(fontSize: 30, color: Colors.white)),
            ),
        
      ]),
    );
  }
}