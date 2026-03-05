import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/local/school_database.dart';
import '../../../data/repositories/database_provider.dart';

final staffListProvider = StreamProvider<List<StaffData>>((ref) {
  return ref.watch(staffDaoProvider).watchActiveStaff();
});

final todayAttendanceProvider = StreamProvider<List<StaffAttendanceData>>((ref) {
  final dao = ref.watch(staffDaoProvider);
  return dao.watchTodayAttendance(DateTime.now());
});

class StaffAttendanceController extends StateNotifier<AsyncValue<void>> {
  StaffAttendanceController(this._ref) : super(const AsyncValue.data(null));
  final Ref _ref;
  StaffDao get _dao => _ref.read(staffDaoProvider);

  Future<void> markPresent(int staffId, {bool biometric = false}) async {
    state = const AsyncValue.loading();
    try {
      await _dao.markAttendance(
        StaffAttendanceCompanion.insert(
          staffId: staffId,
          date: DateTime.now(),
          status: const Value('present'),
          biometricVerified: Value(biometric),
        ),
      );
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> markAbsent(int staffId) async {
    state = const AsyncValue.loading();
    try {
      await _dao.markAttendance(
        StaffAttendanceCompanion.insert(
          staffId: staffId,
          date: DateTime.now(),
          status: const Value('absent'),
        ),
      );
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final staffAttendanceControllerProvider =
    StateNotifierProvider<StaffAttendanceController, AsyncValue<void>>((ref) {
  return StaffAttendanceController(ref);
});
