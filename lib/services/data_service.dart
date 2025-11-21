import '../models/product.dart';
import '../models/order.dart';

class DataService {
  static List<Product> getProducts() {
    return [
      Product(
        id: '1',
        name: 'Gentle Foaming Cleanser',
        description: 'A mild, sulfate-free cleanser that removes makeup and impurities without stripping the skin. Perfect for daily use on all skin types.',
        price: 24.99,
        rating: 4.5,
        reviewCount: 127,
        images: [
          'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=500',
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=500',
        ],
        category: 'Cleansers',
        ingredients: ['Water', 'Sodium Cocoyl Glutamate', 'Glycerin', 'Chamomile Extract'],
        brand: 'SkinLux',
        skinType: 'All Skin Types',
        isTrending: true,
      ),
      Product(
        id: '2',
        name: 'Hydrating Vitamin C Serum',
        description: 'A potent vitamin C serum that brightens skin and provides antioxidant protection. Contains 15% L-ascorbic acid for maximum effectiveness.',
        price: 45.00,
        rating: 4.8,
        reviewCount: 89,
        images: [
          'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=500',
          'https://images.unsplash.com/photo-1608248543803-ba4f8c70ae0b?w=500',
        ],
        category: 'Serums',
        ingredients: ['L-Ascorbic Acid', 'Hyaluronic Acid', 'Vitamin E', 'Ferulic Acid'],
        brand: 'GlowTech',
        skinType: 'Normal to Dry',
        isTrending: true,
      ),
      Product(
        id: '3',
        name: 'Daily Moisturizer SPF 30',
        description: 'A lightweight, non-greasy moisturizer with broad-spectrum SPF 30 protection. Perfect for daily use under makeup.',
        price: 32.50,
        rating: 4.3,
        reviewCount: 156,
        images: [
          'https://images.unsplash.com/photo-1596755389378-c31d21fd1273?w=500',
          'https://images.unsplash.com/photo-1583958603298-2adeeceedd94?w=500',
        ],
        category: 'Moisturizers',
        ingredients: ['Zinc Oxide', 'Titanium Dioxide', 'Ceramides', 'Niacinamide'],
        brand: 'SunGuard',
        skinType: 'All Skin Types',
      ),
      Product(
        id: '4',
        name: 'Retinol Night Treatment',
        description: 'A gentle retinol formula that helps reduce fine lines and improves skin texture overnight. Start with 2-3 times per week.',
        price: 55.00,
        rating: 4.6,
        reviewCount: 78,
        images: [
          'https://images.unsplash.com/photo-1570194065650-d99fb4bedf0a?w=500',
          'https://images.unsplash.com/photo-1598300042247-d088f8ab3a91?w=500',
        ],
        category: 'Serums',
        ingredients: ['Retinol', 'Squalane', 'Vitamin E', 'Bisabolol'],
        brand: 'NightCare',
        skinType: 'Normal to Oily',
      ),
      Product(
        id: '5',
        name: 'Hydrating Face Mask',
        description: 'An intensely hydrating sheet mask infused with hyaluronic acid and botanical extracts. Use 2-3 times per week.',
        price: 18.99,
        rating: 4.4,
        reviewCount: 203,
        images: [
          'https://images.unsplash.com/photo-1516975080664-ed2fc6a32937?w=500',
          'https://images.unsplash.com/photo-1601049541289-9b1b7bbbfe19?w=500',
        ],
        category: 'Masks',
        ingredients: ['Hyaluronic Acid', 'Aloe Vera', 'Green Tea Extract', 'Collagen'],
        brand: 'MaskTech',
        skinType: 'Dry to Normal',
        isTrending: true,
      ),
      Product(
        id: '6',
        name: 'Balancing Toner',
        description: 'A pH-balancing toner that prepares skin for serums and moisturizers. Contains witch hazel and rose water.',
        price: 28.00,
        rating: 4.2,
        reviewCount: 94,
        images: [
          'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=500',
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=500',
        ],
        category: 'Toners',
        ingredients: ['Witch Hazel', 'Rose Water', 'Glycerin', 'Panthenol'],
        brand: 'PureTone',
        skinType: 'Oily to Combination',
      ),
    ];
  }
  
  static List<Product> getTrendingProducts() {
    return getProducts().where((product) => product.isTrending).toList();
  }
  
  static List<Product> getProductsByCategory(String category) {
    if (category == 'All') return getProducts();
    return getProducts().where((product) => product.category == category).toList();
  }
  
  static List<Product> searchProducts(String query) {
    return getProducts()
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.brand.toLowerCase().contains(query.toLowerCase()) ||
            product.category.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
  
  static Product? getProductById(String id) {
    try {
      return getProducts().firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
  
  static List<Product> getRelatedProducts(String productId, String category) {
    return getProducts()
        .where((product) => product.category == category && product.id != productId)
        .take(4)
        .toList();
  }
}