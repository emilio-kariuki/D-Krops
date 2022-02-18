import "package:flutter/material.dart";


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 36, 47, 53),
      body:SafeArea(
        child:SingleChildScrollView(
          child: Column(
            children: [
              
            ],),
        )
      )
    );
  }
}