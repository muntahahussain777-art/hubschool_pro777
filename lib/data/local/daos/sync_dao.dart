part of '../school_database.dart';

@DriftAccessor(tables: [SyncQueue])
class SyncDao extends DatabaseAccessor<SchoolDatabase> with _$SyncDaoMixin {
  SyncDao(super.db);

  Future<void> enqueue({
    required String entity,
    required String operation,
    required String payloadJson,
  }) =>
      into(syncQueue).insert(
        SyncQueueCompanion.insert(
          entity: entity,
          operation: operation,
          payloadJson: payloadJson,
        ),
      );

  Future<List<SyncQueueData>> getPending() =>
      (select(syncQueue)
            ..where((s) => s.status.equals('pending'))
            ..orderBy([(s) => OrderingTerm.asc(s.createdAt)])
            ..limit(50))
          .get();

  Future<void> markSynced(int id) =>
      (update(syncQueue)..where((s) => s.id.equals(id)))
          .write(const SyncQueueCompanion(status: Value('synced')));

  Future<void> markFailed(int id, int retries) =>
      (update(syncQueue)..where((s) => s.id.equals(id))).write(
        SyncQueueCompanion(
          status: const Value('failed'),
          retryCount: Value(retries),
          lastTriedAt: Value(DateTime.now()),
        ),
      );

  Future<int> countPending() async {
    final count = countAll(filter: syncQueue.status.equals('pending'));
    final q = selectOnly(syncQueue)..addColumns([count]);
    return (await q.getSingle()).read(count) ?? 0;
  }
}
