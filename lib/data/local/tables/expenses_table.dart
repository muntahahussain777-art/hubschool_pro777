part of '../school_database.dart';

class Expenses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().references(ExpenseCategories, #id)();
  IntColumn get amount => integer()();
  TextColumn get voucherNo => text().unique()();
  TextColumn get note => text().nullable()();
  DateTimeColumn get spentAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get approvedBy => integer().references(Users, #id).nullable()();
}
