class RekamanKtpModel {
  String? updatedTime;
  String? creationTime;
  String? desa;
  String? kecamatan;
  String? nama;
  String? email;
  String? nik;
  String? tglLahir;
  String? uid;
  String? urlImage;

  RekamanKtpModel(
      {this.updatedTime,
      this.creationTime,
      this.desa,
      this.kecamatan,
      this.nama,
      this.email,
      this.nik,
      this.tglLahir,
      this.uid,
      this.urlImage});

  RekamanKtpModel.fromJson(Map<String, dynamic> json) {
    updatedTime = json['updatedTime'];
    creationTime = json['creationTime'];
    desa = json['desa'];
    kecamatan = json['kecamatan'];
    nama = json['nama'];
    email = json['email'];
    nik = json['nik'];
    tglLahir = json['tgl_lahir'];
    uid = json['uid'];
    urlImage = json['url_image'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['updatedTime'] = updatedTime;
    data['creationTime'] = creationTime;
    data['desa'] = desa;
    data['kecamatan'] = kecamatan;
    data['nama'] = nama;
    data['email'] = email;
    data['nik'] = nik;
    data['tgl_lahir'] = tglLahir;
    data['uid'] = uid;
    data['url_image'] = urlImage;
    return data;
  }
}
