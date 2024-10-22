class ProductDataModel {
  final int id;
  final String name;
  final double price;
  final String description;
  final String category;
  final bool inStock;
  final String imageUrl;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.inStock,
    required this.imageUrl,
  });

  // You can also add a factory constructor to create a product from a map (JSON parsing)
  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    return ProductDataModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      inStock: json['inStock'],
      imageUrl: json['image'],
    );
  }

  // You can also add a method to convert the Product to a map (JSON encoding)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'inStock': inStock,
      'image': imageUrl,
    };
  }
}
