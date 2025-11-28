import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/splash_screen.dart';
import 'utils/colors.dart';
import 'controllers/product_controller.dart';
import 'controllers/cart_controller.dart';
import 'controllers/wishlist_controller.dart';

void main() {
  runApp(const VkpglApp());
}

class VkpglApp extends StatelessWidget {
  const VkpglApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    Get.put(CartController());
    Get.put(WishlistController());
    
    return GetMaterialApp(
      title: 'VKPGL',
      theme: ThemeData(
        primarySwatch: MaterialColor(
          0xFFA5BD00,
          const <int, Color>{
            50: Color(0xFFF4F7CC),
            100: Color(0xFFE7ED99),
            200: Color(0xFFDAE266),
            300: Color(0xFFCDD833),
            400: Color(0xFFC0CE00),
            500: Color(0xFFA5BD00),
            600: Color(0xFF849700),
            700: Color(0xFF637100),
            800: Color(0xFF424B00),
            900: Color(0xFF212600),
          },
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}