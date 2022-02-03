import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simaster_wallpaper_generator_flutter/component/button.dart';
import 'package:simaster_wallpaper_generator_flutter/component/colors.dart';
import 'package:simaster_wallpaper_generator_flutter/controller/getx_controllers.dart';
import 'package:simaster_wallpaper_generator_flutter/controller/image_pick.dart';
import 'package:simaster_wallpaper_generator_flutter/controller/scraping_html.dart';
import 'package:simaster_wallpaper_generator_flutter/page/page_template.dart';
import 'package:simaster_wallpaper_generator_flutter/page/wallpaper_widget.dart';
import 'package:universal_html/html.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeContent extends StatelessWidget {
  HomeContent({
    Key? key,
  }) : super(key: key);

  var useDefaultBackground = true.obs;
  var activateGenerate = false.obs;
  var fileName = "".obs;
  ScheduleListController scheduleListController = Get.put(ScheduleListController());
  ImageByteController imagePickController = Get.put(ImageByteController());
  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          minHeight: Get.height * 0.9,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "Aesthetic Simaster Weekly Planner",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: (){
                    launch('https://github.com/karuniaperjuangan/SIMASTER-WALLPAPER-AESTHETIC-GENERATOR/tree/main/Guide');
                  },
                    child: Text("Panduan",
                        style: TextStyle(fontSize: 18, color: kColorRose))),
              ],
            ),
            Container(
              height: 100,
              child: Column(
                children: [
                  SimasterButton(
                    label: "Upload HTML Jadwal Simaster",
                    onPressed: () async{fileName.value= await pickHTML(); activateGenerate.value = true;},
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(()=> Text(fileName.value)),
                  ),
                ],
              ),
            ),
            
            Obx(
              () => activateGenerate.value? SimasterButton(
                label: "Generate",
                onPressed: () {Get.to(()=>PageScaffold(content: WallpaperPreviewContent()));},
                color: Colors.green[300],
              ):Container(),
            )
          ],
        ),
      ),
    );
  }
}
