import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/my_ads/components/active_tile.dart';
import 'package:xlo_mobx/screens/my_ads/components/pending_tile.dart';
import 'package:xlo_mobx/screens/my_ads/components/sold_tile.dart';
import 'package:xlo_mobx/stores/my_ads_store.dart';

class MyAdsScreen extends StatefulWidget {

  MyAdsScreen({this.initialPage = 0});

  final int initialPage;

  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> with SingleTickerProviderStateMixin{

  TabController tabController;

  final myAdsStore = MyAdsStore();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus anúncios'),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: Colors.orange,
          controller: tabController,
          tabs: [
            Tab(child: Text('Ativos')),
            Tab(child: Text('Pendentes')),
            Tab(child: Text('Vendidos'))
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          Observer(builder: (_) {
            if(myAdsStore.activeAds.isEmpty)
              return Container();
            
            return ListView.builder(
              itemCount: myAdsStore.activeAds.length,
              itemBuilder: (_, index) {
                return ActiveTile(myAdsStore.activeAds[index]);
              },
            );
          }),
          Observer(builder: (_) {
            if(myAdsStore.pendingAds.isEmpty)
              return Container();
            
            return ListView.builder(
              itemCount: myAdsStore.pendingAds.length,
              itemBuilder: (_, index) {
                return PendingTile(myAdsStore.pendingAds[index]);
              },
            );
          }),
          Observer(builder: (_) {
            if(myAdsStore.soldAds.isEmpty)
              return Container();
            
            return ListView.builder(
              itemCount: myAdsStore.soldAds.length,
              itemBuilder: (_, index) {
                return SoldTile(myAdsStore.soldAds[index]);
              },
            );
          }),
        ],
      ),
    );
  }
}