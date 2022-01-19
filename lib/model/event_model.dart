// ignore_for_file: non_constant_identifier_names

class Event_Model{
  String matkul_name;
  String kelas_name;
  int start_day;
  String start_time;
  String end_time;

  
  Event_Model({required this.matkul_name,required this.start_day,required this.start_time,required this.end_time,required this.kelas_name});
  
  
  Map<String, dynamic> toJson() {
    return {
      'matkul_name': matkul_name,
      'kelas_name': kelas_name,
      'start_day': start_day,
      'start_time': start_time,
      'end_time': end_time,
    };
  }
}