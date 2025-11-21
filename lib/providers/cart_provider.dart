import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  
  List<CartItem> get items => _items;
  
  int get itemCount => _items.fold(0, (total, item) => total + item.quantity);
  
  double get totalAmount => _items.fold(0.0, (total, item) => total + item.totalPrice);
  
  bool get isEmpty => _items.isEmpty;
  
  void addToCart(Product product, {int quantity = 1}) {
    final existingItemIndex = _items.indexWhere((item) => item.product.id == product.id);
    
    if (existingItemIndex >= 0) {
      _items[existingItemIndex].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    
    notifyListeners();
  }
  
  void removeFromCart(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }
  
  void updateQuantity(String productId, int quantity) {
    final itemIndex = _items.indexWhere((item) => item.product.id == productId);
    
    if (itemIndex >= 0) {
      if (quantity > 0) {
        _items[itemIndex].quantity = quantity;
      } else {
        _items.removeAt(itemIndex);
      }
      notifyListeners();
    }
  }
  
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
  
  bool isInCart(String productId) {
    return _items.any((item) => item.product.id == productId);
  }
  
  int getQuantity(String productId) {
    final item = _items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product(
        id: '',
        name: '',
        description: '',
        price: 0,
        rating: 0,
        reviewCount: 0,
        images: [],
        category: '',
        ingredients: [],
        brand: '',
        skinType: '',
      ), quantity: 0),
    );
    return item.quantity;
  }
}