part of '../school_database.dart';

class StaffAttendance extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get staffId => integer().references(Staff, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get status => text().withDefault(const Constant('present'))();
  BoolColumn get biometricVerified => boolean().withDefault(const Constant(false))();
  TextColumn get note => text().nullable()();
}
