import 'package:crud_non_native/DB.dart';
import 'package:flutter/material.dart';

import 'model/itemClass.dart';

class AddItemPage extends StatelessWidget {
  final nameText = TextEditingController();
  final quantityText = TextEditingController();
  final shopText = TextEditingController();
  final detailsText = TextEditingController();

  DB db;

  AddItemPage(DB db) {
    this.db = db;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new item to Cart'),
        backgroundColor: Colors.blue,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextField(
                      controller: nameText,
                      decoration: InputDecoration(
                        labelText: 'Item name:',
                      ),
                    ),
                    TextField(
                      controller: quantityText,
                      decoration: InputDecoration(
                        labelText: 'Quantity:',
                      ),
                    ),
                    TextField(
                      controller: shopText,
                      decoration: InputDecoration(
                        labelText: 'Shop to go:',
                      ),
                    ),
                    Text(
                      'More details about this item:',
                      textScaleFactor: 1.3,
                    ),
                    TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 6,
                      maxLines: 6,
                      controller: detailsText,
                      decoration: InputDecoration(
                          hintText: 'Enter your details here',
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 5.0),
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text('Add item'),
                      onPressed: () {
                        var item = new Item(
                            id: null,
                            name: nameText.text,
                            quantity: quantityText.text,
                            shop: shopText.text,
                            details: detailsText.text,
                            status: 'toBuy');
                        var id = db.insertItem(item);

                        Map<String, dynamic> data = {'id': id, 'item': item};
                        // apiUtils.insertItem(new Item(id:null, name:nameText.text, quantity:quantityText.text,
                        //     shop: shopText.text, details: detailsText.text, status: 'toBuy'));
                        Navigator.pop<Map<String, dynamic>>(context, data);
                      },
                    )
                  ],
                ),
              ),
            ),
        );
      }),
    );
  }

  @override
  void dispose() {
    nameText.dispose();
    quantityText.dispose();
    shopText.dispose();
    detailsText.dispose();
  }
}
//
// void addItem(Item item) async{
//   final database = await $FloorShoppingCartDatabase.databaseBuilder('shopping_cart_database.db').build();
//   final itemDao = database.itemDao;
//   await itemDao.insertItem(item);
// }
