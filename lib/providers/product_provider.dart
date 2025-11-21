import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/data_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  
  List<Product> get products => _filteredProducts;
  List<Product> get allProducts => _products;
  List<Product> get trendingProducts => _products.where((p) => p.isTrending).toList();
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  
  ProductProvider() {
    loadProducts();
  }
  
  void loadProducts() {
    _products = DataService.getProducts();
    _filteredProducts = _products;
    notifyListeners();
  }
  
  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }
  
  void searchProducts(String query) {
    _searchQuery = query;
    _applyFilters();
  }
  
  void _applyFilters() {
    List<Product> filtered = _products;
    
    // Apply category filter
    if (_selectedCategory != 'All') {
      filtered = filtered.where((product) => product.category == _selectedCategory).toList();
    }
    
    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((product) =>
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.brand.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.category.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
    
    _filteredProducts = filtered;
    notifyListeners();
  }
  
  Product? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
  
  List<Product> getRelatedProducts(String productId, String category) {
    return _products
        .where((product) => product.category == category && product.id != productId)
        .take(4)
        .toList();
  }
  
  void clearFilters() {
    _selectedCategory = 'All';
    _searchQuery = '';
    _filteredProducts = _products;
    notifyListeners();
  }
}