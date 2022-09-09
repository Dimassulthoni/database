import 'package:database/list_kontak.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'model/kontak.dart';
import 'form_kontak.dart';
import 'database/db_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: listKontakPage(),
    );
  }
}
