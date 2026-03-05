part of '../school_database.dart';

class PayrollRuns extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get monthKey => text().unique()();
  DateTimeColumn get generatedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get generatedBy => integer().references(Users, #id)();
}
