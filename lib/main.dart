import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QRReader',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home'   : ( BuildContext contex ) => HomePage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
    );
  }
}