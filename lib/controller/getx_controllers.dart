
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:simaster_wallpaper_generator_flutter/model/event_model.dart';

class ScheduleListController extends GetxController{
  var weekScheduleList = (List< List<Event_Model> >.generate(8, (i) => [])).obs;
}

class ImageByteController extends GetxController{
  RxList<int> imageByte = <int>[].obs;
}