
class SimpleData {
  late String id;
  late String photo;
  late String name;

  SimpleData({
    required this.id,
    required this.name,
    required this.photo,
  });

  @override
  SimpleData.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    name = json['name'];
  }
}