import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final recordServiceProvider = Provider<RecordService>((ref) => RecordService());

class RecordService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadRecordImage(String patientId, File file) async {
    try {
      final fileName = '${const Uuid().v4()}.jpg';
      final ref = _storage.ref().child('medical_records').child(patientId).child(fileName);
      
      final uploadTask = await ref.putFile(file);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
