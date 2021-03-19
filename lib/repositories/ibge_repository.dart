import 'package:dio/dio.dart';
import 'package:xlo_mobx/models/uf.dart';

class IBGERepository {


  Future<List<UF>> getUFListFromApi() async {
    const String endpoint = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

    try {
      final response = await Dio().get<List>(endpoint);
      final List<UF> ufList = response.data.map<UF>((j) => UF.fromJSON(j)).toList()..sort((a, b) {
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
      return ufList;
    } on DioError {
      return Future.error('Falha ao obter a lista de estados!');
    }
    

  }

  getCityListFromApi() {

  }

}