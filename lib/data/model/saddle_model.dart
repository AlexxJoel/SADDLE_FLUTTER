class SaddleModel{
  final int? id;
  final String brand;
  final String model;
  final String material;
  final String size;

  SaddleModel({
    this.id,
    required this.brand,
    required this.model,
    required this.material,
    required this.size
  });

  factory SaddleModel.fromJson(Map<dynamic, dynamic> json){
    return SaddleModel(
      id: json['id'],
      brand: json['brand'],
      model: json['model'],
      material: json['material'],
      size: json['size']
    );
  }

  Map<dynamic, dynamic> toJson(){
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'material': material,
      'size': size
    };
  }

}