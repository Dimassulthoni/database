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
                title: Text('${kontak.name}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Email.${kontak.email}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Phone:${kontak.mobileno}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Company:${kontak.company}"),
                    )
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            _openFormEdit(kontak);
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            AlertDialog hapus = AlertDialog(
                              title: Text("information"),
                              content: Container(
                                height: 100,
                                child: Column(
                                  children: [
                                    Text(
                                        "Yakin ingin menghapus data ${kontak.name}")
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    _deleteKontak(kontak, index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ya"),
                                ),
                                TextButton(
                                  child: Text("tidak"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                            showDialog(
                                context: context, builder: (context) => hapus);
                          })
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openformCrate();
        },
      ),
    );
  }

  Future<void> _getAllKontak() async {
    var list = await db.getAllKontak();
    setState(() {
      listKontak.clear();
      list!.forEach((Kontak) {
        listKontak.add(Kontak.fromMap(Kontak));
      });
    });
  }

  Future<void> _deleteKontak(Kontak kontak, int position) async {
    await db.deleteKontak(kontak.id!);
    setState(() {
      listKontak.removeAt(position);
    });
  }

  Future<void> _openformCrate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormKontak()));
    if (result == 'save') {
      await _getAllKontak();
    }
  }

  Future<void> _openFormEdit(Kontak kontak) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormKontak(kontak: kontak)));
    if (result == 'update') {
      await _getAllKontak();
    }
  }
}
