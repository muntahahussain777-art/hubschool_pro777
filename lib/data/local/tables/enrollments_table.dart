part of '../school_database.dart';

class Enrollments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get classroomId => integer().references(Classrooms, #id)();
  DateTimeColumn get enrolledOn => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get current => boolean().withDefault(const Constant(true))();
}
