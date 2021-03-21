import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/components/price_field.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class PriceRangeField extends StatelessWidget {

  PriceRangeField(this.filterStore);

  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('Preço'),
        Row(
          children: [
            PriceField('Min', filterStore.setMinPrice, filterStore.minPrice),
            SizedBox(width: 12),
            PriceField('Max', filterStore.setMaxPrice, filterStore.maxPrice),
          ],
        ),
        Observer(builder: (_) {
          if(filterStore.priceError != null)
            return Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(filterStore.priceError, style: TextStyle(
                color: Colors.red,
                fontSize: 12
              ))
            );
          return SizedBox();
        })
      ],
    );
  }
}