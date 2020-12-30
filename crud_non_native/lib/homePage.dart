import 'package:crud_non_native/DB.dart';
import 'package:flutter/material.dart';

import 'addItemPage.dart';
import 'model/itemClass.dart';
import 'updateItemPage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Item>> futureItems;
  List<Item> items;
  DB db;

  _MyHomePageState() {
    this.db = DB();
    futureItems = db.getItems();
  }

  void _notifyChange() {
    futureItems = db.getItems();
    setState(() {});
  }

  void _notifyAdd(Map<String, dynamic> data) async{
    Item item = data['item'] as Item;
    int id = await data['id'];
    item.id = id;
    items.add(item);
    setState(() {});
  }

  void _notifyUpdate(Item item) {
    if (item == null)
      return;
    print(item);
    items.forEach((element) {
      if(element.id == item.id){
        element = item;
      }
    });
    setState(() {});
  }

  void _deleteItem(int id) {
    db.deleteItem(id);
    setState(() {});
  }

  void _navigateToAdd() async {
    final id = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddItemPage(db)))
        .then((data) => _notifyAdd(data));
  }

  void _navigateToUpdate(Item item) async {
    final id = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => UpdateItemPage(item, db)))
        .then((updatedItem) => _notifyUpdate(updatedItem));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        FloatingActionButton(
          heroTag: "refresh",
          onPressed: () {
            _notifyChange();
          },
          tooltip: 'Refresh',
          child: Icon(Icons.refresh),
        ), // This t],
      ]),
      body: FutureBuilder(
        future: futureItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            items = snapshot.data;
            return ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Container(
                      margin: EdgeInsets.all(8),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                      ),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,

                            children:<Widget>[
                              Text(
                                items[index].name,
                                textScaleFactor: 1.2,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                items[index].quantity,
                                textScaleFactor: 1.2,
                              ),
                            ],
                          )),
                    ),
                    onTap: () => _navigateToUpdate(items[index]),
                    onLongPress: () => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                          title: Text('Delete item'),
                          content: Text('Do you want to delete item ' +
                              items[index].name +
                              ' ?'),
                          actions: [
                            FlatButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            FlatButton(
                              child: Text('Yes'),
                              onPressed: () {
                                var id = items[index].id;
                                items.removeAt(index);
                                _deleteItem(id);
                                Navigator.pop(context);
                              },
                            ),
                          ]),
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        heroTag: "add",
        onPressed: () {
          _navigateToAdd();
        },
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }
}