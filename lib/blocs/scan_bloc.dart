import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_example/blocs/scan_event.dart';
import 'package:qr_code_example/blocs/scan_state.dart';
import 'package:qr_code_example/data/repositories/product_repository.dart';
import 'package:qr_code_example/local/local_database.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  ScanBloc() : super(const ProductSuccessState(products: [])) {
    on<ProductGetEvent>(getProducts);
    on<ProductInsertEvent>(addProducts);
    on<ProductDeleteEvent>(deleteProducts);
    on<ProductUpdateEvent>(updateProducts);
  }

  Future<void> getProducts(ProductGetEvent event, Emitter emit) async {
    await productRepository.getProducts();
    emit(ProductSuccessState(products: productRepository.list));
  }

  Future<void> addProducts(ProductInsertEvent event, Emitter emit) async {
    await LocalDatabase.insertTask(event.productModel);
    add(ProductGetEvent());
  }

  Future<void> deleteProducts(ProductDeleteEvent event, Emitter emit) async {
    await LocalDatabase.deleteTask(event.id);
    add(ProductGetEvent());
  }

  Future<void> updateProducts(ProductUpdateEvent event, Emitter emit) async {
    await LocalDatabase.updateTask(event.productModel);
    add(ProductGetEvent());
  }

  ProductRepository productRepository = ProductRepository();
}
