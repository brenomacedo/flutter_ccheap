import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/screens/filter/components/order_by_field.dart';
import 'package:xlo_mobx/screens/filter/components/price_range_field.dart';
import 'package:xlo_mobx/screens/filter/components/vendor_type_field.dart';
import 'package:xlo_mobx/stores/home_store.dart';

class FilterScreen extends StatelessWidget {

  final filterStore = GetIt.I<HomeStore>().clonedFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtrar busca'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                OrderByField(filterStore),
                PriceRangeField(filterStore),
                VendorTypeField(filterStore),
                Observer(builder: (_) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 16),
                    height: 50,
                    child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                          if(states.contains(MaterialState.disabled))
                            return Colors.orange.withAlpha(120);
                          return Colors.orange;
                        })
                      ),
                      onPressed: filterStore.isFormValid ? () {
                        filterStore.save();
                        Navigator.of(context).pop();
                      } : null, child: Text('Filtrar', style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ))),
                  );
                })
              ],
            ),
          )
        ),
      ),
    );
  }
}