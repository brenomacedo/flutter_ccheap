import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
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
                  Padding(
                    padding: EdgeInsets.only(left: 3, bottom: 4, top: 8),
                    child: Text('E-mail', style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w700,
                      fontSize: 16
                    )),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(

                      ),
                      isDense: true
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
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
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(

                      ),
                      isDense: true
                    ),
                    obscureText: true
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 12),
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.orange),
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          )
                        )
                      ),
                      child: Text('Entrar', style: TextStyle(color: Colors.white)),
                      onPressed: () {

                      },
                    ),
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
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(builder: (_) => SignUpScreen())
                            // );
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