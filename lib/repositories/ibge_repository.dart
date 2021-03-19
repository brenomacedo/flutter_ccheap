import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/models/uf.dart';

class IBGERepository {

  Future<List<UF>> getUFList() async {

    final preferences = await SharedPreferences.getInstance();
    if(preferences.containsKey('UF_LIST')) {
      final ufjson = json.decode(preferences.get('UF_LIST'));

      final List<UF> ufList = ufjson.map<UF>((j) => UF.fromJSON(j)).toList()..sort((UF a, UF b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

      return ufList;
    }

    const String endpoint = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

    try {
      final response = await Dio().get<List>(endpoint);
      preferences.setString('UF_LIST', json.encode(response.data));

      final List<UF> ufList = response.data.map<UF>((j) => UF.fromJSON(j)).toList()..sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

      return ufList;
    } on DioError {
      return Future.error('Falha ao obter a lista de estados!');
    }
    
  }

  Future<List<City>> getCityListFromApi(UF uf) async {

    try {
      final String endpoint = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados/${uf.id}/municipios';
      final response = await Dio().get<List>(endpoint);

      final List<City> cityList = response.data.map<City>((j) => City.fromJSON(j)).toList()..sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

      return cityList;
    } on DioError {
      return Future.error('Falha ao obter lista de cidades');
    }

  }

}