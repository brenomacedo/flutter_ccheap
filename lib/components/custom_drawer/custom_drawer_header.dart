import 'package:flutter/material.dart';
import 'package:xlo_mobx/screens/login/login_screen.dart';
import 'package:xlo_mobx/screens/signup/signup_screen.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SignUpScreen()
          )
        );
      },
      child: Container(
        height: 95,
        child: Row(
          children: [
            Icon(Icons.person, color: Colors.white, size: 35),
            SizedBox(width: 35),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Acesse sua conta', style: TextStyle(color: Colors.white,
                    fontSize: 16, fontWeight: FontWeight.w500)),
                  Text('Clique aqui', style: TextStyle(color: Colors.white,
                    fontSize: 14, fontWeight: FontWeight.w400))
                ],
              )
            )
          ],
        ),
        color: Colors.purple,
        padding: EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}