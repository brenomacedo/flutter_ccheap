import 'package:flutter/material.dart';
import 'package:xlo_mobx/stores/my_ads_store.dart';

class MyAdsScreen extends StatefulWidget {
  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> with SingleTickerProviderStateMixin{

  TabController tabController;

  final myAdsStore = MyAdsStore();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
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
          Container(color: Colors.red,),
          Container(color: Colors.green,),
          Container(color: Colors.yellow,)
        ],
      ),
    );
  }
}