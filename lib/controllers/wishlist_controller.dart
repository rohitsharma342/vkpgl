import 'package:get/get.dart';
import '../models/product.dart';

class WishlistController extends GetxController {
  final RxList<Product> _items = <Product>[].obs;

  List<Product> get items => _items;
  bool get isEmpty => _items.isEmpty;
  int get itemCount => _items.length;

  void addToWishlist(Product product) {
    if (!_items.any((item) => item.id == product.id)) {
      _items.add(product);
      Get.snackbar(
        'Added to Wishlist',
        '${product.name} has been added to your wishlist',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void removeFromWishlist(String productId) {
    _items.removeWhere((item) => item.id == productId);
  }

  void toggleWishlist(Product product) {
    if (isInWishlist(product.id)) {
      removeFromWishlist(product.id);
    } else {
      addToWishlist(product);
    }
  }

  bool isInWishlist(String productId) {
    return _items.any((item) => item.id == productId);
  }

  void clearWishlist() {
    _items.clear();
  }
}