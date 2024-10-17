import 'package:flutter/material.dart';
import 'package:flutter_gorouter/project/routes/router_confriguation.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.go('/about');
                },
                child: Text('About'),
              )
            ],
          )),
    );
  }
}
