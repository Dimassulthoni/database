import 'dart:ffi';

import 'package:flutter/material.dart';
import 'form_kontak.dart';
import 'database/db_helper.dart';
import 'model/kontak.dart';

class listKontakPage extends StatefulWidget {
  const listKontakPage({Key? key}) : super(key: key);

  @override
  _listKontakPageState createState() => _listKontakPageState();
}

class _listKontakPageState extends State<listKontakPage> {
  List<Kontak> listKontak = [];
  Dbhelper db = Dbhelper();

  @override
  void initState() {
    _getAllKontak();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("kontak App"),
        ),
      ),
      body: ListView.builder(
          itemCount: listKontak.length,
          itemBuilder: (context, index) {
            Kontak kontak = listKontak[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 50,
                ),
                title: Text(
                    '${kontak.name}'
                ),
                subtitle: ,
              ),
            );
          }),
    );
  }
}
