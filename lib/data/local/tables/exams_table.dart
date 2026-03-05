part of '../school_database.dart';

class Exams extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get classroomId => integer().references(Classrooms, #id)();
  DateTimeColumn get examDate => dateTime().nullable()();
  BoolColumn get isPublished => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
