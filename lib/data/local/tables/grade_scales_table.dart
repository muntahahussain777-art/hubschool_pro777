part of '../school_database.dart';

class GradeScales extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get minPercent => real()();
  RealColumn get maxPercent => real()();
  TextColumn get grade => text()();
  TextColumn get remark => text().nullable()();
}
