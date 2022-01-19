import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simaster_wallpaper_generator_flutter/component/button.dart';
import 'package:simaster_wallpaper_generator_flutter/component/colors.dart';
import 'package:simaster_wallpaper_generator_flutter/controller/getx_controllers.dart';
import 'package:simaster_wallpaper_generator_flutter/controller/image_pick.dart';
import 'package:simaster_wallpaper_generator_flutter/controller/scraping_html.dart';
import 'package:simaster_wallpaper_generator_flutter/page/page_template.dart';
import 'package:simaster_wallpaper_generator_flutter/page/wallpaper_widget.dart';

class HomeContent extends StatelessWidget {
  HomeContent({
    Key? key,
  }) : super(key: key);

  var useDefaultBackground = true.obs;
  var activateGenerate = false.obs;
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
                  onTap: (){},
                    child: Text("Panduan",
                        style: TextStyle(fontSize: 18, color: kColorRose))),
              ],
            ),
            SimasterButton(
              label: "Upload HTML Jadwal Simaster",
              onPressed: () {pickHTML(); activateGenerate.value = true;},
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
