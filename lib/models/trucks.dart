import 'dart:convert';

class Trucks {
  final String image;
  final String nameCode;
  final String id;

  Trucks({
    this.image,
    this.nameCode,
    this.id,
  });

  Trucks copyWith({
    String image,
    String nameCode,
    String id,
  }) {
    return Trucks(
      image: image ?? this.image,
      nameCode: nameCode ?? this.nameCode,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'nameCode': nameCode,
      'id': id,
    };
  }

  factory Trucks.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Trucks(
      image: map['image'],
      nameCode: map['nameCode'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Trucks.fromJson(String source) => Trucks.fromMap(json.decode(source));

  @override
  String toString() => 'Trucks(image: $image, nameCode: $nameCode, id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Trucks &&
        o.image == image &&
        o.nameCode == nameCode &&
        o.id == id;
  }

  @override
  int get hashCode => image.hashCode ^ nameCode.hashCode ^ id.hashCode;
}
