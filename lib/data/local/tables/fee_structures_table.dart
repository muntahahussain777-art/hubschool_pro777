part of '../school_database.dart';

class FeeStructures extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get classroomId => integer().references(Classrooms, #id)();
  IntColumn get feeHeadId => integer().references(FeeHeads, #id)();
  IntColumn get amount => integer()();
  TextColumn get frequency => text().withDefault(const Constant('monthly'))();
  DateTimeColumn get effectiveFrom => dateTime()();
  DateTimeColumn get effectiveTo => dateTime().nullable()();
}
