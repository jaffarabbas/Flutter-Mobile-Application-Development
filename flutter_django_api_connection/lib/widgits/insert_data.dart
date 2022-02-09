import 'package:flutter/material.dart';
import 'package:flutter_django_api_connection/services/fetchApi.dart';

class InsertData extends StatefulWidget {
  const InsertData({ Key? key }) : super(key: key);

  @override
  _InsertDataState createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController rollcontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();

  Future<void> PostData() async {
  ApiService _apiServices = ApiService();
  Future<bool> flag = _apiServices.postStudent(namecontroller.text,int.parse(rollcontroller.text),citycontroller.text);
  if(await flag){
    print("doneeeeeeeeeee");
    namecontroller.clear();
    rollcontroller.clear();
    citycontroller.clear();
  }else{
    print("not done");
  }
}
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:2),
      width: double.infinity,
      // height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // width: 300,
            child: TextField(
              controller: namecontroller,
              decoration: InputDecoration(
                hintText:  "Ener Student Name"
              ),
            ),
          ),
          Container(
            // width: 300,
            child: TextField(
              controller: rollcontroller,
              decoration: InputDecoration(
                hintText:  "Ener Student roll"
              ),
            ),
          ),
          Container(
            // width: 300,
            child: TextField(
              controller: citycontroller,
              decoration: InputDecoration(
                hintText:  "Ener Student city"
              ),
            ),
          ),
          InkWell(
            onTap: PostData,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              color: Colors.blueAccent,
              child: const Text(
                'Insert',
                style: TextStyle(fontSize: 15,color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}