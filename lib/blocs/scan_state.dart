import 'package:equatable/equatable.dart';

import '../data/models/product.dart';

abstract class ScanState extends Equatable {
  const ScanState();
}

class ProductSuccessState extends ScanState {
  final List<ProductModel> products;

  const ProductSuccessState({required this.products});

  @override
  List<Object> get props => [products];
}
