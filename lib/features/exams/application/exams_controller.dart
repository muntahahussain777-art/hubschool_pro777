import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/local/school_database.dart';
import '../../../data/repositories/database_provider.dart';

final examsForClassProvider = StreamProvider.family<List<Exam>, int>((ref, classroomId) {
  return ref.watch(examsDaoProvider).watchExamsByClass(classroomId);
});

final examComponentsProvider = FutureProvider.family<List<ExamComponent>, int>((ref, examId) {
  return ref.watch(examsDaoProvider).getComponents(examId);
});

class MarksEntryController extends StateNotifier<AsyncValue<void>> {
  MarksEntryController(this._ref) : super(const AsyncValue.data(null));
  final Ref _ref;
  ExamsDao get _dao => _ref.read(examsDaoProvider);

  Future<void> saveMark({
    required int examId,
    required int studentId,
    required int componentId,
    required double marks,
  }) async {
    try {
      await _dao.upsertMark(
        ExamMarksCompanion(
          examId: Value(examId),
          studentId: Value(studentId),
          componentId: Value(componentId),
          marksObtained: Value(marks),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<String> getGradeForStudent(int studentId, int examId) async {
    final total = await _dao.calculateStudentTotal(studentId, examId);
    final components = await _dao.getComponents(examId);
    final maxTotal = components.fold<double>(0, (s, c) => s + c.maxMarks * c.weight);
    final percent = maxTotal == 0 ? 0.0 : (total / maxTotal) * 100;
    final grade = await _dao.getGradeForPercent(percent);
    return grade?.grade ?? 'N/A';
  }
}

final marksEntryControllerProvider =
    StateNotifierProvider<MarksEntryController, AsyncValue<void>>((ref) {
  return MarksEntryController(ref);
});
