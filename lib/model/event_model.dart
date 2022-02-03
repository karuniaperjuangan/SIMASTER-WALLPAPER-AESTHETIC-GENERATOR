// ignore_for_file: non_constant_identifier_names

class Event_Model{
  String matkul_name;
  String kelas_name;
  int start_day;
  String start_time;
  int second_day;
  String second_time;

  
  Event_Model({required this.matkul_name,required this.start_day,required this.start_time,required this.kelas_name, required this.second_day, required this.second_time});
  
  
  Map<String, dynamic> toJson() {
    return {
      'matkul_name': matkul_name,
      'kelas_name': kelas_name,
      'start_day': start_day,
      'start_time': start_time,
      'second_day': second_day,
      'second_time': second_time,
    };
  }
}