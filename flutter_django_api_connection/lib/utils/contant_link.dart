
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Links{
  static final url = dotenv.env['URL']!;
  static final String get = url + "getstudent/";
  static final String post = url + "poststudent/";
  static final String update = url + "updatestudent/";
  static final String delete = url + "deletestudent/";
}