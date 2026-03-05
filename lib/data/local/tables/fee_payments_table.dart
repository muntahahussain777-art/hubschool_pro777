part of '../school_database.dart';

class FeePayments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  IntColumn get amount => integer()();
  TextColumn get method => text().withDefault(const Constant('cash'))();
  TextColumn get referenceNo => text().nullable()();
  DateTimeColumn get paidAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get receivedBy => integer().references(Users, #id)();
}
