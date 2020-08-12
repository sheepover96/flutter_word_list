import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:tutorial/database/database.dart' as db;
import 'package:tutorial/pages/global/mainPage.dart' as mainPage;
import 'package:tutorial/pages/words/list.dart' as wordList;

void main() async {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  db.DBClient = new db.DBProvider();
  await db.DBClient.init();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Tutorial',
    theme: ThemeData(
      fontFamily: "MPLUS1",
      primaryColor: Colors.orange,
    ),
    home: mainPage.MainPage(),
    // home: Scaffold(
    //   body: wordList.List(),
    // ),
  ));
}
