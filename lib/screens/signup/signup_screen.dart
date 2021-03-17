import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/error_box/error_box.dart';
import 'package:xlo_mobx/screens/signup/components/field_title.dart';
import 'package:xlo_mobx/stores/signup_store.dart';

class SignUpScreen extends StatelessWidget {

  final signUpStore = SignUpStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Observer(
                    builder: (_) {
                      return Padding(
                        child: ErrorBox(message: signUpStore.error),
                        padding: EdgeInsets.symmetric(vertical: 8),
                      );
                    }
                  ),
                  FieldTitle(title: 'Apelido', subtitle: 'Como aparecerá em seus anúncios'),
                  Observer(
                    builder: (_) {
                      return TextField(
                        enabled: !signUpStore.loading,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Exemplo: Breno Macêdo',
                          isDense: true,
                          errorText: signUpStore.nameError
                        ),
                        onChanged: signUpStore.setName,
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  FieldTitle(title: 'Email', subtitle: 'Enviaremos um e-mail de confirmação'),
                  Observer(builder: (_) {
                    return TextField(
                      enabled: !signUpStore.loading,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Exemplo: brenomacedo@gmail.com',
                        isDense: true,
                        errorText: signUpStore.emailError
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      onChanged: signUpStore.setEmail,
                    );
                  }),
                  SizedBox(height: 16),
                  FieldTitle(title: 'Celular', subtitle: 'Proteja sua conta'),
                  Observer(builder: (_) {
                    return TextField(
                      enabled: !signUpStore.loading,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Exemplo: (99) 99999-9999',
                        isDense: true,
                        errorText: signUpStore.phoneError
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter()
                      ],
                      onChanged: signUpStore.setPhone,
                    );
                  }),
                  SizedBox(height: 16),
                  FieldTitle(title: 'Senha', subtitle: 'Use letras, números e caracteres especiais'),
                  Observer(builder: (_) {
                    return TextField(
                      enabled: !signUpStore.loading,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(

                        ),
                        hintText: 'Exemplo: SenhaSegura898511',
                        isDense: true,
                        errorText: signUpStore.pass1Error
                      ),
                      obscureText: true,
                      onChanged: signUpStore.setPass1,
                    );
                  }),
                  SizedBox(height: 16),
                  FieldTitle(title: 'Confirmar a senha', subtitle: 'Repita a senha'),
                  Observer(builder: (_) {
                    return TextField(
                      enabled: !signUpStore.loading,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(

                        ),
                        hintText: 'Exemplo: SenhaSegura898511',
                        isDense: true,
                        errorText: signUpStore.pass2Error
                      ),
                      obscureText: true,
                      onChanged: signUpStore.setPass2,
                    );
                  }),
                  Observer(builder: (_) {
                    return Container(
                      margin: EdgeInsets.only(top: 20, bottom: 12),
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                            if(states.contains(MaterialState.disabled)) return Colors.grey;
                            return Colors.orange;
                          }),
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            )
                          )
                        ),
                        child: signUpStore.loading ? SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ) :
                          Text('Cadastrar', style: TextStyle(color: Colors.white)),
                        onPressed: signUpStore.signUpPressed,
                      ),
                    );
                  }),
                  Divider(color: Colors.black),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Já tem conta?', style: TextStyle(
                          fontSize: 16
                        )),
                        GestureDetector(
                          onTap: Navigator.of(context).pop,
                          child: Text('Entrar', style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.purple,
                            fontSize: 16
                          )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      )
    );
  }
}