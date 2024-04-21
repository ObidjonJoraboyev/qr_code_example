import 'package:qr_code_example/data/models/product.dart';
import 'package:qr_code_example/local/local_database.dart';

class ProductRepository {
  List<ProductModel> list = [];

  Future<void> getProducts() async {
    list = await LocalDatabase.getAllTasks();
  }
}
