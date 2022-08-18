import 'package:flutter_mvvm_architecture/data/response/status.dart';

class ApiResponce<T>{
  Status? status;
  T? data;
  String? message;

  ApiResponce(this.status, this.data, this.message);

  ApiResponce.loading(this.message) : status = Status.LOADING;

  ApiResponce.completed(this.data) : status = Status.COMPLETED;

  ApiResponce.error(this.message) : status = Status.ERROR;

  @override
  String toString(){
    return "Status: $status\n Message: $message\n Data: $data";  
  }
}