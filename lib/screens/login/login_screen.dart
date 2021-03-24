import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/components/error_box/error_box.dart';
import 'package:xlo_mobx/screens/signup/signup_screen.dart';
import 'package:xlo_mobx/stores/login_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  void initState() {
    super.initState();

    when((_) => userManagerStore.user != null, () {
      Navigator.of(context).pop();
    });
  }

  final loginStore = LoginStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Entrar'),
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
                  Text('Acessar com o e-mail:', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.green[800])),
                  Observer(builder: (_) {
                    return Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: ErrorBox(message: loginStore.error)
                    );
                  }),
                  Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 4, top: 8),
                    child: Text('E-mail', style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w700,
                      fontSize: 16
                    )),
                  ),
                  Observer(builder: (_) {
                    return TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(

                        ),
                        isDense: true,
                        errorText: loginStore.emailError
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: loginStore.setEmail,
                      enabled: !loginStore.loading
                    );
                  }),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 4, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Senha', style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w700,
                          fontSize: 16
                        )),
                        GestureDetector(
                          child: Text('Esqueceu sua senha?',
                            style: TextStyle(decoration: TextDecoration.underline,
                            color: Colors.purple)),
                            onTap: () {

                            },
                        ),
                      ],
                    ),
                  ),
                  Observer(builder: (_) {
                    return TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(

                        ),
                        isDense: true,
                        errorText: loginStore.pass1Error
                      ),
                      obscureText: true,
                      onChanged: loginStore.setPass1,
                      enabled: !loginStore.loading
                    );
                  }),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 12),
                    height: 40,
                    child: Observer(builder: (_) {
                      return ElevatedButton(
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
                        child: loginStore.loading ? SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                          : Text('Entrar', style: TextStyle(color: Colors.white)),
                        onPressed: loginStore.isFormValid && !loginStore.loading ? loginStore.loginPressed : null,
                      );
                    })
                  ),
                  Divider(color: Colors.black),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text('Não tem uma conta?', style: TextStyle(fontSize: 16)),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => SignUpScreen())
                            );
                          },
                          child: Text('Cadastre-se', style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.purple,
                            fontSize: 16
                          )),
                        ),
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