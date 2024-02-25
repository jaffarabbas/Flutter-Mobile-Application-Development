// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_book_app/pages/home_page.dart';
import 'package:flutter_book_app/widgits/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentBottomNavigationIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.rubik().fontFamily,
      ),
      home: Material(
        child: Scaffold(
          backgroundColor: AppTheme.primaryBackgroundColor,
          appBar: AppBar(
            toolbarHeight: 100,
            leadingWidth: 70,
            backgroundColor: AppTheme.primaryBackgroundColor,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Builder(
                builder: (context) => IconButton(
                  icon: SvgPicture.asset(
                    "assets/Icons/short_text.svg",
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 35.0),
                child: Icon(
                  Icons.search,
                  color: AppTheme.primaryFontcolor,
                  size: 25,
                ),
              ),
            ],
          ),
          //********Body********
          body: HomePage(),
          drawer: Drawer(),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) =>
                setState(() => currentBottomNavigationIndex = index),
            currentIndex: currentBottomNavigationIndex,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w600,
            ),
            selectedIconTheme: IconThemeData(color: AppTheme.primaryColor),
            unselectedIconTheme: IconThemeData(color: Colors.grey[400]),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_filled,
                  size: 20,
                ),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.bookmark,
                  size: 20,
                ),
                label: 'bookmark',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_bag_rounded,
                  size: 20,
                ),
                label: 'shoppingbag',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.tune,
                  size: 25,
                ),
                label: 'setting',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
