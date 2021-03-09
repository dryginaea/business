class City {
  String name;
  String region;
  String city;
  String code;

  City(this.name, this.region, this.city, this.code);
}

class CityList {
  List<City> cityList;

  CityList(this.cityList);

  factory CityList.fromJson(Map<String, dynamic> json) {
    var list = List<City>();
    for(var com in json["suggestions"]) {
      String city;
      if (com['data']['settlement'] != null) city = com['data']['settlement'].toString();
      else city = com['data']['city'].toString();
      list.add(City(com['unrestricted_value'].toString(), com['data']['region_kladr_id'].toString().substring(0, 2), city, com['data']['postal_code'].toString()));
    }
    return CityList(list);
  }
}