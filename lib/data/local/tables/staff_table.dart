part of '../school_database.dart';

class Staff extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get employeeCode => text().unique()();
  TextColumn get fullName => text()();
  TextColumn get designation => text().withDefault(const Constant('Teacher'))();
  TextColumn get phone => text().nullable()();
  IntColumn get baseSalary => integer()();
  BoolColumn get biometricEnabled => boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get joiningDate => dateTime().withDefault(currentDateAndTime)();
}
