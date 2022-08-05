class Product {
  int? id;
  String? name;
  int? price;
  String? description;
  String? image;
  int? quantity;
  String? category;
  String? subcategory;
  String? type;
  String? size;
  String? color;

  Product(
      {this.id,
      this.name,
      this.price,
      this.description,
      this.image,
      this.quantity,
      this.category,
      this.subcategory,
      this.type,
      this.size,
      this.color});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    quantity = json['quantity'];
    category = json['category'];
    subcategory = json['subcategory'];
    type = json['type'];
    size = json['size'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['category'] = this.category;
    data['subcategory'] = this.subcategory;
    data['type'] = this.type;
    data['size'] = this.size;
    data['color'] = this.color;
    return data;
  }

  static List<Product> fromJsonList(List<dynamic> jsonLst) {
    List<Product> product = [];
    jsonLst.forEach((user) {
      product.add(Product.fromJson(user));
    });
    return product;
  }
}