import 'dart:async';
import 'package:crud_non_native/dao.dart';
import 'package:crud_non_native/model/itemClass.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Item])
abstract class ShoppingCartDatabase extends FloorDatabase {
  ItemDao get itemDao;
}