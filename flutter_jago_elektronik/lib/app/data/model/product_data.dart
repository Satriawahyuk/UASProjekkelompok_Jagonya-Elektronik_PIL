
class ProductData {
  late String id;
  late String categoryId;
  late String categoryName;
  late String name;
  late String photo;
  late int totalReview;
  late int totalStar;
  late double star;

  ProductData({
    required this.id,
    required this.name,
    required this.photo,
    required this.totalStar,
    required this.categoryId,
    required this.totalReview,
    required this.categoryName,
  });

  @override
  ProductData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    photo = json['photo'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    totalStar = json['total_start'];
    totalReview = json['total_review'];
    
    star = (totalStar/totalReview).toDouble();
    star = (star.isNaN) ? 0.0 : star;
  }
}