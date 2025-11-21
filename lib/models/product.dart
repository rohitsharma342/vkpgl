class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final int reviewCount;
  final List<String> images;
  final String category;
  final List<String> ingredients;
  final bool isInStock;
  final bool isTrending;
  final String brand;
  final String skinType;
  
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.images,
    required this.category,
    required this.ingredients,
    this.isInStock = true,
    this.isTrending = false,
    required this.brand,
    required this.skinType,
  });
  
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
      images: List<String>.from(json['images']),
      category: json['category'],
      ingredients: List<String>.from(json['ingredients']),
      isInStock: json['isInStock'] ?? true,
      isTrending: json['isTrending'] ?? false,
      brand: json['brand'],
      skinType: json['skinType'],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'rating': rating,
      'reviewCount': reviewCount,
      'images': images,
      'category': category,
      'ingredients': ingredients,
      'isInStock': isInStock,
      'isTrending': isTrending,
      'brand': brand,
      'skinType': skinType,
    };
  }
}