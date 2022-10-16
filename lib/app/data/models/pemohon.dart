class Pemohon {
  final String? nama;
  final String? nik;
  final String? email;
  final String? nomorTelepon;
  final String uid;
  final String? created;
  bool? validasi;
  Pemohon({
    this.nama,
    this.nik,
    this.email,
    this.nomorTelepon,
    required this.uid,
    this.created,
    required this.validasi,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nama': nama,
      'nik': nik,
      'email': email,
      'nomor_telp': nomorTelepon,
      'cretedAt': created,
      'validasi': validasi
    };
  }

  static Pemohon fromJson(Map<String, dynamic> json) => Pemohon(
        uid: json['uid'],
        nama: json['nama'],
        email: json['email'],
        nomorTelepon: json['nomor_telp'],
        created: json['createdAt'],
        validasi: json['validasi'],
      );
}
