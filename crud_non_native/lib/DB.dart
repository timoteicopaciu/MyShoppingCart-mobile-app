import 'package:crud_non_native/dao.dart';

import 'database.dart';
import 'model/itemClass.dart';

class DB{

  Future<ItemDao> itemDao;

  DB(){
      itemDao = getItemDao();
  }

  Future<ItemDao> getItemDao() async{
    final database = await $FloorShoppingCartDatabase.databaseBuilder('shopping_cart_database.db').build();
    final itemDao = database.itemDao;
    return itemDao;
  }

  Future<int> insertItem(Item item) async{
    ItemDao itemDao = await this.itemDao;
    return itemDao.insertItem(item);
  }

  Future<List<Item>> getItems() async{
    ItemDao itemDao = await this.itemDao;
    return itemDao.findAllItems();
  }

  Future<List<Item>> getItemByID(int id) async{
    ItemDao itemDao = await this.itemDao;
    return itemDao.findItemById(id);
  }

  Future<void> updateItem(Item item) async{
    ItemDao itemDao = await this.itemDao;
    itemDao.updateItem(item);
  }

  Future<void> deleteItem(int id) async{
    ItemDao itemDao = await this.itemDao;
    itemDao.delete(id);
  }
}