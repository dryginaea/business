class Interests {
  final Map<String, bool> interests;

  Interests(this.interests);

  factory Interests.fromJson(List<dynamic> json) {
    Map<String, bool> map = {
      "1": false,
      "2": false,
      "3": false,
      "4": false,
      "5": false,
      "6": false,
      "7": false,
      "8": false,

      "16": false,
      "17": false,
      "18": false,
      "19": false,
      "20": false,
      "21": false,
      "22": false,
      "23": false,
      "24": false,
      "25": false,
    };

    for(var e in json) {
      map[e["id_interest"]] = true;
    }

    return Interests(map);
  }
}