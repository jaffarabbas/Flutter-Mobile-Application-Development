import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_mangement/pages/dark_theme_screen.dart';
import 'package:provider_state_mangement/provider/count_provider.dart';
import 'package:provider_state_mangement/provider/favourite_provider.dart';
import 'package:provider_state_mangement/provider/slider_provider.dart';

import 'provider/theme_changer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CountProvider()),
          ChangeNotifierProvider(create: (_) => SliderProvider()),
          ChangeNotifierProvider(create: (_) => FavouriteProvider()),
          ChangeNotifierProvider(create: (_) => ThemeChangerProvider()),
        ],
        child: Builder(
          builder: (context) {
            final themeChanger = Provider.of<ThemeChangerProvider>(context);
            return MaterialApp(
              title: 'Provider Sate Mangement',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: Brightness.light,
              ),
              themeMode: themeChanger.themeMode,
              darkTheme: ThemeData(
                brightness: Brightness.dark,
              ),
              home: DarkThemeScreen(),
            );
          },
        ));
  }
}
