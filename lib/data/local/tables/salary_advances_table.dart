part of '../school_database.dart';

class SalaryAdvances extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get staffId => integer().references(Staff, #id)();
  IntColumn get amount => integer()();
  BoolColumn get deducted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get advancedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get note => text().nullable()();
}
