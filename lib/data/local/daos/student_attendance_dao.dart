part of '../school_database.dart';

@DriftAccessor(tables: [StudentAttendance, Students])
class StudentAttendanceDao extends DatabaseAccessor<SchoolDatabase> with _$StudentAttendanceDaoMixin {
  StudentAttendanceDao(super.db);

  Future<void> markAttendance(StudentAttendanceCompanion entry) =>
      into(studentAttendance).insertOnConflictUpdate(entry);

  Stream<List<StudentAttendanceData>> watchTodayAttendance(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (select(studentAttendance)
          ..where((a) => a.date.isBiggerOrEqualValue(start) & a.date.isSmallerThanValue(end)))
        .watch();
  }

  Future<List<StudentAttendanceData>> getAttendanceForDate(DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (select(studentAttendance)
          ..where((a) => a.date.isBiggerOrEqualValue(start) & a.date.isSmallerThanValue(end)))
        .get();
  }

  Future<int> countPresentToday(DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    final rows = await (select(studentAttendance)
          ..where((a) =>
              a.date.isBiggerOrEqualValue(start) &
              a.date.isSmallerThanValue(end) &
              a.status.equals('present')))
        .get();
    return rows.length;
  }
}
