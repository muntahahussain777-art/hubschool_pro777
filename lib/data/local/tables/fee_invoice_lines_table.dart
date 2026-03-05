part of '../school_database.dart';

class FeeInvoiceLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get invoiceId => integer().references(FeeInvoices, #id)();
  IntColumn get feeHeadId => integer().references(FeeHeads, #id)();
  IntColumn get amount => integer()();
}
