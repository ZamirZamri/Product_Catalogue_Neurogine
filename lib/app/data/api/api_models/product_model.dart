class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final String thumbnail;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.thumbnail,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown Product',
      description: json['description'] ?? 'No description available',
      // Safely handle numbers that might be parsed as int instead of double
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      thumbnail: json['thumbnail'] ?? '',
      // Safely map the dynamic list to a List of Strings
      images: json['images'] != null ? List<String>.from(json['images']) : [],
    );
  }
}