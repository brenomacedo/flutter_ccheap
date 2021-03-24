import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toggle_switch/toggle_switch.dart';

class EditAccountScreen extends StatelessWidget {
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
                        onToggle: (value) {

                        },
                        initialLabelIndex: 0,
                      );
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: 'Nome*'
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: 'Telefone*'
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: 'Nova senha*'
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: 'Confirmar nova senha*'
                    ),
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
                    ),
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