
class UserData {
  late String id;
  late String email;
  late String photo;
  late bool isAdmin;
  late String namaDepan;
  late String namaBelakang;

  UserData({
    required this.id,
    required this.email,
    required this.photo,
    required this.isAdmin,
    required this.namaDepan,
    required this.namaBelakang,
  });

  @override
  UserData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    photo = json['photo'];
    namaDepan = json['namaDepan'];
    isAdmin = json['isAdmin'];
    namaBelakang = json['namaBelakang'];
  }
}