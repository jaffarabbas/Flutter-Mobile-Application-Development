import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dotnet_web_api_integration/model/user_model.dart';
import 'package:flutter_dotnet_web_api_integration/utils/routes/routes_names.dart';
import 'package:flutter_dotnet_web_api_integration/view%20model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
  final userPrefrence = Provider.of<UserViewModel>(context, listen: false);
   return Scaffold(
     appBar: AppBar(
       title: const Text("Home"),
       actions: [
          IconButton(onPressed: () {
            userPrefrence.removeUser().then((value) => {
               Navigator.pushReplacementNamed(context, RoutesName.login)
            });
          }, icon: const Icon(Icons.logout))
       ],
     ),
     body: Column(
      children: [],
     ),
   );
  }
}