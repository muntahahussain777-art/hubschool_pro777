import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';
import '../../data/repositories/database_provider.dart';

const _syncTaskName = 'hubschool_periodic_sync';
const _syncTaskTag  = 'com.hubschool.sync';

/// Call once from main()
Future<void> initSyncWorker() async {
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );
  await Workmanager().registerPeriodicTask(
    _syncTaskName,
    _syncTaskTag,
    frequency: const Duration(minutes: 15),
    constraints: Constraints(networkType: NetworkType.connected),
  );
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    return true;
  });
}

class SyncService {
  SyncService(this._ref);
  final Ref _ref;

  Future<void> trySyncNow() async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity.contains(ConnectivityResult.none) && connectivity.length == 1) return;

    final syncDao = _ref.read(syncDaoProvider);
    final pending = await syncDao.getPending();

    for (final item in pending) {
      try {
        await syncDao.markSynced(item.id);
      } catch (_) {
        await syncDao.markFailed(item.id, item.retryCount + 1);
      }
    }
  }
}

final syncServiceProvider = Provider((ref) => SyncService(ref));

final pendingSyncCountProvider = FutureProvider<int>((ref) {
  return ref.watch(syncDaoProvider).countPending();
});
