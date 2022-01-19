import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:simaster_wallpaper_generator_flutter/controller/getx_controllers.dart';
import 'package:simaster_wallpaper_generator_flutter/controller/image_pick.dart';
import 'package:simaster_wallpaper_generator_flutter/model/event_model.dart';
import "package:universal_html/html.dart" as html;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';
import 'package:simaster_wallpaper_generator_flutter/component/button.dart';
import 'package:simaster_wallpaper_generator_flutter/component/colors.dart';
import 'package:universal_html/html.dart';

class WallpaperPreviewContent extends StatelessWidget {
  WallpaperPreviewContent({Key? key}) : super(key: key);

  Uint8List? _imageFile;

  Rx<ImageProvider?> imageProvider = Rx<ImageProvider?>(null);

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
              child: Transform.scale(
            scale: 0.8,
            child: Center(
                child: Screenshot(
                    controller: screenshotController,
                    child: Obx(()=> WallpaperWidget(imageProvider: imageProvider.value??AssetImage("assets/DefaultBackground.png"))))),
          )),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          constraints: BoxConstraints(maxWidth: 500),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimasterButton(label: "Ganti Latar", onPressed: () => pickImage()),
              SimasterButton(label: "Download", onPressed: () => download()),
            ],
          ),
        ),
        SizedBox(
          height: 72,
        ),
      ],
    );
  }

  void download() async {
    final result = await screenshotController.capture(
      pixelRatio: 4,
    );
    String downloadName = "wallpaper.png";
    _imageFile = result;
    // Encode our file in base64
    final _base64 = base64Encode(_imageFile!);
    // Create the link with the file
    final anchor =
        AnchorElement(href: 'data:application/octet-stream;base64,$_base64')
          ..target = 'blank';
    // add the name
    if (downloadName != null) {
      anchor.download = downloadName;
    }
    // trigger download
    document.body?.append(anchor);
    anchor.click();
    anchor.remove();
    return;
  }

  void pickImage() async{
  var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if(result == null) return;
    imageProvider.value = MemoryImage(result.files.first.bytes??Uint8List(0));
  }

  
}

class WallpaperWidget extends StatelessWidget {
  WallpaperWidget({Key? key, this.imageProvider = const AssetImage("assets/DefaultBackground.png") }) : super(key: key);

  ImageProvider imageProvider;

  List<String> namaHari = <String>[
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu'
  ];

  ImageByteController imageByteController = Get.find();

  @override
  Widget build(BuildContext context) {
    int counter = 0;
    return ScreenUtilInit(
        designSize: Size(1080, 1920),
        builder: () => SizedBox(
              height: 1920.h,
              width: 1080.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image(
                    image: imageProvider,
                    height: 1920.h,
                    width: 1080.h,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                      top: 40.h,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/TitleBrush.png',
                            height: 210.h,
                          ),
                          Text(
                            "Jadwal Kuliah",
                            style: TextStyle(
                                fontSize: 120.h,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: "Moonbright"),
                          ),
                        ],
                      )),
                  Positioned(
                      top: 261.h,
                      child: SizedBox(
                        height: 1920.h,
                        width: 867.h,
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: (354.23 / 460.35),
                          mainAxisSpacing: 78.h,
                          crossAxisSpacing: 120.h,
                          children: namaHari.map((element) {
                            return DayWidget(
                              namaHari: element,
                              index: counter++,
                            );
                          }).toList(),
                        ),
                      )),
                ],
              ),
            ));
  }



  void pickImage() async{
  ImageByteController imageByteController = Get.find();
  var result = await FilePicker.platform.pickFiles(type: FileType.image);

    imageByteController.imageByte.value = result!.files.first.bytes!.toList();

}
}

class DayWidget extends StatelessWidget {
  DayWidget({Key? key, required this.namaHari, required this.index})
      : super(key: key);

  final String namaHari;
  final int index;

  ScheduleListController scheduleListController = Get.find();


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 460.h,
      width: 355.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
              top: 52.h,
              child: Container(
                width: 355.h,
                height: 415.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26.h),
                    color: kColorGrey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5.h,
                        spreadRadius: 5.h,
                      )
                    ]),
              )),
          Positioned(
            top: 109.h,
            child: SizedBox(
              width: 301.h,
              height: 355.h,
              child: scheduleListController.weekScheduleList[index].isNotEmpty
                  ? SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: scheduleListController.weekScheduleList[index].map((element) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(element.start_time,
                                    style: TextStyle(
                                      letterSpacing: 0,
                                        fontSize: 24.h,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontFamily: "Comfortaa")),
                                SizedBox(width: 8.h,),
                                SizedBox(
                                  width: 230.h,
                                  child: Text(
                                      element.matkul_name +
                                          " (" +
                                          element.kelas_name +
                                          ")",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        letterSpacing: 0,
                                          fontSize: 22.h,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontFamily: "KGRedHands")),
                                ),
                                        SizedBox(height: 8.h,),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                  )
                  : Center(
                      child: Text(
                      "Libur :)\n\n",
                      style: TextStyle(
                          fontSize: 48.h,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: "KGRedHands"),
                    )),
            ),
          ),
          Container(
            width: 212.h,
            height: 92.h,
            color: kColorHeather,
            child: Text(
              namaHari,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 100.h,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontFamily: "Moonbright"),
            ),
          ),
        ],
      ),
    );
  }
}


