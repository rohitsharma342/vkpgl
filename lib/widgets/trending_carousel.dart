import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/product.dart';
import '../screens/product_details_screen.dart';
import 'product_card.dart';

class TrendingCarousel extends StatelessWidget {
  final List<Product> products;

  const TrendingCarousel({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: products.length,
      options: CarouselOptions(
        height: 240,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        enlargeCenterPage: true,
        viewportFraction: 0.85,
        aspectRatio: 0.8,
      ),
      itemBuilder: (context, index, realIndex) {
        final product = products[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ProductCard(
            product: product,
            onTap: () => Get.to(() => ProductDetailsScreen(product: product)),
          ),
        );
      },
    );
  }
}