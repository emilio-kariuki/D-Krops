import "package:flutter/material.dart";

class BuildContain extends StatelessWidget {
  final Widget child;
  final Color color;
  const BuildContain({Key? key, required this.child, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
        color : color,
      ),
      
      height: 50,
      width: 50,
      child: child);
  }
}