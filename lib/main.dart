import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ThemeService {
  final _getStorage = GetStorage();
  final storageKey = 'isDark';
  bool isSavedDarkMode() {
    return _getStorage.read(storageKey) ?? false;
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void saveThemeMode(bool isDarkMode) {
    _getStorage.write(storageKey, isDarkMode);
  }

  void changeThemeMode() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeMode(!isSavedDarkMode());
  }
}

class Themes {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(),
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),
  );
}

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeService().getThemeMode(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('getx theme'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
            ThemeService().changeThemeMode();
          },
          child: Text("enter"),
        ),
      ),
    );
  }
}