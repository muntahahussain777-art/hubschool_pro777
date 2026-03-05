part of '../school_database.dart';

class ExamComponents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get examId => integer().references(Exams, #id)();
  TextColumn get name => text()();
  RealColumn get weight => real().withDefault(const Constant(1.0))();
  IntColumn get maxMarks => integer()();
}
