import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/models/uf.dart';

class Address {

  Address({ this.uf, this.cep, this.city, this.disctrict });

  UF uf;
  City city;
  String cep;
  String disctrict;

  @override
  String toString() {
    return 'Address: { uf: $uf, city: $city }';
  }

}