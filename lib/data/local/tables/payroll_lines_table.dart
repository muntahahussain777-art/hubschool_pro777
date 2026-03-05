part of '../school_database.dart';

class PayrollLines extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get payrollRunId => integer().references(PayrollRuns, #id)();
  IntColumn get staffId => integer().references(Staff, #id)();
  IntColumn get grossPay => integer()();
  IntColumn get advanceDeduction => integer().withDefault(const Constant(0))();
  IntColumn get absentDeduction => integer().withDefault(const Constant(0))();
  IntColumn get netPay => integer()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
}
