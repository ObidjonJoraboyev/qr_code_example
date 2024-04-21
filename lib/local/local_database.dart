import 'package:qr_code_example/data/models/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static final databaseInstance = LocalDatabase._();

  LocalDatabase._();

  factory LocalDatabase() {
    return databaseInstance;
  }

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _init("product.db");
      return _database!;
    }
  }

  Future<Database> _init(String databaseName) async {
    String internalPath = await getDatabasesPath();
    String path = join(internalPath, databaseName);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";

    await db.execute('''
    Create table product(
    _id $idType,
    name $textType,
    qr_code $textType
    )
    ''');
  }

  static Future<ProductModel> insertTask(ProductModel productModel) async {
    final db = await databaseInstance.database;
    int savedTaskID = await db.insert("product", productModel.toJson());
    return productModel.copyWith(id: savedTaskID);
  }

  static Future<ProductModel> updateTask(ProductModel productModel) async {
    final db = await databaseInstance.database;
    int savedTaskID = await db.update("product", productModel.toJson(),
        where: "_id = ?", whereArgs: [productModel.id]);
    return productModel.copyWith(id: savedTaskID);
  }

  static Future<List<ProductModel>> getAllTasks() async {
    final db = await databaseInstance.database;
    String orderBy = "_id DESC"; //"_id DESC"
    List json = await db.query("product", orderBy: orderBy);
    return json.map((e) => ProductModel.fromJson(e)).toList();
  }

  static Future<int> deleteTask(int id) async {
    final db = await databaseInstance.database;
    int deletedId = await db.delete(
      "product",
      where: "_id = ?",
      whereArgs: [id],
    );

    return deletedId;
  }
}
