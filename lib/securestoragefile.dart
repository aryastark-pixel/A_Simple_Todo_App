import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tasktwo/item_name.dart';

class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final todoosList = ToDo.todoList();

  writeSecureData(String todroText, String value) async {
    await storage.write(key: 'todroText', value: jsonEncode(todoosList));
    String? stringOfItems = await storage.read(key: 'todroText');
    List<dynamic> todoText = jsonDecode(stringOfItems!);
    print(todroText);
  }
}
//   readSecureData(String todoText)async{
//     String value = await storage.read(key:todoText) ?? 'No data found';
//     print('Data read from secure storage: $value');
//   }
//   deleteSecureData(String todoText)async{
//    await storage.delete(key: todoText);
//   }
//
// }