import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bottom_navigation/providers/changeBottomNavigationProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final changeBottomNavigationIndex =
        Provider.of<ChnageBottomNavgationProvider>(context, listen: true);

    List<Widget> widgitList = [
      Text('sad1'),
      Text('sad2'),
      Text('sad3'),
    ];
    return Scaffold(
      body: Container(
        child: Center(
          child: widgitList[changeBottomNavigationIndex.index],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          changeBottomNavigationIndex.setIndex(index);
          print(changeBottomNavigationIndex.index);
        },
        currentIndex: changeBottomNavigationIndex.index,
        items:const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.verified_user), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'Phone'),
        ],
      ),
    );
  }
}
