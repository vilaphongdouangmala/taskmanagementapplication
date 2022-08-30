import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductOrder {
  final int orderId;
  final Customer customer;
  final List<OrderItem> orderItems;
  final String orderDate;
  ProductOrder({
    required this.orderId,
    required this.customer,
    required this.orderItems,
    required this.orderDate,
  });

  ProductOrder copyWith({
    int? orderId,
    Customer? customer,
    List<OrderItem>? orderItems,
    String? orderDate,
  }) {
    return ProductOrder(
      orderId: orderId ?? this.orderId,
      customer: customer ?? this.customer,
      orderItems: orderItems ?? this.orderItems,
      orderDate: orderDate ?? this.orderDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'customer': customer.toMap(),
      'orderItems': orderItems.map((x) => x.toMap()).toList(),
      'orderDate': orderDate,
    };
  }

  factory ProductOrder.fromMap(Map<String, dynamic> map) {
    return ProductOrder(
      orderId: map['orderId'].toInt() as int,
      customer: Customer.fromMap(map['customer'] as Map<String, dynamic>),
      orderItems: List<OrderItem>.from(
        (map['orderItems'] as List<int>).map<OrderItem>(
          (x) => OrderItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      orderDate: map['orderDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductOrder.fromJson(String source) =>
      ProductOrder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductOrder(orderId: $orderId, customer: $customer, orderItems: $orderItems, orderDate: $orderDate)';
  }

  @override
  bool operator ==(covariant ProductOrder other) {
    if (identical(this, other)) return true;

    return other.orderId == orderId &&
        other.customer == customer &&
        listEquals(other.orderItems, orderItems) &&
        other.orderDate == orderDate;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        customer.hashCode ^
        orderItems.hashCode ^
        orderDate.hashCode;
  }
}

class Customer {
  final String firstName;
  final String lastName;
  Customer({
    required this.firstName,
    required this.lastName,
  });

  Customer copyWith({
    String? firstName,
    String? lastName,
  }) {
    return Customer(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Customer(firstName: $firstName, lastName: $lastName)';

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName && other.lastName == lastName;
  }

  @override
  int get hashCode => firstName.hashCode ^ lastName.hashCode;
}

class OrderItem {
  final int productId;
  final int qty;
  final double price;
  final String comment;
  OrderItem({
    required this.productId,
    required this.qty,
    required this.price,
    required this.comment,
  });

  OrderItem copyWith({
    int? productId,
    int? qty,
    double? price,
    String? comment,
  }) {
    return OrderItem(
      productId: productId ?? this.productId,
      qty: qty ?? this.qty,
      price: price ?? this.price,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'qty': qty,
      'price': price,
      'comment': comment,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'].toInt() as int,
      qty: map['qty'].toInt() as int,
      price: map['price'].toDouble() as double,
      comment: map['comment'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderItem(productId: $productId, qty: $qty, price: $price, comment: $comment)';
  }

  @override
  bool operator ==(covariant OrderItem other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.qty == qty &&
        other.price == price &&
        other.comment == comment;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        qty.hashCode ^
        price.hashCode ^
        comment.hashCode;
  }
}


// {
//   "orderId": 1,
//   "customer": {
//     "firstName": "John",
//     "lastName": "o"
//   },
//   "orderItems": [
//     {"productId": 1, "qty": 0, "price": 10.5, "comment": "comment"}
//   ],
//   "orderDate": "2022/08/30"
// }