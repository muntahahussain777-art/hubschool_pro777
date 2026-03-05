part of '../school_database.dart';

class RecycleBin extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType => text()();
  IntColumn get entityId => integer()();
  TextColumn get entityData => text()();
  DateTimeColumn get deletedAt => dateTime().withDefault(currentDateAndTime)();
}
