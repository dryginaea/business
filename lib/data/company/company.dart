class Company {
  String name;
  String inn;
  String kpp;

  Company(this.name, this.inn, this.kpp);
}

class CompanyList {
  List<Company> companyList;

  CompanyList(this.companyList);

  factory CompanyList.fromJson(Map<String, dynamic> json) {
    var list = List<Company>();
    for(var com in json["suggestions"]) {
      list.add(Company(com['value'].toString(), com['data']['inn'].toString(), com['data']['kpp'].toString()));
    }
    return CompanyList(list);
  }
}