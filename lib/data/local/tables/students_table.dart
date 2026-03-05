part of '../school_database.dart';

class Students extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get admissionNo => text().unique()();
  TextColumn get fullName => text()();
  TextColumn get fatherName => text()();
  DateTimeColumn get dob => dateTime().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get photoPath => text().nullable()();
  TextColumn get qrToken => text().unique()();
  IntColumn get classroomId => integer().nullable().references(Classrooms, #id)();
  IntColumn get monthlyFee => integer().withDefault(const Constant(0))();
  TextColumn get previousSchool => text().nullable()();
  TextColumn get gender => text().nullable()(); // 'male' or 'female'
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
