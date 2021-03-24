import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:xlo_mobx/stores/edit_account_store.dart';

class EditAccountScreen extends StatelessWidget {

  final editAccStore = EditAccountStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LayoutBuilder(
                    builder: (_, constraints) {
                      return ToggleSwitch(
                        minWidth: constraints.biggest.width / 2.01,
                        labels: [
                          'Particular',
                          'Profissional'
                        ],
                        cornerRadius: 20,
                        activeBgColor: Colors.purple,
                        inactiveFgColor: Colors.white,
                        onToggle: editAccStore.setUserType,
                        initialLabelIndex: 0,
                      );
                    },
                  ),
                  SizedBox(height: 8),
                  Observer(builder: (_) {
                    return TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Nome*',
                        errorText: editAccStore.nameError
                      ),
                      onChanged: editAccStore.setName,
                    );
                  }),
                  SizedBox(height: 8),
                  Observer(builder: (_) {
                    return TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Telefone*',
                        errorText: editAccStore.phoneError
                      ),
                      onChanged: editAccStore.setPhone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter()
                      ],
                      keyboardType: TextInputType.number,
                    );
                  }),
                  SizedBox(height: 8),
                  Observer(builder: (_) {
                    return TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Nova senha*',
                        errorText: editAccStore.passError
                      ),
                      onChanged: editAccStore.setPass1,
                      obscureText: true,
                    );
                  }),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: 'Confirmar nova senha*'
                    ),
                    onChanged: editAccStore.setPass2,
                    obscureText: true,
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                          return Colors.orange;
                        }),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        )
                      ),
                      child: Text('Salvar', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 40,
                    child: Observer(builder: (_) {
                      return ElevatedButton(
                        onPressed: editAccStore.isFormValid ? () {} : null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                            return Colors.red;
                          }),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                          )
                        ),
                        child: Text('Sair', style: TextStyle(color: Colors.white)),
                      );
                    })
                  )
                ],
              ),
            ),
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        )
      ),
    );
  }
}