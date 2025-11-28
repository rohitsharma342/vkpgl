import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import '../controllers/product_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/wishlist_controller.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../widgets/category_tabs.dart';
import '../widgets/trending_carousel.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';
import 'product_details_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();
    final cartController = Get.find<CartController>();
    final wishlistController = Get.find<WishlistController>();
    final searchController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'VKPGL',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Obx(() => badges.Badge(
            badgeContent: Text(
              wishlistController.itemCount.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
            showBadge: wishlistController.itemCount > 0,
            child: IconButton(
              icon: const Icon(Icons.favorite_outline, color: AppColors.text),
              onPressed: () {
                Get.snackbar(
                  'Wishlist',
                  'Wishlist feature coming soon!',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
            ),
          )),
          Obx(() => badges.Badge(
            badgeContent: Text(
              cartController.itemCount.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
            showBadge: cartController.itemCount > 0,
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, color: AppColors.text),
              onPressed: () => Get.to(() => const CartScreen()),
            ),
          )),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: (value) => productController.searchProducts(value),
              decoration: InputDecoration(
                hintText: 'Search skincare products...',
                hintStyle: AppTextStyles.body2.copyWith(color: AppColors.textLight),
                prefixIcon: const Icon(Icons.search, color: AppColors.textLight),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CategoryTabs(),
                  const SizedBox(height: 24),
                  Obx(() {
                    if (productController.trendingProducts.isNotEmpty) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                const Text('Trending Products', style: AppTextStyles.h3),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('See All'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          TrendingCarousel(products: productController.trendingProducts),
                          const SizedBox(height: 24),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Obx(() => Text(
                          productController.selectedCategory == 'All'
                              ? 'All Products'
                              : productController.selectedCategory,
                          style: AppTextStyles.h3,
                        )),
                        const Spacer(),
                        Obx(() => Text(
                          '${productController.filteredProducts.length} items',
                          style: AppTextStyles.caption,
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Obx(() {
                    if (productController.filteredProducts.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: AppColors.textLight,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No products found',
                                style: AppTextStyles.h3,
                              ),
                              Text(
                                'Try adjusting your search or filters',
                                style: AppTextStyles.body2,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: productController.filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = productController.filteredProducts[index];
                          return ProductCard(
                            product: product,
                            onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
                          );
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}