import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simaster_wallpaper_generator_flutter/component/button.dart';
import 'package:simaster_wallpaper_generator_flutter/component/colors.dart';
import 'package:simaster_wallpaper_generator_flutter/controller/scraping_html.dart';

import 'home_content.dart';

class PageScaffold extends StatelessWidget {
  PageScaffold({Key? key, required this.content}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  Widget content;
  

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
              image: AssetImage('assets/Background.jpg'), fit: BoxFit.cover),
        ),
        child: Center(
            child: Container(
          width: Get.width * 0.9,
          height: Get.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.grey[50]!.withOpacity(0.7),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 50,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(),
              content,
            ],
          ),
        )),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

