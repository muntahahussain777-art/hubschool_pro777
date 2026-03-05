import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../data/local/school_database.dart';
import '../../../data/repositories/database_provider.dart';

class StudentsController extends StateNotifier<AsyncValue<List<Student>>> {
  StudentsController(this._ref) : super(const AsyncValue.loading()) {
    _load();
  }

  final Ref _ref;
  StudentsDao get _dao => _ref.read(studentsDaoProvider);
  SyncDao get _sync => _ref.read(syncDaoProvider);

  void _load() {
    _dao.watchActiveStudents().listen(
      (list) => state = AsyncValue.data(list),
      onError: (e, st) => state = AsyncValue.error(e, st),
    );
  }

  Future<void> addStudent({
    required String fullName,
    required String fatherName,
    required String admissionNo,
    String? phone,
    String? address,
    DateTime? dob,
  }) async {
    final qrToken = const Uuid().v4();
    final companion = StudentsCompanion.insert(
      fullName: fullName,
      fatherName: fatherName,
      admissionNo: admissionNo,
      qrToken: qrToken,
      phone: Value(phone),
      address: Value(address),
      dob: Value(dob),
    );
    final id = await _dao.insertStudent(companion);
    await _sync.enqueue(
      entity: 'student',
      operation: 'insert',
      payloadJson: jsonEncode({
        'id': id,
        'full_name': fullName,
        'admission_no': admissionNo,
        'qr_token': qrToken,
      }),
    );
  }

  Future<void> toggleActive(Student student) async {
    await _dao.updateStudent(student.toCompanion(true).copyWith(isActive: Value(!student.isActive)));
  }
}

final studentsControllerProvider =
    StateNotifierProvider<StudentsController, AsyncValue<List<Student>>>((ref) {
  return StudentsController(ref);
});

final studentSearchProvider = StateProvider<String>((ref) => '');

final filteredStudentsProvider = Provider<AsyncValue<List<Student>>>((ref) {
  final query = ref.watch(studentSearchProvider);
  final all = ref.watch(studentsControllerProvider);
  if (query.isEmpty) return all;
  return all.whenData((list) => list
      .where((s) =>
          s.fullName.toLowerCase().contains(query.toLowerCase()) ||
          s.admissionNo.toLowerCase().contains(query.toLowerCase()))
      .toList());
});
