part of '../school_database.dart';

@DriftAccessor(tables: [Classrooms, Subjects, TeacherAssignments, Staff])
class SettingsDao extends DatabaseAccessor<SchoolDatabase> with _$SettingsDaoMixin {
  SettingsDao(super.db);

  // Classrooms
  Stream<List<Classroom>> watchClassrooms() =>
      (select(classrooms)..orderBy([(c) => OrderingTerm.asc(c.name)])).watch();

  Future<List<Classroom>> getAllClassrooms() =>
      (select(classrooms)..orderBy([(c) => OrderingTerm.asc(c.name)])).get();

  Future<int> insertClassroom(ClassroomsCompanion entry) => into(classrooms).insert(entry);

  Future<void> deleteClassroom(int id) =>
      (delete(classrooms)..where((c) => c.id.equals(id))).go();

  // Subjects
  Stream<List<Subject>> watchSubjects() =>
      (select(subjects)..where((s) => s.isActive.equals(true))..orderBy([(s) => OrderingTerm.asc(s.name)])).watch();

  Future<List<Subject>> getAllSubjects() =>
      (select(subjects)..where((s) => s.isActive.equals(true))).get();

  Future<int> insertSubject(SubjectsCompanion entry) => into(subjects).insert(entry);

  Future<void> deleteSubject(int id) =>
      (update(subjects)..where((s) => s.id.equals(id))).write(const SubjectsCompanion(isActive: Value(false)));

  // Teacher Assignments
  Stream<List<TeacherAssignment>> watchAssignments() =>
      (select(teacherAssignments)..where((a) => a.isActive.equals(true))).watch();

  Future<int> insertAssignment(TeacherAssignmentsCompanion entry) =>
      into(teacherAssignments).insertOnConflictUpdate(entry);

  Future<void> deleteAssignment(int id) =>
      (update(teacherAssignments)..where((a) => a.id.equals(id)))
          .write(const TeacherAssignmentsCompanion(isActive: Value(false)));

  Future<List<TypedResult>> getAssignmentsWithDetails() {
    final q = select(teacherAssignments).join([
      innerJoin(staff, staff.id.equalsExp(teacherAssignments.staffId)),
      innerJoin(classrooms, classrooms.id.equalsExp(teacherAssignments.classroomId)),
      innerJoin(subjects, subjects.id.equalsExp(teacherAssignments.subjectId)),
    ])..where(teacherAssignments.isActive.equals(true));
    return q.get();
  }
}
