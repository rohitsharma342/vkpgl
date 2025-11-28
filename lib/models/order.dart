import 'cart_item.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final String shippingAddress;
  final String paymentMethod;
  final DateTime orderDate;
  final String status;

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.orderDate,
    this.status = 'Processing',
  });
}