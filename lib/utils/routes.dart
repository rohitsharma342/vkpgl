import 'package:flutter/material.dart';
import '../screens/dashboard_screen.dart';
import '../screens/product_details_screen.dart';
import '../screens/shopping_cart_screen.dart';
import '../screens/checkout_screen.dart';

class AppRoutes {
  static const String dashboard = '/dashboard';
  static const String productDetails = '/product-details';
  static const String shoppingCart = '/shopping-cart';
  static const String checkout = '/checkout';
  
  static Map<String, WidgetBuilder> routes = {
    dashboard: (context) => const DashboardScreen(),
    shoppingCart: (context) => const ShoppingCartScreen(),
    checkout: (context) => const CheckoutScreen(),
  };
}