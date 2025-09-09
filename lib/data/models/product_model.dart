import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String unit;

  @HiveField(3)
  final int priceCents;

  @HiveField(4)
  final int stock;

  ProductModel({
    required this.id,
    required this.name,
    required this.unit,
    required this.priceCents,
    required this.stock,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? unit,
    int? priceCents,
    int? stock,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      priceCents: priceCents ?? this.priceCents,
      stock: stock ?? this.stock,
    );
  }
}
