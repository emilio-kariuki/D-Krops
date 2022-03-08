import 'package:finalspace/build/build_container.dart';
import "package:flutter/material.dart";
import 'package:lottie/lottie.dart';


class LottieContainer extends StatelessWidget {
  final String lottieUrl;
  final Function() func;
  const LottieContainer({Key? key, required this.lottieUrl, required this.func}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: GestureDetector(
      onTap: func,
      child: BuildContainer(
        color: Color.fromARGB(255, 189, 139, 31),
        child: Lottie.asset(lottieUrl),
      ),
    ));
  }
}
