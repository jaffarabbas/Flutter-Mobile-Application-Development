import 'dart:convert';

class CatalogModels {
  static List<ItemModel> items = [
    ItemModel(
        id: 1,
        name: "iPhone 12 Pro",
        description: "Apple iPhone 12th generation",
        price: 999,
        color: "#33505a",
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRISJ6msIu4AU9_M9ZnJVQVFmfuhfyJjEtbUm3ZK11_8IV9TV25-1uM5wHjiFNwKy99w0mR5Hk&usqp=CAc")
  ];
}

class ItemModel {
  final int id;
  final String name;
  final String description;
  final num price;
  final String color;
  final String imageUrl;

  ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.color,
    required this.imageUrl
  });

  ItemModel copyWith({
    int? id,
    String? name,
    String? description,
    num? price,
    String? color,
    String? imageUrl,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      color: color ?? this.color,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'color': color,
      'imageUrl': imageUrl,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      color: map['color'],
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) => ItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ItemModel(id: $id, name: $name, description: $description, price: $price, color: $color, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ItemModel &&
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.price == price &&
      other.color == color &&
      other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      price.hashCode ^
      color.hashCode ^
      imageUrl.hashCode;
  }
}
