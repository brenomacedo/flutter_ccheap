class UF {

  UF({ this.id, this.initials, this.name });

  int id;
  String initials;
  String name;

  factory UF.fromJSON(Map<String, dynamic> json) {
    return UF(id: json['id'], initials: json['sigla'], name: json['nome']);
  }

  @override
  String toString() {
    return 'UF: {id: $id, name: $name, initials: $initials}';
  }

}