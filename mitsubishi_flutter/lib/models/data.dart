import 'dart:math';

import 'package:mistubishi_example_app/models/categories.dart';
import 'package:mistubishi_example_app/models/trucks.dart';

class LoadData {
  List<Trucks> initTrucks(int number) {
    List<Trucks> list = [];
    for (int i = 0; i < number; i++) {
      Trucks item = new Trucks(
          id: '$i',
          nameCode: 'FDFG($i)',
          image: 'assets/mitsubishi-forklift-truck-500x500.jpg');
      list.add(item);
    }
    return list;
  }

  List<Categories> initCategories() {
    List<Categories> list = [];

    var cate1 = new Categories(
        name: 'Internal Combustion Pnuematic Type Forklift Trucks',
        trucks: initTrucks(8));

    var cate2 = new Categories(
        name: 'Internal Combustion CushionTyre Forklift Trucks',
        trucks: initTrucks(2));

    var cate3 = new Categories(
        name: 'Electric Counterbalanced Pneumatic Tyre Forklift Trucks',
        trucks: initTrucks(4));

    var cate4 = new Categories(
        name: 'Warehouse - Power Pallet Trucks', trucks: initTrucks(10));

    var cate5 =
        new Categories(name: 'Warehouse - Stackers', trucks: initTrucks(3));

    list..add(cate1)..add(cate2)..add(cate3)..add(cate4)..add(cate5);

    for (int i = 0; i < 5; i++) {
      var cate = new Categories(
          name: 'Internal Combustion - Warehouse $i',
          trucks: initTrucks(1 + (new Random().nextInt(9))));
      list.add(cate);
    }
    return list;
  }
}
