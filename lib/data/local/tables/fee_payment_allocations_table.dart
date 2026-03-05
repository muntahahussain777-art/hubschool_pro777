part of '../school_database.dart';

class FeePaymentAllocations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get paymentId => integer().references(FeePayments, #id)();
  IntColumn get invoiceId => integer().references(FeeInvoices, #id)();
  IntColumn get amount => integer()();
}
