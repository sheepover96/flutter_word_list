import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:tutorial/database/database.dart' as db;
import 'package:tutorial/pages/words/add.dart' as wordAdd;
import 'package:tutorial/pages/words/detail.dart' as wordDetail;
import 'package:tutorial/pages/words/newDialog.dart' as wordDialog;

enum BottomNavOptions {
  WordList,
  TagList,
  Quiz,
}

class List extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  var wordList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Example title')),
      body: FutureBuilder(
          future: _fetchItemList(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return _buildItemList();
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: Container(
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.orangeAccent,
        // Icon(Icons.add),
        onPressed: () async {
          // final newWord = await Navigator.of(context).push(_createRoute());
          _openDialog(context);
          // if (newWord != null) {
          //   setState(() {
          //     wordList.add(newWord);
          //   });
          // }
          // Overlay.of(context).insert(_createOverlay());
        },
      ),
    );
  }

  Future<String> initDB() async {
    db.DBClient = new db.DBProvider();
    return Future.value("succeed");
  }

  Future<String> _fetchItemList() async {
    final res = await db.DBClient.db.query("tutorial");
    setState(() {
      wordList = res;
    });
    return Future.value("succeed");
  }

  Widget _buildItemList() {
    return ListView.builder(
        itemCount: wordList.length,
        itemBuilder: (context, index) {
          return _buildItem(wordList[index]['word']);
        });
    // return AnimatedList(
    //     initialItemCount: wordList.length,
    //     itemBuilder: (context, index, animation) {
    //       return _buildItem(wordList[index]['word']);
    //     });
  }

  Widget _buildItem(String word) {
    return GestureDetector(
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Card(
              child: ListTile(
            // title: Text(word, style: TextStyle(fontWeight: FontWeight.bold)),
            title: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: <Widget>[
                  Text(word, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 12),
                  Text(word, style: TextStyle(fontSize: 12.0)),
                ]),
            subtitle: Row(children: <Widget>[
              Text("description description description"),
              SizedBox(width: 12),
              Container(
                child:
                    Text("tag", style: TextStyle(fontWeight: FontWeight.bold)),
                padding: EdgeInsets.only(
                    top: 1.0, left: 5.0, right: 5.0, bottom: 1.0),
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ]),
            trailing: GestureDetector(
              child: Icon(Icons.more_vert),
              onTap: () {
                print("icon tapped");
              },
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return wordDetail.Detail(word: word);
              }));
            },
          )),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: '削除',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => print('Delete'),
            ),
          ],
        ),
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          //   return wordDetail.Detail(word: word);
          // }));
        });
  }

  Route _createRoute() {
    return PageRouteBuilder(
      // pageBuilder: (context, animation, secondaryAnimation) => MyForm(),
      pageBuilder: (context, animation, secondaryAnimation) => wordAdd.Add(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 0.8);
        var end = Offset.zero;
        // var end = Offset(0.0, 0.1);
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      fullscreenDialog: true,
    );
  }

  void _openDialog(BuildContext context) async {
    switch (await showDialog<BottomNavOptions>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              title: Center(child: Text("単語の追加")),
              children: <Widget>[
                SimpleDialogOption(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.create, size: 40.0),
                              Text("入力")
                            ],
                          ),
                          onTap: () {
                            Navigator.pop(context, BottomNavOptions.WordList);
                          },
                        ),
                        GestureDetector(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.photo_camera, size: 40.0),
                              Text("写真")
                            ],
                          ),
                          onTap: () {
                            print("camera");
                          },
                        ),
                        GestureDetector(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.photo, size: 40.0),
                                Text("画像")
                              ],
                            ),
                            onTap: () {
                              print("image");
                            }),
                        // Icon(Icons.photo),
                        // SizedBox(width: 12),
                        // Text("tesutossu")
                      ]),
                ),
              ],
            ))) {
      case BottomNavOptions.WordList:
        final newWord = await Navigator.of(context).push(_createRoute());
      // print("hogehoge");
    }
  }
}
