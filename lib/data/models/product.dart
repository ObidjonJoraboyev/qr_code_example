class ProductModel {
  final String name;
  final int id;
  final String qrCode;

  ProductModel({
    required this.id,
    required this.name,
    required this.qrCode,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["_id"] as int? ?? 0,
      name: json["name"] as String? ?? "",
      qrCode: json["qr_code"] as String? ?? "",
    );
  }

  ProductModel copyWith({
    String? name,
    int? id,
    String? qrCode,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      qrCode: qrCode ?? this.qrCode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "qr_code": qrCode,
    };
  }
}
