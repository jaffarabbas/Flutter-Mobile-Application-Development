// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_delivery_app/dataSource/datamap.dart';
import 'package:food_delivery_app/widgits/cartegoriesHeader.dart';
import 'package:food_delivery_app/widgits/currentLocation.dart';
import 'package:food_delivery_app/widgits/favorateProductCollection.dart';
import 'package:food_delivery_app/widgits/foodCategories.dart';
import 'package:food_delivery_app/widgits/otherFoodsCollecttion.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentBottomNavigationIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: Color(0xfff5f5f5),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            color: Colors.red,
            icon: Icon(
              Icons.grid_view_rounded,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          CircleAvatar(
            radius: 17,
            backgroundColor: Colors.red,
            child: CircleAvatar(
              radius: 14,
              backgroundImage: AssetImage('assets/Images/admin.jpeg'),
            ),
          ),
          SizedBox(
            width: 30,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //  mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CurrentLocation(locationName: 'Denpasar, IDN'),
            FoodCategory(),
            SizedBox(
              height: 10,
            ),
            FoodCategoryHeader(headings: ['Favorite ', 'Foods']),
            FavorateAppCollection(),
            FoodCategoryHeader(headings: ['Other ', 'Foods']),
            OtherFoodCollection(),
          ],
        ),
      ),
      drawer: Drawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => currentBottomNavigationIndex = index),
        currentIndex: currentBottomNavigationIndex,
        type: BottomNavigationBarType.fixed,
        // fixedColor: Colors.red,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
        // selectedItemColor: Colors.red,
        // unselectedItemColor: Colors.red,
        selectedIconTheme: IconThemeData(color: Colors.red),
        unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.solidCompass,
              size: 20,
            ),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.solidBookmark,
              size: 20,
            ),
            label: 'bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.history,
              size: 20,
            ),
            label: 'history',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_active_sharp,
              size: 25,
            ),
            label: 'notification',
          ),
        ],
      ),
    );
  }
}
