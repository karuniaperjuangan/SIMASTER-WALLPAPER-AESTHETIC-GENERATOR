// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:simaster_wallpaper_generator_flutter/model/event_model.dart';
import 'package:html/parser.dart';

import 'getx_controllers.dart';

void pickHTML() async {
  File file;
  final html;

  ScheduleListController scheduleListController = Get.find();
  var result = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: ['html'], allowCompression: false);
  if (result == null) {return;}
  
  List<String> data = [];
  List<Map<String, dynamic>> eventsJsonList = [];
  var decodedFile = utf8.decode(result.files.first.bytes!.toList(), allowMalformed: true).split("</html>")[0] + "</html>";
  print(decodedFile);
  final document = parse( decodedFile);
  var rows =
      document.getElementsByTagName("table")[0].getElementsByTagName("td");
  print(rows);
  rows.map((e) {
    // print(e);//this is only the tag for some reason
    // print(e.innerHtml);//this the inside
    return e.innerHtml;
    /*langsung map sini*/
  }).forEach((element) {
    List<String> gelar=["Ir.","IPM","Dr.","Prof.","Profs.","M.","Drs.","S.","Ph.","A.Md.","A.Ma.","A.P"];
    var isgelar = clean_data().contains_title(element, gelar);
    bool isInt = clean_data().isInteger(element);

    var pushed = element
        .replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ')
        .replaceAll(RegExp('[\\s+]{2,}'), " ")
        .trim(); //remove html tags and whitesapce more than 2
    if (pushed != "-" && !isgelar && !isInt) {
      data.add(pushed); //sini langsung add ke list beuh mantap
    }
  });
  print(data);
  List<String> schedule_data = clean_data().get_schedule(data);
  List<String> subject_data = clean_data().get_event(data);
  //print("Nama Matkul: $subject_data");

  //print("Schedules: $schedule_data");
  //print(schedule_data.length);
  //print(subject_data.length);
  // int day=get_start_day(schedule_data[0]);
  List<Event_Model> events =
      data_mapping().map_data(subject_data, schedule_data);
  for (var i = 0; i < events.length; i++) {
    eventsJsonList.add(events[i].toJson());
    scheduleListController.weekScheduleList[events[i].start_day]
        .add(events[i]);
  }
  for (var i = 0; i < 7; i++) {
    scheduleListController.weekScheduleList[events[i].start_day]
        .sort((a, b) => a.start_time.compareTo(b.start_time));
  }
  //print(eventsJsonList);
}

class clean_data {
  bool isInteger(String input) {
    try {
      int.parse(input);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool contains_title(String element, List<String> gelar) {
    bool condition = false;
    for (int i = 0; i < gelar.length; i++) {
      if (element.contains(gelar[i])) {
        condition = true;
        break;
      }
    }
    return condition;
  }

  List<String> get_schedule(List<String> data) {
    List<String> newdata = [];
    for (int i = 2; i < data.length; i += 3) {
      //print("schedule data being added ${data[i]}");
      newdata.add(data[i]); //adding the data to the new list
    }
    return newdata;
  }

  List<String> get_event(List<String> data) {
    List<String> newdata = [];
    for (int i = 1; i < data.length; i += 3) {
      //print("data event being added ${data[i]}");
      newdata.add(data[i]); //adding the data to the new list
    }
    return newdata;
  }

  static void clean_kode_matkul(List<String> data, int start_index) {
    for (int i = start_index; i < data.length; i += 2) {
      data.removeAt(i);
    }
  }
}

class data_mapping {
  //mapp the data into the data class
  List<Event_Model> map_data(List<String> subject, List<String> schedule) {
    List<Event_Model> mapped_data = [];
    String matkul_name;
    String kelas_name;
    int start_day;
    String start_time;
    String end_time;
    for (int i = 0; i < subject.length; i++) {
      matkul_name = get_nama_matkul(subject[i]);
      kelas_name = get_kelas(subject[i]);
      if (schedule[i].length > 0) {
        start_day = get_start_day(schedule[i]);
        start_time = get_start_time(schedule[i]);
        end_time = get_end_time(schedule[i]);
      } else {
        start_day = 7;
        start_time = "";
        end_time = "";
      }
      Event_Model event = new Event_Model(
          matkul_name: matkul_name,
          kelas_name: kelas_name,
          start_day: start_day,
          start_time: start_time,
          end_time: end_time);
      mapped_data.add(event);
    }
    return mapped_data;
  }
}

// }
int get_start_day(String data) {
  List<String> split_data = data.split(" ");
  String day_with_comma = split_data[0];
  List<String> result_split = day_with_comma.split("");
  result_split.removeLast();
  String result = result_split.join(); // without comma
  switch (result) {
    case "Senin":
      return 0;
    case "Selasa":
      return 1;
    case "Rabu":
      return 2;
    case "Kamis":
      return 3;
    case "Jumat":
      return 4;
    case "Sabtu":
      return 5;
    case "Minggu":
      return 6;
    default:
      return 7;
  }
}

String get_start_time(data) {
  List<String> split_data = data.split(" ");
  List<String> unprocessed_time = split_data[1].split("-");
  String start_time = unprocessed_time[0];
  return start_time;
}

String get_end_time(data) {
  List<String> split_data = data.split(" ");
  List<String> unprocessed_time = split_data[1].split("-");
  String end_time = unprocessed_time[1];
  return end_time;
}

String get_kelas(data) {
  List<String> split_data = data.split(" Kelas: ");
  return split_data[1];
}

String get_nama_matkul(data) {
  List<String> split_data = data.split(" Kelas: ");
  return split_data[0];
}
