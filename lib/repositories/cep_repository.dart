import 'package:dio/dio.dart';
import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/repositories/ibge_repository.dart';

class CEPRepository {

  Future<Address> getAddressFromApi(String cep) async {
    if(cep == null || cep.isEmpty)
      return Future.error('Cep inválido!');
    
    final clearCep = cep.replaceAll(RegExp('[^0-9]'), '');
    if(clearCep.length != 8)
      return Future.error('Cep inválido!');

    final endpoint = 'http://viacep.com.br/ws/$clearCep/json';

    try {

      final response = await Dio().get<Map>(endpoint);

      if(response.data.containsKey('erro') && response.data['erro'])
        return Future.error('Cep inválido!');
      
      final ufList = await IBGERepository().getUFList();

      return Address(
        cep: response.data['cep'],
        disctrict: response.data['bairro'],
        city: City(
          name: response.data['localidade']
        ),
        uf: ufList.firstWhere((st) => st.initials == response.data['uf'])
      );
    } catch(e) {
      return Future.error('Falha ao buscar CEP');
    }


  }

}