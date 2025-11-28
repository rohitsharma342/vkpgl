import 'package:get/get.dart';
import '../models/product.dart';
import '../models/cart_item.dart';

class CartController extends GetxController {
  final RxList<CartItem> _items = <CartItem>[].obs;

  List<CartItem> get items => _items;
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalAmount => _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  bool get isEmpty => _items.isEmpty;

  void addToCart(Product product, {int quantity = 1}) {
    final existingItemIndex = _items.indexWhere((item) => item.product.id == product.id);
    
    if (existingItemIndex >= 0) {
      _items[existingItemIndex].quantity += quantity;
    } else {
      _items.add(CartItem(product: product, quantity: quantity));
    }
    
    Get.snackbar(
      'Added to Cart',
      '${product.name} has been added to your cart',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void removeFromCart(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
      return;
    }
    
    final itemIndex = _items.indexWhere((item) => item.product.id == productId);
    if (itemIndex >= 0) {
      _items[itemIndex].quantity = quantity;
    }
  }

  void clearCart() {
    _items.clear();
  }

  bool isInCart(String productId) {
    return _items.any((item) => item.product.id == productId);
  }

  int getProductQuantity(String productId) {
    final item = _items.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(product: Product(
        id: '',
        name: '',
        description: '',
        price: 0,
        category: '',
        images: [],
        rating: 0,
        reviewCount: 0,
        ingredients: [],
        inStock: false,
      ), quantity: 0),
    );
    return item.quantity;
  }
}