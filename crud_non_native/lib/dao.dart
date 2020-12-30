import 'package:crud_non_native/model/itemClass.dart';
import 'package:floor/floor.dart';

@dao
abstract class ItemDao {
  @insert
  Future<int> insertItem(Item item);

  @Query('SELECT * FROM items')
  Future<List<Item>> findAllItems();

  @Query('SELECT * FROM items WHERE id = :id')
  Future<List<Item>> findItemById(int id);

  @update
  Future<void> updateItem(Item item);


  @Query('DELETE FROM items WHERE id = :id')
  Future<void> delete(int id);
}