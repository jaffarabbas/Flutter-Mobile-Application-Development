import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_state_mangement/provider/theme_changer.dart';

class DarkThemeScreen extends StatefulWidget {
  DarkThemeScreen({Key? key}) : super(key: key);

  @override
  State<DarkThemeScreen> createState() => _DarkThemeScreenState();
}

class _DarkThemeScreenState extends State<DarkThemeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChangerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dark Theme Screen'),
      ),
      body: Column(
        children: [
          RadioListTile<ThemeMode>(
              title: Text('Light'),
              value: ThemeMode.light,
              groupValue: themeChanger.themeMode,
              onChanged: themeChanger.setThemeMode
          ),
          RadioListTile<ThemeMode>(
              title: Text('Dark'),
              value: ThemeMode.dark,
              groupValue: themeChanger.themeMode,
              onChanged: themeChanger.setThemeMode
          ),
          RadioListTile<ThemeMode>(
              title: Text('System'),
              value: ThemeMode.system,
              groupValue: themeChanger.themeMode,
              onChanged: themeChanger.setThemeMode
          ),
        ],
      ),
    );
  }
}
