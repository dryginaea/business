class Company {
  String name;
  String inn;

  Company(this.name, this.inn);
}

class CompanyList {
  List<Company> companyList;

  CompanyList(this.companyList);

  factory CompanyList.fromJson(Map<String, dynamic> json) {
    var list = List<Company>();
    for(var com in json["suggestions"]) {
      list.add(Company(com['value'].toString(), com['data']['inn'].toString()));
    }
    return CompanyList(list);
  }
}