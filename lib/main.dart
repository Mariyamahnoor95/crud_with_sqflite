import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keepnotes/pages/note_list.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String title = 'Notes SQLite';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.blueGrey.shade900,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent,
        elevation: 0
        ),
      ),
      home: NotesPage(),
      routes: {
    "/list":(context)=>NotesPage(),
      },
    );

  }
}


