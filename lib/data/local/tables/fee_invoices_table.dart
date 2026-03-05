part of '../school_database.dart';

class FeeInvoices extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get studentId => integer().references(Students, #id)();
  TextColumn get monthKey => text()();
  IntColumn get totalAmount => integer()();
  IntColumn get discountAmount => integer().withDefault(const Constant(0))();
  IntColumn get netAmount => integer()();
  IntColumn get paidAmount => integer().withDefault(const Constant(0))();
  IntColumn get dueAmount => integer()();
  TextColumn get status => text().withDefault(const Constant('unpaid'))();
  DateTimeColumn get dueDate => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
