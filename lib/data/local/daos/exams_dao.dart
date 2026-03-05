part of '../school_database.dart';

@DriftAccessor(tables: [Exams, ExamComponents, ExamMarks, GradeScales, Students])
class ExamsDao extends DatabaseAccessor<SchoolDatabase> with _$ExamsDaoMixin {
  ExamsDao(super.db);

  Stream<List<Exam>> watchExamsByClass(int classroomId) =>
      (select(exams)..where((e) => e.classroomId.equals(classroomId))).watch();

  Future<List<Exam>> getExamsByMonth(int year, int month) async {
    final all = await select(exams).get();
    return all
        .where((e) =>
            e.examDate != null &&
            e.examDate!.year == year &&
            e.examDate!.month == month)
        .toList()
      ..sort((a, b) => (b.examDate ?? DateTime(0)).compareTo(a.examDate ?? DateTime(0)));
  }

  Future<int> createExam(ExamsCompanion entry) => into(exams).insert(entry);

  Future<Exam?> getExamById(int id) async {
    return (select(exams)..where((e) => e.id.equals(id))).getSingleOrNull();
  }

  Future<List<ExamComponent>> getComponents(int examId) =>
      (select(examComponents)..where((c) => c.examId.equals(examId))).get();

  Future<void> upsertComponent(ExamComponentsCompanion entry) =>
      into(examComponents).insertOnConflictUpdate(entry);

  /// Upsert by (examId, studentId, componentId) to avoid unique constraint failure.
  Future<void> upsertMark(ExamMarksCompanion entry) async {
    final examId = entry.examId.value;
    final studentId = entry.studentId.value;
    final componentId = entry.componentId.value;
    if (examId == null || studentId == null || componentId == null) return;
    final existing = await (select(examMarks)
          ..where((m) =>
              m.examId.equals(examId) &
              m.studentId.equals(studentId) &
              m.componentId.equals(componentId)))
        .getSingleOrNull();
    if (existing != null) {
      await (update(examMarks)..where((m) => m.id.equals(existing.id)))
          .write(ExamMarksCompanion(marksObtained: entry.marksObtained));
    } else {
      await into(examMarks).insert(entry);
    }
  }

  Future<List<ExamMark>> getMarksForExam(int examId) =>
      (select(examMarks)..where((m) => m.examId.equals(examId))).get();

  Future<List<ExamMark>> getMarksForStudent(int studentId, int examId) =>
      (select(examMarks)
            ..where((m) => m.studentId.equals(studentId) & m.examId.equals(examId)))
          .get();

  Future<GradeScale?> getGradeForPercent(double percent) =>
      (select(gradeScales)
            ..where((g) => g.minPercent.isSmallerOrEqualValue(percent) & g.maxPercent.isBiggerOrEqualValue(percent)))
          .getSingleOrNull();

  Future<List<GradeScale>> getAllGrades() => select(gradeScales).get();

  /// Returns weighted total marks for a student in an exam
  Future<double> calculateStudentTotal(int studentId, int examId) async {
    final components = await getComponents(examId);
    final marks = await getMarksForStudent(studentId, examId);
    double total = 0;
    for (final comp in components) {
      final mark = marks.firstWhere(
        (m) => m.componentId == comp.id,
        orElse: () => ExamMark(
          id: -1, examId: examId, studentId: studentId,
          componentId: comp.id, marksObtained: 0,
        ),
      );
      total += mark.marksObtained * comp.weight;
    }
    return total;
  }

  Future<void> updateExam({
    required int examId,
    String? title,
    DateTime? examDate,
  }) async {
    await (update(exams)..where((e) => e.id.equals(examId))).write(
      ExamsCompanion(
        title: title != null ? Value(title) : const Value.absent(),
        examDate: examDate != null ? Value(examDate) : const Value.absent(),
      ),
    );
  }

  Future<void> deleteExam(int examId) async {
    await (delete(examMarks)..where((m) => m.examId.equals(examId))).go();
    await (delete(examComponents)..where((c) => c.examId.equals(examId))).go();
    await (delete(exams)..where((e) => e.id.equals(examId))).go();
  }

  Future<void> updateComponent({
    required int componentId,
    String? name,
    int? maxMarks,
    double? weight,
  }) async {
    await (update(examComponents)..where((c) => c.id.equals(componentId))).write(
      ExamComponentsCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        maxMarks: maxMarks != null ? Value(maxMarks) : const Value.absent(),
        weight: weight != null ? Value(weight) : const Value.absent(),
      ),
    );
  }

  Future<void> deleteComponent(int componentId) async {
    await (delete(examMarks)..where((m) => m.componentId.equals(componentId))).go();
    await (delete(examComponents)..where((c) => c.id.equals(componentId))).go();
  }
}
