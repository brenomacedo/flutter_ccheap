import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo_mobx/stores/cep_store.dart';

class CepField extends StatelessWidget {

  final CepStore cepStore = CepStore();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: cepStore.setCep,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CepInputFormatter()
      ],
      decoration: InputDecoration(
        labelText: 'CEP *',
        labelStyle: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.grey,
          fontSize: 18
        ),
        contentPadding: EdgeInsets.fromLTRB(16, 10, 12, 10)
      ),
    );
  }
}