import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MyCache {
  static loadAlias(TextEditingController controller) async {
    Box box = await Hive.openBox('db');
    var userAliasCache = box.get('user_alias');
    if (userAliasCache != null) {
      controller.text = userAliasCache as String;
    }
  }

  static cacheAlias(String alias) async {
    Box box = await Hive.openBox('db');
    box.put('user_alias', alias);
  }
}
