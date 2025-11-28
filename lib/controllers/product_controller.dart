import 'package:get/get.dart';
import '../models/product.dart';
import '../services/data_service.dart';

class ProductController extends GetxController {
  final RxList<Product> _allProducts = <Product>[].obs;
  final RxList<Product> _filteredProducts = <Product>[].obs;
  final RxString _selectedCategory = 'All'.obs;
  final RxString _searchQuery = ''.obs;
  final RxList<String> _categories = <String>[].obs;

  List<Product> get allProducts => _allProducts;
  List<Product> get filteredProducts => _filteredProducts;
  String get selectedCategory => _selectedCategory.value;
  String get searchQuery => _searchQuery.value;
  List<String> get categories => _categories;
  List<Product> get trendingProducts => _allProducts.where((p) => p.isTrending).toList();

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  void loadProducts() {
    _allProducts.value = DataService.getAllProducts();
    _categories.value = DataService.getCategories();
    _filteredProducts.value = _allProducts;
  }

  void filterByCategory(String category) {
    _selectedCategory.value = category;
    _applyFilters();
  }

  void searchProducts(String query) {
    _searchQuery.value = query;
    _applyFilters();
  }

  void _applyFilters() {
    var products = _allProducts.toList();

    if (_selectedCategory.value != 'All') {
      products = products.where((p) => p.category == _selectedCategory.value).toList();
    }

    if (_searchQuery.value.isNotEmpty) {
      products = products.where((p) => 
        p.name.toLowerCase().contains(_searchQuery.value.toLowerCase()) ||
        p.description.toLowerCase().contains(_searchQuery.value.toLowerCase())
      ).toList();
    }

    _filteredProducts.value = products;
  }

  Product? getProductById(String id) {
    try {
      return _allProducts.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Product> getRelatedProducts(Product product) {
    return _allProducts
        .where((p) => p.category == product.category && p.id != product.id)
        .take(4)
        .toList();
  }
}