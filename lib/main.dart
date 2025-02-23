import 'package:chat_app/chat.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final ColorScheme colorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 20, 17, 177));

final themeData = ThemeData().copyWith(
  colorScheme: colorScheme,
  textTheme: TextTheme().copyWith(
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: colorScheme.onSurface,
    ),
    bodyLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: colorScheme.onSurface,
    ),
  ),
  appBarTheme: AppBarTheme().copyWith(
      backgroundColor: colorScheme.secondary,
      toolbarHeight: 60,
      centerTitle: true),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        theme: themeData,
        home: Chat(),
      ),
    );
  }
}
