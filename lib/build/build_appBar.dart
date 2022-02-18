// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:finalspace/build/build_box.dart';
import "package:flutter/material.dart";
import 'package:lottie/lottie.dart';
// import 'package:space/build/build_box.dart';

class BuildBar extends StatelessWidget {
  final String iconUrl;
  final Function() func;
  
  const BuildBar({Key? key, required this.iconUrl, required this.func, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: GestureDetector(
        onTap: func,
        child: BuildBox(
          // click: click,
          child: Lottie.asset(iconUrl, width: size.width * 0.2),
        ),
      ),
    );
  }
}