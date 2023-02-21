
class BookmarkData {
  late String id;
  late String photo;
  late String name;

  BookmarkData({
    required this.id,
    required this.name,
    required this.photo,
  });

  @override
  BookmarkData.fromJson(Map<String, dynamic> json) {
    photo = json['photo'];
    name = json['name'];
  }
}