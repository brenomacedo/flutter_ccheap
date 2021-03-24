import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/edit_account/edit_account_screen.dart';
import 'package:xlo_mobx/screens/my_ads/my_ads_screen.dart';
import 'package:xlo_mobx/stores/user_manager_store.dart';

class AccountScreen extends StatelessWidget {
  
  final userManager = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha conta'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 140,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Observer(builder: (_) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(userManager.user.name,
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 20,
                              fontWeight: FontWeight.w900
                            )),
                            Text(userManager.user.email,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700]
                            ))
                          ],
                        );
                      })
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        child: Text('Editar', style: TextStyle(color: Colors.purple)),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => EditAccountScreen())
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Meus anúncios',
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.w600
                )),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyAdsScreen()));
                },
              ),
              ListTile(
                title: Text('Favoritos',
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.w600
                )),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => MyAdsScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}