import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GetPlacesApi extends StatefulWidget {
  const GetPlacesApi({Key? key}) : super(key: key);

  @override
  State<GetPlacesApi> createState() => GetPlacesApiState();
}

class GetPlacesApiState extends State<GetPlacesApi> {
  TextEditingController _searchController = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = "123456";
  List<dynamic> _places = [];

  void getLanAndLat(String address) async {
    List<Location> location = await locationFromAddress(address);
    print(location.last.latitude);
    print(location.last.longitude);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(() {
      onChange();
    });
  }

  void onChange(){
    if(_sessionToken == null){
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_searchController.text);
  }

  getSuggestion(String query) async {
    String GoogleAPI = "AIzaSyAHR_szCaRefGa7jXvdBN3c2qZJ3O9j45c";
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$query&key=$GoogleAPI&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));

    if(response.statusCode == 200){
      print(response.body.toString());
      setState(() {
        _places = jsonDecode(response.body.toString())['predictions'];
      });
    }else{
      throw Exception('Failed to load suggestions');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text('Get Places API'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                ),
              ),
              Expanded(
                child: ListView.builder(
                itemCount: _places.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => getLanAndLat(_places[index]['description']),
                    title: Text(_places[index]['description']),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}