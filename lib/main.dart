import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpadz/theme/theme_Manager.dart';
import 'package:gpadz/theme/theme_const.dart';

import 'Screens/home.dart';

ThemeManager themeManager = ThemeManager();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    themeManager.removeListener(themeListner);
    super.dispose();
  }

  @override
  void initState() {
    themeManager.addListener(themeListner);
    super.initState();
  }

  themeListner() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      theme: lighTheme,
      darkTheme: DarkTheme,
      themeMode: themeManager.themeMode,
    );
  }
}
