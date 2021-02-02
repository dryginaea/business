class Rate {
  String id;
  String price;
  String title;
  String description;
  String pros;
  String cons;
  String id_course;

  Rate(this.id, this.price, this.title, this.description, this.pros, this.cons, this.id_course);
}

class Rates {
  List<Rate> rates;

  Rates(this.rates);

  factory Rates.fromJson(List<dynamic> json) {
    var list = List<Rate>();
    list = json.map((e) {
      return Rate(e["id"].toString(), e["price"].toString(), e["title"].toString(), e["description"].toString(), e["pros"].toString(), e["cons"].toString(), e["id_course"].toString());
    }).toList();

    return Rates(list);
  }
}