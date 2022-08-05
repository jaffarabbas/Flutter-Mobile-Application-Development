
import 'package:flutter/material.dart';
import 'package:integratejsonfile/model/Product.dart';
import 'package:integratejsonfile/services/populateJson.dart';

class HomePgae extends StatefulWidget {
  const HomePgae({Key? key}) : super(key: key);

  @override
  State<HomePgae> createState() => _HomePgaeState();
}

class _HomePgaeState extends State<HomePgae> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: FutureBuilder<List<Product>>(
          future: PopulateJson.PopulateJsonData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].name.toString()),
                    subtitle: Text(snapshot.data![index].description.toString()),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}