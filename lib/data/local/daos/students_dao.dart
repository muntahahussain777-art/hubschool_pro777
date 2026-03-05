part of '../school_database.dart';

@DriftAccessor(tables: [Students, Enrollments, Classrooms])
class StudentsDao extends DatabaseAccessor<SchoolDatabase> with _$StudentsDaoMixin {
  StudentsDao(super.db);

  Future<List<Student>> getAllStudents() => select(students).get();

  Stream<List<Student>> watchAllStudents() => select(students).watch();

  Stream<List<Student>> watchActiveStudents() =>
      (select(students)..where((s) => s.isActive.equals(true))).watch();

  Future<Student?> getById(int id) =>
      (select(students)..where((s) => s.id.equals(id))).getSingleOrNull();

  Future<Student?> getByQrToken(String token) =>
      (select(students)..where((s) => s.qrToken.equals(token))).getSingleOrNull();

  Future<int> insertStudent(StudentsCompanion entry) =>
      into(students).insert(entry);

  Future<bool> updateStudent(StudentsCompanion entry) =>
      update(students).replace(entry);

  Future<int> deleteStudent(int id) =>
      (delete(students)..where((s) => s.id.equals(id))).go();

  Future<List<Student>> getStudentsByClassroom(int classroomId) =>
      (select(students)
            ..where((s) => s.classroomId.equals(classroomId))
            ..orderBy([(s) => OrderingTerm.asc(s.fullName)]))
          .get();

  Future<List<Student>> searchStudents(String query) =>
      (select(students)
            ..where((s) =>
                s.fullName.lower().like('%${query.toLowerCase()}%') |
                s.admissionNo.lower().like('%${query.toLowerCase()}%')))
          .get();

  Stream<List<TypedResult>> watchStudentsWithClass() {
    final query = select(students).join([
      leftOuterJoin(enrollments, enrollments.studentId.equalsExp(students.id) & enrollments.current.equals(true)),
      leftOuterJoin(classrooms, classrooms.id.equalsExp(enrollments.classroomId)),
    ]);
    return query.watch();
  }

  Future<int> countStudents() async {
    final count = countAll();
    final query = selectOnly(students)..addColumns([count]);
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }
}
