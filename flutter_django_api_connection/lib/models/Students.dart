// ignore_for_file: avoid_function_literals_in_foreach_calls
class Students{
  late int id;
  late String name;
  late int roll;
  late String city;
  //assiging constructor parameter
  Students({required this.id,required this.name,required this.roll,required this.city});
  //
  Students.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    roll = json['roll'];
    city = json['city'];
  }
  //
  static List<Students> fromJsonList(List<dynamic> jsonList){
    List<Students> student = [];
    jsonList.forEach((element) {
      student.add(Students.fromJson(element));
    });
    return student;
  }
}