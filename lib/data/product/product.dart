class Product {
  final String id;
  final String name;
  final String image;
  final String description;
  final String cost_balls;
  final String count;

  Product(this.id, this.name, this.image, this.description, this.cost_balls, this.count);
}

class Products {
  final List<Product> products;

  Products({this.products});

  factory Products.fromJson(List<dynamic> json) {
    var list = List<Product>();
    list = json.map((product) {
      return Product(product["id"].toString(), product["name"].toString(), product["images"].toString(), product["description"].toString(), product["cost_balls"].toString(), product["count"].toString());
    }).toList();

    return Products(
        products: list
    );
  }
}