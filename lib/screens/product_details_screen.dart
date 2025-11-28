import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';
import '../controllers/product_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/wishlist_controller.dart';
import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/product_card.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final wishlistController = Get.find<WishlistController>();
    final productController = Get.find<ProductController>();
    final relatedProducts = productController.getRelatedProducts(product);
    final currentImageIndex = 0.obs;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.text),
              onPressed: () => Get.back(),
            ),
            actions: [
              Obx(() => IconButton(
                icon: Icon(
                  wishlistController.isInWishlist(product.id)
                      ? Icons.favorite
                      : Icons.favorite_outline,
                  color: wishlistController.isInWishlist(product.id)
                      ? Colors.red
                      : AppColors.text,
                ),
                onPressed: () => wishlistController.toggleWishlist(product),
              )),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 400,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        currentImageIndex.value = index;
                      },
                    ),
                    items: product.images.map((imageUrl) {
                      return CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => Container(
                          color: AppColors.surface,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.surface,
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: AppColors.textLight,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  if (product.images.length > 1)
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: product.images.asMap().entries.map((entry) {
                          return Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentImageIndex.value == entry.key
                                  ? AppColors.primary
                                  : Colors.white.withOpacity(0.5),
                            ),
                          );
                        }).toList(),
                      )),
                    ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.name, style: AppTextStyles.h2),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: product.rating,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${product.rating} (${product.reviewCount} reviews)',
                                  style: AppTextStyles.caption,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AppTextStyles.h2.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Description', style: AppTextStyles.h3),
                  const SizedBox(height: 8),
                  Text(product.description, style: AppTextStyles.body1),
                  const SizedBox(height: 24),
                  const Text('Key Ingredients', style: AppTextStyles.h3),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.ingredients.map((ingredient) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          ingredient,
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.text,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  if (relatedProducts.isNotEmpty) ...[
                    const Text('Related Products', style: AppTextStyles.h3),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 240,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        itemCount: relatedProducts.length,
                        itemBuilder: (context, index) {
                          final relatedProduct = relatedProducts[index];
                          return SizedBox(
                            width: 160,
                            child: ProductCard(
                              product: relatedProduct,
                              onTap: () {
                                Get.off(() => ProductDetailsScreen(product: relatedProduct));
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: CustomButton(
            text: product.inStock ? 'Add to Cart' : 'Out of Stock',
            onPressed: product.inStock
                ? () => cartController.addToCart(product)
                : null,
            isEnabled: product.inStock,
          ),
        ),
      ),
    );
  }
}