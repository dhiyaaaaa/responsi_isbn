class Registrasi {
  String? nama;
  String? email;
  String? password;

  Registrasi({this.nama, this.email, this.password});

  factory Registrasi.fromJson(Map<String, dynamic> json) {
    return Registrasi(
      nama: json['nama'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nama": this.nama,
      "email": this.email,
      "password": this.password,
    };
  }
}
