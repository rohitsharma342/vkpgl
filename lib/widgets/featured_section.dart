import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Featured Collections',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _FeaturedCard(
                  title: 'Anti-Aging\nEssentials',
                  subtitle: '15+ Products',
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF9A9E), Color(0xFFFECFEF)],
                  ),
                  onTap: () {
                    Get.snackbar(
                      'Anti-Aging Collection',
                      'Showing anti-aging products',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
                const SizedBox(width: 16),
                _FeaturedCard(
                  title: 'Hydration\nBoost',
                  subtitle: '12+ Products',
                  gradient: const LinearGradient(
                    colors: [Color(0xFFA8EDEA), Color(0xFFFED6E3)],
                  ),
                  onTap: () {
                    Get.snackbar(
                      'Hydration Collection',
                      'Showing hydrating products',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
                const SizedBox(width: 16),
                _FeaturedCard(
                  title: 'Acne\nSolution',
                  subtitle: '8+ Products',
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD3A5), Color(0xFFFD9853)],
                  ),
                  onTap: () {
                    Get.snackbar(
                      'Acne Solution Collection',
                      'Showing acne treatment products',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Gradient gradient;
  final VoidCallback onTap;

  const _FeaturedCard({
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Explore',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}