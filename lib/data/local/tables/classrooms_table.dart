part of '../school_database.dart';

class Classrooms extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get section => text().withDefault(const Constant('A'))();
  IntColumn get academicYear => integer()();
}
