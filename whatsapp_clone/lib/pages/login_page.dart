// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, non_constant_identifier_names, unnecessary_string_interpolations, avoid_print, prefer_if_null_operators
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/dataSource/dataMap.dart';
import 'package:whatsapp_clone/utils/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool stateOfContainer = false;
  late int mapLength = DataSource.Datamap()["friendsList"].length == null ? -1 : DataSource.Datamap()["friendsList"].length;
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userImageController = TextEditingController();

  ValidateFeilds(BuildContext context) async {
    print("length : $mapLength");
    print(DataSource.Datamap()["friendsList"]);
    if (_formKey.currentState!.validate()) {
      setState(() {
        stateOfContainer = true;
        DataSource.Datamap().putIfAbsent(mapLength, () => {
          "userName": userNameController.text.toString(),
          "userImage": userImageController.text.toString()
        });
        print("length : $mapLength \n${mapLength++}");
        print(DataSource.Datamap()["friendsList"][0]["userName"]);
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, AppRoutes.homeRoute);
      setState(() {
        stateOfContainer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 150),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Icon(
                  FontAwesomeIcons.whatsapp,
                  size: 80,
                  color: Colors.green,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Welcome $name',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800]),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: userNameController,
                        decoration: InputDecoration(
                            hintText: 'Enter Username', labelText: 'Username'),
                        onChanged: (value) {
                          name = value;
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: userImageController,
                        decoration: InputDecoration(
                          hintText: 'Enter Image Link',
                          labelText: 'Image Link',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Image cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Material(
                  color:
                      stateOfContainer ? Colors.green[300] : Colors.green[400],
                  borderRadius: BorderRadius.circular(
                    stateOfContainer ? 80 : 12,
                  ),
                  child: InkWell(
                    onTap: () => ValidateFeilds(context),
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      height: 50,
                      width: stateOfContainer ? 50 : 150,
                      alignment: Alignment.center,
                      child: stateOfContainer
                          ? Icon(
                              Icons.done,
                              color: Colors.white,
                            )
                          : Text(
                              'LOGIN HERE',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: stateOfContainer ? 12 : 15,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
