import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService {
  final _db = FirebaseDatabase.instance.ref();

  // ========================== PENGGUNA ==========================
  Future<void> addUser({
    required String idPengguna,
    required String email,
    required String password,
    required String idPerangkat,
  }) async {
    await _db.child("pengguna/$idPengguna").set({
      "email": email,
      "password": password,
      "id_perangkat": idPerangkat,
    });
  }

  Future<DataSnapshot> getUser(String idPengguna) async {
    return await _db.child("pengguna/$idPengguna").get();
  }

  // ========================== PERANGKAT IOT ==========================
  Future<void> addDevice({
    required String idPerangkat,
    required String tingkatKebisingan,
    required String intensitasCahaya,
    required String durasiBelajar,
    required String streamKey,
  }) async {
    await _db.child("perangkat_iot/$idPerangkat").set({
      "tingkat_kebisingan": tingkatKebisingan,
      "intensitas_cahaya": intensitasCahaya,
      "durasi_belajar": durasiBelajar,
      "stream_key": streamKey,
    });
  }

  Future<DataSnapshot> getDevice(String idPerangkat) async {
    return await _db.child("perangkat_iot/$idPerangkat").get();
  }

  // ========================== NOTIFIKASI ==========================
  Future<void> addNotification({
    required String idNotifikasi,
    required String idPengguna,
    required String waktuDikirim,
    required String jenisNotifikasi,
    required String pesan,
  }) async {
    await _db.child("notifikasi/$idNotifikasi").set({
      "id_pengguna": idPengguna,
      "waktu_dikirim": waktuDikirim,
      "jenis_notifikasi": jenisNotifikasi,
      "pesan": pesan,
    });
  }

  Future<DataSnapshot> getNotification(String idNotifikasi) async {
    return await _db.child("notifikasi/$idNotifikasi").get();
  }
}
