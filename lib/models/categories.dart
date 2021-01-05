import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mistubishi_example_app/models/trucks.dart';

class Categories {
  final String name;
  final List<Trucks> trucks;
  Categories({
    this.name,
    this.trucks,
  });

  Categories copyWith({
    String name,
    List<Trucks> trucks,
  }) {
    return Categories(
      name: name ?? this.name,
      trucks: trucks ?? this.trucks,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'trucks': trucks?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory Categories.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Categories(
      name: map['name'],
      trucks: List<Trucks>.from(map['trucks']?.map((x) => Trucks.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Categories.fromJson(String source) =>
      Categories.fromMap(json.decode(source));

  @override
  String toString() => 'Catogaries(name: $name, trucks: $trucks)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Categories && o.name == name && listEquals(o.trucks, trucks);
  }

  @override
  int get hashCode => name.hashCode ^ trucks.hashCode;
}
