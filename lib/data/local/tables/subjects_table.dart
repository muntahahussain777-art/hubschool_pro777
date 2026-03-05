part of '../school_database.dart';

class Subjects extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get code => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
