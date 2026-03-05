part of '../school_database.dart';

class FeeHeads extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get code => text().unique()();
  TextColumn get name => text()();
  BoolColumn get isDiscount => boolean().withDefault(const Constant(false))();
}
