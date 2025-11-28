import '../models/product.dart';

class DataService {
  static List<Product> getAllProducts() {
    return [
      Product(
        id: '1',
        name: 'Vitamin C Serum',
        description: 'A powerful antioxidant serum that brightens skin and reduces signs of aging.',
        price: 45.99,
        category: 'Serums',
        images: [
          'https://images.unsplash.com/photo-1556228453-efd6c1ff04f6?w=400',
          'https://images.unsplash.com/photo-1556229162-6b533eb75dce?w=400',
        ],
        rating: 4.5,
        reviewCount: 128,
        ingredients: ['Vitamin C', 'Hyaluronic Acid', 'Vitamin E'],
        inStock: true,
        isTrending: true,
      ),
      Product(
        id: '2',
        name: 'Moisturizing Cream',
        description: 'Rich moisturizing cream for dry and sensitive skin.',
        price: 32.50,
        category: 'Moisturizers',
        images: [
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
          'https://images.unsplash.com/photo-1570194065650-d99fb4bedf0a?w=400',
        ],
        rating: 4.2,
        reviewCount: 89,
        ingredients: ['Ceramides', 'Niacinamide', 'Glycerin'],
        inStock: true,
      ),
      Product(
        id: '3',
        name: 'Gentle Cleanser',
        description: 'pH-balanced cleanser suitable for all skin types.',
        price: 24.99,
        category: 'Cleansers',
        images: [
          'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400',
        ],
        rating: 4.3,
        reviewCount: 67,
        ingredients: ['Salicylic Acid', 'Tea Tree Oil', 'Aloe Vera'],
        inStock: true,
        isTrending: true,
      ),
      Product(
        id: '4',
        name: 'Retinol Night Cream',
        description: 'Anti-aging night cream with retinol for smoother skin.',
        price: 58.75,
        category: 'Night Care',
        images: [
          'https://images.unsplash.com/photo-1596755389378-c31d21fd1273?w=400',
        ],
        rating: 4.7,
        reviewCount: 156,
        ingredients: ['Retinol', 'Peptides', 'Shea Butter'],
        inStock: false,
      ),
      Product(
        id: '5',
        name: 'Hydrating Toner',
        description: 'Alcohol-free toner that hydrates and prepares skin.',
        price: 28.00,
        category: 'Toners',
        images: [
          'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=400',
        ],
        rating: 4.1,
        reviewCount: 45,
        ingredients: ['Rose Water', 'Witch Hazel', 'Glycerin'],
        inStock: true,
      ),
      Product(
        id: '6',
        name: 'Sunscreen SPF 50',
        description: 'Broad-spectrum sunscreen with SPF 50 protection.',
        price: 35.99,
        category: 'Sunscreens',
        images: [
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400',
        ],
        rating: 4.4,
        reviewCount: 92,
        ingredients: ['Zinc Oxide', 'Titanium Dioxide', 'Vitamin E'],
        inStock: true,
        isTrending: true,
      ),
    ];
  }

  static List<String> getCategories() {
    return ['All', 'Serums', 'Moisturizers', 'Cleansers', 'Night Care', 'Toners', 'Sunscreens'];
  }
}