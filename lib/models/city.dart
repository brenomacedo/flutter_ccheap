class City {

  City({ this.name, this.id });

  int id;
  String name;

  factory City.fromJSON(Map<String, dynamic> json) {
    return City(id: json['id'] ,name: json['nome']);
  }

  @override
  String toString() {
    return 'City: {id: $id, name: $name}';
  }


}