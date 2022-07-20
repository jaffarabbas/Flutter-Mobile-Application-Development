import 'package:intl/intl.dart';

class CommitHelperClass{
  //function to get current date and time
  static String getCurrentDateTime(){
    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('dd-MM-yyyy hh:mm:ss').format(now);
    return formattedDateTime;
  }

  static String commitMessage(String message){
    return "$message at ${getCurrentDateTime()}";
  }
}