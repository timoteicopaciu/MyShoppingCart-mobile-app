import 'package:crud_non_native/radioButtonsWidget.dart';
import 'package:flutter/material.dart';

import 'DB.dart';
import 'model/itemClass.dart';

class UpdateItemPage extends StatelessWidget {
  Item _item;
  final nameText = TextEditingController();
  final quantityText = TextEditingController();
  final shopText = TextEditingController();
  final detailsText = TextEditingController();

  DB db;

  UpdateItemPage(Item item, DB db) {
    this.db = db;
    this._item = item;
    nameText.text = _item.name;
    quantityText.text = _item.quantity;
    shopText.text = _item.shop;
    detailsText.text = _item.details;
    radioButtonsStatus = _item.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Item'),
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
                  RadioButtonsWidget(),
                  RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text('Update'),
                    onPressed: () {
                      _item.name = nameText.text;
                      _item.quantity = quantityText.text;
                      _item.shop = shopText.text;
                      _item.details = detailsText.text;
                      _item.status = radioButtonsStatus;
                      db.updateItem(_item);
                      Navigator.pop(context, _item);
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
