import 'package:flutter/material.dart';

Widget NewDialog() {
  return SimpleDialog(
    title: Text("単語の登録"),
    children: <Widget>[
      Text("キーボード入力"),
      Text("カメラで撮って入力"),
    ],
  );
}

// Future<void> _askedToLead() async {
//   switch (await showDialog<Department>(
//       context: context,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title: const Text('Select assignment'),
//           children: <Widget>[
//             SimpleDialogOption(
//               onPressed: () {
//                 Navigator.pop(context, Department.treasury);
//               },
//               child: const Text('Treasury department'),
//             ),
//             SimpleDialogOption(
//               onPressed: () {
//                 Navigator.pop(context, Department.state);
//               },
//               child: const Text('State department'),
//             ),
//           ],
//         );
//       })) {
//     case Department.treasury:
//       // Let's go.
//       // ...
//       break;
//     case Department.state:
//       // ...
//       break;
//   }
// }
