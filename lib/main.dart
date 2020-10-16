import 'package:Splash/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      builder: (context,_) => Stack(
        children: [
          MaterialApp(
            title: 'Splash',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              accentColor: Colors.teal,
            ),
            home: Home(),
          ),
          Align(
            alignment: Alignment.topCenter,
                      child: ConnectionStatusBar(
              height: 40.0,
            ),
          ),
        ],
      ),
    );
  }
}
