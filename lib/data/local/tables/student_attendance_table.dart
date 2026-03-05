part of '../school_database.dart';

class StudentAttendance extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  DateTimeColumn get date => dateTime()();
  TextColumn get status => text().withDefault(const Constant('present'))();
  BoolColumn get biometricVerified => boolean().withDefault(const Constant(false))();
  DateTimeColumn get timeIn => dateTime().nullable()();
  DateTimeColumn get timeOut => dateTime().nullable()();
  TextColumn get note => text().nullable()();
}
