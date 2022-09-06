class Kontak {
  int? id;
  String? name;
  String? mobileno;
  String? email;
  String? company;

  Kontak({this.id, this.name, this.mobileno, this.email, this.company});
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['mobileno'] = mobileno;
    map['email'] = email;
    map['company'] = company;
    return map;
  }

  Kontak.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.mobileno = map['mobileno'];
    this.email = map['email'];
    this.company = map['company'];
  }
}
