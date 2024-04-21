import 'package:equatable/equatable.dart';
import 'package:qr_code_example/data/models/product.dart';

abstract class ScanEvent extends Equatable {}

class ProductGetEvent extends ScanEvent {
  @override
  List<Object?> get props => [];
}

class ProductDeleteEvent extends ScanEvent {
  final int id;
  ProductDeleteEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class ProductInsertEvent extends ScanEvent {
  final ProductModel productModel;

  ProductInsertEvent({required this.productModel});

  @override
  List<Object?> get props => [productModel];
}

class ProductUpdateEvent extends ScanEvent {
  final ProductModel productModel;

  ProductUpdateEvent({required this.productModel});

  @override
  List<Object?> get props => [productModel];
}
