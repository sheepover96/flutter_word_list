import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tutorial/database/database.dart' as db;

import 'package:dropdown_search/dropdown_search.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

const TagList = <DropdownMenuItem>[
  DropdownMenuItem(child: Text("One"), value: 1),
  DropdownMenuItem(child: Text("Two"), value: 2),
  // "One",
  // "Two",
  // "Three",
  // "One",
  // "Two",
  // "Three",
  // "One",
  // "Two",
  // "Three"
];

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  static const platform = const MethodChannel('dictionary_search');
  String _word = '';
  String tag = "One";

  Future<void> _searchDictionary(String queryWord) async {
    String cameraLevel;
    try {
      print("call");
      await platform.invokeMethod(
          'searchDictionary', <String, dynamic>{"queryWord": queryWord});
    } on PlatformException catch (e) {
      print(e);
      cameraLevel = "Failed to get camera";
    }
    print("finish");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("単語追加"),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 20, left: 40, right: 40),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: "単語",
                ),
                maxLength: 20,
                maxLengthEnforced: false,
                onChanged: (String value) {
                  setState(() {
                    _word = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "読み方"),
                onChanged: (String value) {
                  setState(() {
                    _word = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "意味"),
                maxLines: 5,
                onChanged: (String value) {
                  setState(() {
                    _word = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              SearchableDropdown.single(
                label: Text("タグ"),
                items: TagList,
                value: tag,
                onChanged: (value) {
                  print(value);
                  // setState(() {
                  //   tag = value;
                  // });
                },
                onClear: () {},
                isExpanded: true,
              ),
              // DropdownSearch(
              //     label: "タグ",
              //     // maxHeight: 12.0,
              //     searchBoxDecoration: InputDecoration(labelText: "タグ"),
              //     mode: Mode.BOTTOM_SHEET,
              //     showSearchBox: true,
              //     showClearButton: true,
              //     // showSelectedItem: true,
              //     // onFind: (String s) {
              //     //   return TagList.map((String value) {}).toList();
              //     // },
              //     items: TagList.map((String value) {
              //       return value;
              //     }).toList()),
              // DropdownButtonFormField(
              //     value: tag,
              //     items: TagList.map<DropdownMenuItem<String>>((String value) {
              //       print(value);
              //       return DropdownMenuItem(value: value, child: Text(value));
              //     }).toList(),
              //     onChanged: (String newValue) {
              //       setState(() {
              //         tag = newValue;
              //       });
              //     }),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () async {
                    final wordInfo = new db.WordInfo(word: _word, meaning: "");
                    db.DBClient.insertWord(wordInfo);
                    Navigator.of(context).pop(_word);
                    final res = await db.DBClient.db.query("tutorial");
                  },
                  child: Text('リスト追加', style: TextStyle(color: Colors.white)),
                ),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    print("search");
                    this._searchDictionary(_word);
                  },
                  child: Text('検索', style: TextStyle(color: Colors.white)),
                ),
              ),
              // Container(
              //   width: double.infinity,
              //   child: FlatButton(
              //     onPressed: () {
              //       Navigator.of(context).pop();
              //     },
              //     child: Text('キャンセル'),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
