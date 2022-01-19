
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simaster_wallpaper_generator_flutter/component/colors.dart';

class SimasterButton extends StatelessWidget {
  SimasterButton({Key? key, required this.label, required this.onPressed, this.color}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String label;
  final VoidCallback onPressed;
  Color? color= kColorRose;

  


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color??kColorRose,
          boxShadow: [
            BoxShadow(
              color: color??kColorRose.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 20,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),
        ),
    );
  }
}