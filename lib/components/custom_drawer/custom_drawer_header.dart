import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/screens/login/login_screen.dart';
import 'package:xlo_mobx/stores/page_store.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

class CustomDrawerHeader extends StatelessWidget {

  final userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        if(userManagerStore.isLoggedIn)
          return GetIt.I<PageStore>().setPage(4);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => LoginScreen()
          )
        );
      },
      child: Container(
        height: 95,
        child: Row(
          children: [
            Icon(Icons.person, color: Colors.white, size: 35),
            SizedBox(width: 35),
            Observer(builder: (_) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(userManagerStore.isLoggedIn ? userManagerStore.user.name : 'Acesse sua conta',
                      style: TextStyle(color: Colors.white,
                      fontSize: 16, fontWeight: FontWeight.w500)),
                    Text(userManagerStore.isLoggedIn ? userManagerStore.user.email : 'Clique aqui',
                      style: TextStyle(color: Colors.white,
                      fontSize: 14, fontWeight: FontWeight.w400))
                  ],
                )
              );
            })
          ],
        ),
        color: Colors.purple,
        padding: EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}