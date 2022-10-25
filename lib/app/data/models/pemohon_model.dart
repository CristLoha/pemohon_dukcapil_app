class Pemohon {
  String? uid;
  String? email;
  String? nama;
  String? nik;
  String? nomorTelp;
  bool? validasi;
  String? updatedTime;
  String? creationTime;
  String? lastSignTime;

  Pemohon(
      {this.uid,
      this.email,
      this.nama,
      this.nik,
      this.nomorTelp,
      this.validasi,
      this.updatedTime,
      this.creationTime,
      this.lastSignTime});

  Pemohon.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    nama = json['nama'];
    nik = json['nik'];
    nomorTelp = json['nomor_telp'];
    validasi = json['validasi'];
    updatedTime = json['updatedTime'];
    creationTime = json['creationTime'];
    lastSignTime = json['lastSignTime'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['email'] = email;
    data['nama'] = nama;
    data['nik'] = nik;
    data['nomor_telp'] = nomorTelp;
    data['validasi'] = validasi;
    data['updatedTime'] = updatedTime;
    data['creationTime'] = creationTime;
    data['lastSignTime'] = lastSignTime;
    return data;
  }
}
