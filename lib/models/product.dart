class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final List<String> images;
  final double rating;
  final int reviewCount;
  final List<String> ingredients;
  final bool inStock;
  final bool isTrending;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.images,
    required this.rating,
    required this.reviewCount,
    required this.ingredients,
    required this.inStock,
    this.isTrending = false,
  });

  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? category,
    List<String>? images,
    double? rating,
    int? reviewCount,
    List<String>? ingredients,
    bool? inStock,
    bool? isTrending,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      images: images ?? this.images,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      ingredients: ingredients ?? this.ingredients,
      inStock: inStock ?? this.inStock,
      isTrending: isTrending ?? this.isTrending,
    );
  }
}