import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final bool isPaid;

  Product({
    String? id,
    required this.name,
    required this.price,
    required this.quantity,
    this.isPaid = false,
  }) : id = id ?? const Uuid().v4();

  Product copyWith({
    String? name,
    double? price,
    int? quantity,
    bool? isPaid,
  }) {
    return Product(
      id: id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      isPaid: isPaid ?? this.isPaid,
    );
  }

  @override
  List<Object?> get props => [id, name, price, quantity, isPaid];
}
