
class DetailProductData {
  late String id;
  late String descriptions;
  late String productId;
  late Map<String, dynamic> specifications;

  DetailProductData({
    required this.id,
    required this.productId,
    required this.descriptions,
  });

  @override
  DetailProductData.fromJson(Map<String, dynamic> json) {
    descriptions = json['descriptions'];
    productId = json['product_id'];
    specifications = json['specifications'];
  }
}