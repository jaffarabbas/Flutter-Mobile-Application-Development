import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rest_api_integration/Models/UserModel.dart';

class UserCard extends StatelessWidget {
  UserModel user;
  UserCard({Key? key,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF626365),
              offset: Offset(0.0, 0.0), //(x,y)
              blurRadius: 3.0,
              spreadRadius: 2.0,
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          title: Text(user.name.toString()),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.username.toString()),
              Text(user.email.toString()),
              Text(user.phone.toString()),
              Text(user.website.toString()),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('Address',style: TextStyle(fontSize: 17,color: Colors.black),),
              ),
              Text(user.address!.city.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
