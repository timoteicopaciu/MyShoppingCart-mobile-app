import 'package:floor/floor.dart';

@Entity(tableName: 'items')
class Item {

  @primaryKey
  int id;

  String name;
  String quantity;
  String shop;
  String details;
  String status;

  // Item(this.id, this.name, this.quantity, this.shop, this.details, this.status);

  Item({this.id, this.name, this.quantity, this.shop, this.details, this.status});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as int,
      name: json['name'] as String,
      quantity: json['quantity'] as String,
      shop: json['shop'] as String,
      details: json['details'] as String,
      status: json['status'] as String,
    );
  }


  String toNiceString() {
    return name + '   ' + quantity;
  }

  @override
  String toString() {
    return 'Item{id: $id, name: $name, quantity: $quantity, shop: $shop, details: $details, status: $status}';
  }
}