import 'package:flutter/material.dart';
import 'package:lab_crud/components/bottom_navigation.dart';
import 'package:lab_crud/view/home_page.dart';
import 'package:lab_crud/view/update_contact_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const BottomNavigation(),
        'home': (context)=> const HomeContacts(),
        'edit': (context)=> const UpdateContact(),
        
      },
    );
  }
}

