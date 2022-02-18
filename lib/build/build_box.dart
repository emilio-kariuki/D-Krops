import "package:flutter/material.dart";

class BuildBox extends StatelessWidget {
  final Widget child;
  // final bool click;
  const BuildBox({Key? key, required this.child, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 9,
      shadowColor: Colors.blueGrey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        padding: const EdgeInsets.all(5),
        height: size.height * 0.05,
        width:  size.width * 0.15,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey[800],
        ),
        child: child,
      ),
    );
  }
}