part of '../school_database.dart';

class TeacherAssignments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get staffId => integer().references(Staff, #id)();
  IntColumn get classroomId => integer().references(Classrooms, #id)();
  IntColumn get subjectId => integer().references(Subjects, #id)();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
        {staffId, classroomId, subjectId},
      ];
}
