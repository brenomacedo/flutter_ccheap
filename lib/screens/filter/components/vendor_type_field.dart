import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/filter/components/section_title.dart';
import 'package:xlo_mobx/stores/filter_store.dart';

class VendorTypeField extends StatelessWidget {

  VendorTypeField(this.filterStore);

  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle('Tipo de anunciante'),
        Observer(builder: (_) {
          return Wrap(
            runSpacing: 4,
            children: [
              GestureDetector(
                child: Container(
                  width: 130,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: filterStore.isTypeParticular ? Colors.purple : Colors.grey),
                    color: filterStore.isTypeParticular ? Colors.purple : Colors.transparent
                  ),
                  child: Text('Particular', style:
                    TextStyle(color: filterStore.isTypeParticular ? Colors.white: Colors.black)),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                ),
                onTap: () {
                  if(filterStore.isTypeParticular) {
                    if(filterStore.isTypeProfessional) {
                      filterStore.resetVendorType(VENDOR_TYPE_PARTICULAR);
                    } else {
                      filterStore.selectVendorType(VENDOR_TYPE_PROFESSIONAL);
                    }
                  } else {
                    filterStore.setVendorType(VENDOR_TYPE_PARTICULAR);
                  }
                },
              ),
              SizedBox(width: 12),
              GestureDetector(
                child: Container(
                  width: 130,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: filterStore.isTypeProfessional ? Colors.purple : Colors.grey),
                    color: filterStore.isTypeProfessional ? Colors.purple : Colors.transparent
                  ),
                  child: Text('Professional', style:
                    TextStyle(color: filterStore.isTypeProfessional ? Colors.white: Colors.black)),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                ),
                onTap: () {
                  if(filterStore.isTypeProfessional) {
                    if(filterStore.isTypeParticular) {
                      filterStore.resetVendorType(VENDOR_TYPE_PROFESSIONAL);
                    } else {
                      filterStore.selectVendorType(VENDOR_TYPE_PARTICULAR);
                    }
                  } else {
                    filterStore.setVendorType(VENDOR_TYPE_PROFESSIONAL);
                  }
                },
              )
            ],
          );
        })
      ],
    );
  }
}