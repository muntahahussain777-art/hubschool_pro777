import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../local/school_database.dart';

final schoolDatabaseProvider = Provider<SchoolDatabase>((ref) {
  final db = SchoolDatabase();
  ref.onDispose(db.close);
  return db;
});

// DAO providers
final studentsDaoProvider = Provider((ref) => ref.watch(schoolDatabaseProvider).studentsDao);
final feesDaoProvider = Provider((ref) => ref.watch(schoolDatabaseProvider).feesDao);
final staffDaoProvider = Provider((ref) => ref.watch(schoolDatabaseProvider).staffDao);
final examsDaoProvider = Provider((ref) => ref.watch(schoolDatabaseProvider).examsDao);
final expensesDaoProvider = Provider((ref) => ref.watch(schoolDatabaseProvider).expensesDao);
final syncDaoProvider = Provider((ref) => ref.watch(schoolDatabaseProvider).syncDao);
final dashboardDaoProvider = Provider((ref) => ref.watch(schoolDatabaseProvider).dashboardDao);
final settingsDaoProvider = Provider((ref) => ref.watch(schoolDatabaseProvider).settingsDao);
