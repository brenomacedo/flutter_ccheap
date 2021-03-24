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
                      return Observer(builder: (_) {
                        return IgnorePointer(
                          ignoring: editAccStore.loading,
                          child: ToggleSwitch(
                            minWidth: constraints.biggest.width / 2.01,
                            labels: [
                              'Particular',
                              'Profissional'
                            ],
                            cornerRadius: 20,
                            activeBgColor: Colors.purple,
                            inactiveFgColor: Colors.white,
                            onToggle: editAccStore.setUserType,
                            initialLabelIndex: editAccStore.userType.index,
                          ),
                        );
                      });
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
                      initialValue: editAccStore.name,
                      onChanged: editAccStore.setName,
                      enabled: !editAccStore.loading,
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
                      initialValue: editAccStore.phone,
                      onChanged: editAccStore.setPhone,
                      enabled: !editAccStore.loading,
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
                      enabled: !editAccStore.loading,
                    );
                  }),
                  SizedBox(height: 8),
                  Observer(builder: (_) {
                    return TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Confirmar nova senha*'
                      ),
                      onChanged: editAccStore.setPass2,
                      obscureText: true,
                      enabled: !editAccStore.loading,
                    );
                  }),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 40,
                    child: Observer(builder: (_) {
                      return ElevatedButton(
                        onPressed: editAccStore.savePressed,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                            if(states.contains(MaterialState.disabled)) {
                              return Colors.orange.withAlpha(100);
                            }
                            return Colors.orange;
                          }),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                          )
                        ),
                        child: editAccStore.loading
                          ? Center(child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ))
                          : Text('Salvar', style: TextStyle(color: Colors.white)),
                      );
                    })
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                          return Colors.red;
                        }),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        )
                      ),
                      child: Text('Sair', style: TextStyle(color: Colors.white)),
                    )
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