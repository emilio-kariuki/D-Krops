import "package:flutter/material.dart";

class BuildContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  const BuildContainer({Key? key, required this.child, required this.color}) : super(key: key);

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
      padding: const EdgeInsets.all(5), child: child);
  }
}
